*** Settings ***
Documentation     Import sample policies to console and Deploy them on a fresh machine
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Deploy
Default Tags
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String

*** Variables ***
${import_button}    //*[@id="cc-ps-main-content"]/div/div/div[1]/div[5]/button[2]

*** Test Cases ***
Deploy_Policies
    [Documentation]    IMPORTING SAMPLE POLICIES INTO THE CONSOLE
    [Tags]    on premise    # to run only on on premise test cases
    Go To    ${Home}/${list policy Page}    #open up the policy list page
    Wait Until Page Contains Element    ${import_button}    #import button
    Click element    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[1]/div[2]/div[1]/ul/li[1]/div/div/div/div/div/div[1]/label/span/span    # selecting 1st policy from the list
    Click element    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[1]/div[2]/div[1]/ul/li[2]/div/div/div/div/div/div[1]/label/span/span    # selecting 2nd policy from the list
    Click element    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[1]/div[2]/div[1]/ul/li[3]/div/div/div/div/div/div[1]/label/span/span    # selecting 3rd policy from the list
    sleep    5
    Click Element    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[1]/div[2]/div[1]/div[2]/div[2]/button[2]    #click on the the deploy button on the top of the list
    sleep    5
    #    Wait Until Page Contains Element    /html/body/div[1]/div/div/div[3]/button[1]    #cancel button on the deployment window
    Click element    xpath=//button[@class="btn btn-default cc-btn-primary ng-binding"]    #conformation for deployment
    sleep    10
