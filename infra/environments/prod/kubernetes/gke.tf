# Enables required APIs.
resource "google_project_service" "google_k8s_cluster_services" {
  project = var.project_id
  for_each = toset([
    "container.googleapis.com",
    "iamcredentials.googleapis.com",
  ])
  service = each.key

  # Don't disable the service if the resource block is removed by accident.
  disable_on_destroy         = false
  disable_dependent_services = true
}

resource "google_service_account" "cluster_node_sa" {
  account_id   = "vault-node-sa"
  display_name = "Vault Node Pool SA"
}

output "node_service_account" {
  value = google_service_account.cluster_node_sa.email
}

resource "google_project_iam_member" "cloud_service_member" {
  for_each = toset([
    "roles/compute.admin",
    "roles/compute.instanceAdmin.v1",
    "roles/compute.networkAdmin"
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com"
}

resource "google_service_account_iam_member" "name" {
  service_account_id = google_service_account.cluster_node_sa.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com"
}

resource "google_container_cluster" "vault_cluster" {
  depends_on = [
    google_project_service.google_k8s_cluster_services,
    google_project_iam_member.cloud_service_member
  ]
  name                = "vault-cluster"
  location            = var.region
  initial_node_count  = 1
  deletion_protection = false
  node_locations      = ["europe-west1-b", "europe-west1-c"] # évite la d !
  node_config {
    service_account = google_service_account.cluster_node_sa.email
    machine_type    = "e2-small"
    disk_size_gb    = 30
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
  networking_mode = "VPC_NATIVE"
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  remove_default_node_pool = true
}

resource "google_container_node_pool" "vault_cluster_nodes" {
  name     = "vault-cluster-pool"
  location = var.region
  cluster  = google_container_cluster.vault_cluster.name

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 30

    service_account = google_service_account.cluster_node_sa.email

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 3
}

resource "kubernetes_service_account" "input_images_workers" {
  metadata {
    name      = "input-images-workers"
    namespace = "default"
    annotations = {
      "iam.gke.io/gcp-service-account" = var.input_images_workers_sa_email
    }
  }
}
