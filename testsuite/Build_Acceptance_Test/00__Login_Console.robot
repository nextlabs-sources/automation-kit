*** Settings ***
Suite Setup       Console Access    # Open Browser | ${home}/${Login Page} | ${Browser}
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    Console    Login
Default Tags
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           OperatingSystem
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       Login_UserSource_Users_Delegation.xls    # \ ..\automation-kit\testdata\Control Center\Console.WebUI.xls
${worksheet}      Webapps_Login
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center
${xpath worksheet}    Login_ChangePassword

*** Test Cases ***
SuperUser_Console_Initial_Login
    [Documentation]    Scenario 1: Initial Login to Console as Super User and Super User Login validation.
    [Tags]    Inital_Login
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Go To    ${home}/${login_page}
    Maximize browser window
    Input Text    ${dict['Console Login Username']}    Administrator
    Input Password    ${dict['Console Login Password']}    12345Next!
    Click Element    ${dict['Console Login Button']}
    ${IsElementVisible}=    Run Keyword And Return Status    Page Should Contain    SET NEW PASSWORD
    Run Keyword If    ${IsElementVisible}    Change Initial Password

*** Keywords ***
Change Initial Password
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Wait until page contains element    ${dict['Console Initial New Password']}
    Input Password    ${dict['Console Initial New Password']}    12345Blue!
    Input Password    ${dict['Console Initial Confirm Password']}    12345Blue!
    Click Element    ${dict['Console Initial Password Submit Button']}
    Wait until page contains element    ${dict['Console Password Updated Continue Button']}
    Click Element    ${dict['Console Password Updated Continue Button']}
    Wait until page contains element    ${dict['Dash Board Down Arrow']}
    Click Element    ${dict['Dash Board Down Arrow']}
    Wait until page contains element    ${dict['Console Logout Button']}
    Click Element    ${dict['Console Logout Button']}
    Run Keyword    SuperUser_Console_Login_Test
