LOCAL_APPLICATION_TESTS_DIR ?= $(LOCAL_DIR)/application/tests

LOCAL_LOCAL_APPLICATION_TESTS_IMAGE_DOCKER_BUILDX_LOCAL_CACHE ?= $(LOCAL_DIR)/.containers/docker-buildx-cache/application-tests
$(LOCAL_LOCAL_APPLICATION_TESTS_IMAGE_DOCKER_BUILDX_LOCAL_CACHE):;	@mkdir -p "$@"
ifneq ($(wildcard $(LOCAL_LOCAL_APPLICATION_TESTS_IMAGE_DOCKER_BUILDX_LOCAL_CACHE)/index.json),)
LOCAL_LOCAL_APPLICATION_TESTS_IMAGE_DOCKER_BUILDX_LOCAL_CACHE_READ = type=local,src=$(LOCAL_LOCAL_APPLICATION_TESTS_IMAGE_DOCKER_BUILDX_LOCAL_CACHE)
endif
LOCAL_LOCAL_APPLICATION_TESTS_IMAGE_DOCKER_BUILDX_LOCAL_CACHE_WRITE= type=local,dest=$(LOCAL_LOCAL_APPLICATION_TESTS_IMAGE_DOCKER_BUILDX_LOCAL_CACHE)
LOCAL_APPLICATION_TESTS_IMAGE = ${PRIVATE_IMAGES_BASE}:application-tests-latest

local-application-tests-docker-compose-up: local-application-tests-docker-compose-rm
	@VERSION=latest $(LOCAL_DIR)/application-tests/docker-compose-up.sh &
	@$(LOCAL_DOCKER_COMPOSE) logs application-tests
	@echo
	@echo Started Application tests display: 
	@echo Run "'make $(@:%-up=%-logs)'" to retrieve more logs

local-application-tests-docker-compose-run: 
	@$(LOCAL_DOCKER_COMPOSE) exec application-tests rf
.PHONY: application-tests-docker-compose-run

local-application-tests-check-env:
	@echo Checking application tests environment validity	
	$(LOCAL_DOCKER_COMPOSE) exec application-tests bash $(LOCAL_APPLICATION_TESTS_DIR)/check_env.sh
.PHONY: local-application-tests-check-env
