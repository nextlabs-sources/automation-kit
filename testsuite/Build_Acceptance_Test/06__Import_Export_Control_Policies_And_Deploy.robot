*** Settings ***
Documentation     Import sample policies to console and Deploy them on a fresh machine
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        WebUI    priority/2    severity/mild    type/smoke    mode/full    import policies    Build_Acceptance
Default Tags
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${xpath workbook}    Xpaths.xls
${xpath worksheet}    Policies

*** Test Cases ***
Importing_Export_Control_Policies
    [Documentation]    IMPORTING SAMPLE POLICIES INTO THE CONSOLE
    [Tags]    importingpolicies    # to run only on on premise test cases
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Go To    ${Home}/${list policy Page}    #open up the policy list page
    Wait Until Page Contains Element    ${dict['Import Policies']}    #import button
    Click Element    ${dict['Import Policies']}
    sleep    2
    Choose File    ${dict['Browse Button']}    ${DATA_DIR}/Export_Control_Policy_validator.bin
    Click element    ${dict['Import Button']}
    sleep    10
    Wait Until Page Contains element    ${dict['Import success message']}    timeout=180 seconds    #wait untill the page displays the imported polices list
    sleep    10
    click Element    ${dict['Select All check box']}
    sleep    5
    Click Element    ${dict['Policy Bulk Deploy']}    #click on the the deploy button on the top of the list
    sleep    5
    Click element    ${dict['Confirmation on deployment']}    #confirmation on deployment    #xpath=//button[@class="btn btn-default cc-btn-primary ng-binding"]
    sleep    10
