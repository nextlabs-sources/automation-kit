*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        WebUI    priority/2    severity/mild    type/smoke    mode/full
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String

*** Variables ***
${search button}    //*[@id="cc-ps-main-content"]/div/div/div[1]/div[3]/button
${search input}    //*[@id="userSearchForm"]/div/div[2]/p/input
${add user button}    //*[@id="cc-ps-main-content"]/div/div/div[1]/a[1]
${Apply Button}    //*[@id="userSearchForm"]/p/button[2]

*** Test Cases ***
user search
    [Documentation]    Search for a user
    Go To    ${Home}/${List User page }
    Wait Until Page Contains Element    ${add user button}
    Click element    ${search button}
    Input Text    ${search input}    Administrator
    Click Element    ${Apply Button}    #apply button
    Wait Until Page Contains    Administrator    #the list should display only the administrator buton in the list
