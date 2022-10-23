*** Settings ***
Suite Setup       Reporter Access    # Open Browser | ${home}/${Reporter Login Page} | ${Browser}
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter    Login
Library           Selenium2Library
Library           String
Library           OperatingSystem
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       Login_UserSource_Users_Delegation.xls
${worksheet}      Webapps_Login
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center
${xpath worksheet}    Login_ChangePassword

*** Test Cases ***
SuperUser_Reporter_Login_Test
    [Tags]
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${i}    IN RANGE    3    62
    \    Go To    ${home}/${reporter_login_page}
    \    Maximize browser window
    \    ${worksheet}=    Evaluate    'Webapps_Login'
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${description}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    Log    ${description}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    Log    ${username}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    Log    ${password}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    Input Text    ${dict['Reporter Login Username']}    ${username}
    \    Input Password    ${dict['Reporter Login Password']}    ${password}
    \    Click Element    ${dict['Reporter Login Button']}
    \    Run Keyword If    '${result}'=='Pass'    Login Should Succeed
    \    Run Keyword If    '${result}'=='Fail'    Login Should Fail

*** Keywords ***
Login Should Fail
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Element Should be visible    ${dict['Reporter Login Error Message']}

Login Should Succeed
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Element Should not be visible    ${dict['Reporter Login Error Message']}
    Click Element    ${dict['Reporter Logout Button']}
