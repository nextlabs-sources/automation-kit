*** Settings ***
Suite Setup       Administrator Access    # Open Browser | ${home}/${Administrator Login Page} | ${Browser}
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    Administrator    Login
Default Tags
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           OperatingSystem
Library           ${LIB_DIR}/ExcelUtil.py
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary
Library           yaml

*** Variables ***
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center
${xpath worksheet}    Login_ChangePassword
${workbook}       Login_UserSource_Users_Delegation.xls    # \ ..\automation-kit\testdata\Console_Login_Dashboard.xls
${worksheet}      Webapps_Login

*** Test Cases ***
SuperUser_Administrator_Login_Test
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Open Excel    ${DATA_DIR}/${workbook}
    ${nrows}    Get Row Count    ${worksheet}
    : FOR    ${i}    IN RANGE    2    61
    \    Go To    ${home}/${Administrator_Login_Page}
    \    Maximize browser window
    \    ${worksheet}=    Evaluate    'Webapps_Login'
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${description}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    Log    ${description}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    Input Text    ${dict['Administrator Login Username']}    ${username}
    \    Input Password    ${dict['Administrator Login Password']}    ${password}
    \    Click Element    ${dict['Administrator Login Button']}
    \    Run Keyword If    '${result}'=='Fail'    Login Should Fail
    \    Run Keyword If    '${result}'=='Pass'    Login Should Succeed

*** Keywords ***
Login Should Fail
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Element Should be visible    ${dict['Administrator Login Error Message']}

Login Should Succeed
    sleep    2
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Element Should not be visible    ${dict['Administrator Login Error Message']}
    wait until page contains    Logged in as:
    Click Element    ${dict['Administrator Logout Button']}
