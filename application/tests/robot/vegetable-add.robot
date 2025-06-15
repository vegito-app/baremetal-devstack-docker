*** Settings ***
Library          AppiumLibrary
Resource         ../resources/keywords.robot
Library           AppiumLibrary
Library           Collections
# Suite Setup      Firebase.purge_test_vegetables
Test Setup        Reset State And Return Home

*** Variables ***
${REMOTE_URL}     http://android-studio:4723
${PLATFORM_NAME}  Android
${APP_PACKAGE}    dev.mobile.app.android
${APP_ACTIVITY}   .MainActivity

*** Test Cases ***
Ajouter une carotte depuis l’interface
    Push Test Image    carrotes.jpeg

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=🧺 Vendre mes légumes
    Click Element    accessibility_id=🧺 Vendre mes légumes

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Choisir une photo
    Click Element    accessibility_id=Choisir une photo

    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Photos"]
    Click Element                       xpath=//android.widget.TextView[@text="Photos"]
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Device folders"]
    Wait Until Page Contains Element    xpath=(//android.widget.RelativeLayout)[1]
    Click Element                       xpath=(//android.widget.RelativeLayout)[1]
    Wait Until Page Contains Element    xpath=(//android.view.ViewGroup[@clickable="true"])[2]
    Click Element                       xpath=(//android.view.ViewGroup[@clickable="true"])[2]

    Wait Until Keyword Succeeds    10x    1s    Page Should Contain Element    xpath=(//android.widget.EditText)[1]

    Click Element    accessibility_id=dropdown-sale-type\nÀ l’unité
    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Au poids (€/kg)
    Click Element    accessibility_id=Au poids (€/kg)

    Fill Field By Index    1    Carotte
    Fill Field By Index    2    Fraîche du jardin
    Fill Field By Index    3    500
    Fill Field By Index    4    250

    Swipe Until Element Is Visible    accessibility_id=Enregistrer

    # Go Back
    Wait Until Page Contains Element    accessibility_id=🧺 Vendre mes légumes
    Click Element                       accessibility_id=🧺 Vendre mes légumes
    Wait Until Keyword Succeeds    10x    1s    Page Should Contain Element    accessibility_id=Carotte\n500g - 2.5€\nFraîche du jardin
    Go Back

Ajouter un chouchou avec plusieurs images depuis l’interface
    Push Test Image    chouchou-coupe.jpg
    Push Test Image    chouchou-fin.jpeg
    Push Test Image    chouchou-macro.jpeg
    Push Test Image    chouchou-salazie.jpeg

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=🧺 Vendre mes légumes
    Click Element    accessibility_id=🧺 Vendre mes légumes

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Choisir une photo
    Click Element    accessibility_id=Choisir une photo

    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Photos"]
    Click Element                       xpath=//android.widget.TextView[@text="Photos"]
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Device folders"]
    Wait Until Page Contains Element    xpath=(//android.widget.RelativeLayout)[1]
    Click Element                       xpath=(//android.widget.RelativeLayout)[1]
    Wait Until Page Contains Element    xpath=(//android.view.ViewGroup[@clickable="true"])[2]
    Click Element                       xpath=(//android.view.ViewGroup[@clickable="true"])[2]

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Ajouter une photo
    Click Element    accessibility_id=Ajouter une photo

    # Ajout deuxième image
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Photos"]
    Click Element                       xpath=//android.widget.TextView[@text="Photos"]
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Device folders"]
    Wait Until Page Contains Element    xpath=(//android.widget.RelativeLayout)[1]
    Click Element                       xpath=(//android.widget.RelativeLayout)[1]
    Wait Until Page Contains Element    xpath=(//android.view.ViewGroup[@clickable="true"])[3]
    Click Element                       xpath=(//android.view.ViewGroup[@clickable="true"])[3] 

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Ajouter une photo
    Click Element    accessibility_id=Ajouter une photo

    # Ajout troisième image
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Photos"]
    Click Element                       xpath=//android.widget.TextView[@text="Photos"]
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Device folders"]
    Wait Until Page Contains Element    xpath=(//android.widget.RelativeLayout)[1]
    Click Element                       xpath=(//android.widget.RelativeLayout)[1]
    Wait Until Page Contains Element    xpath=(//android.view.ViewGroup[@clickable="true"])[4]
    Click Element                       xpath=(//android.view.ViewGroup[@clickable="true"])[4]

    # Suppression de la deuxieme image sélectionnée
    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=delete-image-2, Supprimer cette photo
    Click Element                   accessibility_id=delete-image-2, Supprimer cette photo

    Wait Until Keyword Succeeds    10x    1s    Page Should Contain Element    xpath=(//android.widget.EditText)[1]

    Click Element    accessibility_id=dropdown-sale-type\nÀ l’unité
    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Au poids (€/kg)
    Click Element    accessibility_id=Au poids (€/kg)

    Fill Field By Index    1    Chouchou
    Fill Field By Index    2    Fraîche du jardin
    Fill Field By Index    3    500
    Fill Field By Index    4    250

    Swipe Until Element Is Visible    accessibility_id=Enregistrer

    # Go Back
    # Go Back
    Wait Until Page Contains Element    accessibility_id=🧺 Vendre mes légumes
    Click Element                       accessibility_id=🧺 Vendre mes légumes
    Wait Until Keyword Succeeds    10x    1s    Page Should Contain Element    accessibility_id=Chouchou\n500g - 2.5€\nFraîche du jardin

Ajouter un légume vendu au poids
    Push Test Image    tomate.jpg
    Push Test Image    tomate-2.jpg
    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=🧺 Vendre mes légumes
    Click Element                       accessibility_id=🧺 Vendre mes légumes

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Choisir une photo
    Click Element    accessibility_id=Choisir une photo

    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Photos"]
    Click Element                       xpath=//android.widget.TextView[@text="Photos"]
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Device folders"]
    Wait Until Page Contains Element    xpath=(//android.widget.RelativeLayout)[1]
    Click Element                       xpath=(//android.widget.RelativeLayout)[1]
    Wait Until Page Contains Element    xpath=(//android.view.ViewGroup[@clickable="true"])[2]
    Click Element                       xpath=(//android.view.ViewGroup[@clickable="true"])[2]

    Log Source
    Click Element    accessibility_id=dropdown-sale-type\nÀ l’unité
    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Au poids (€/kg)
    Click Element    accessibility_id=Au poids (€/kg)

    Fill Field By Index    1    Tomate
    Fill Field By Index    2    Fraîchement récoltée
    Fill Field By Index    3    750
    Fill Field By Index    4    450

    Swipe Until Element Is Visible    accessibility_id=Enregistrer
    Sleep    2s

Ajouter un légume vendu à l’unité
    Push Test Image    citrouille.jpg
    Push Test Image    citrouille-2.jpg
    Wait Until Page Contains Element    accessibility_id=🧺 Vendre mes légumes
    Click Element                       accessibility_id=🧺 Vendre mes légumes

    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Choisir une photo
    Click Element    accessibility_id=Choisir une photo

    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Photos"]
    Click Element                       xpath=//android.widget.TextView[@text="Photos"]
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Device folders"]
    Wait Until Page Contains Element    xpath=(//android.widget.RelativeLayout)[1]
    Click Element                       xpath=(//android.widget.RelativeLayout)[1]
    Wait Until Page Contains Element    xpath=(//android.view.ViewGroup[@clickable="true"])[2]
    Click Element                       xpath=(//android.view.ViewGroup[@clickable="true"])[2]

    Fill Field By Index    1    Citrouille
    Fill Field By Index    2    Belle pièce pour Halloween

    Click Element    accessibility_id=dropdown-sale-type\nÀ l’unité
    Wait Until Keyword Succeeds    10x    1s    Wait Until Page Contains Element    accessibility_id=Au poids (€/kg)
    Click Element    accessibility_id=Au poids (€/kg)

    Fill Field By Index    3    1000
    Fill Field By Index    4    300
    
    Swipe Until Element Is Visible    accessibility_id=Enregistrer
    Sleep    2s
