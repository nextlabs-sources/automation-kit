*** Settings ***
Suite Setup       Console Access    #Open Browser | ${home}/${Login Page} | ${browser}
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
SuperUser_Console_Login_Test
    [Documentation]    Logging into console as super user
    [Tags]    onpremise
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    Open Excel    ${DATA_DIR}/${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    #FOR    ${i}    IN RANGE    3    10    #62 is the end. Use excel row values, not ID values
    FOR    ${i}    IN RANGE    3    62    #62 is the end. Use excel row values, not ID values
       Go To    ${home}/${login_page}
       #Maximize browser window
       ${description}=    Read Cell Data By Name    ${worksheet}    E${i}
       Log    ${description}
       ${username}=    Read Cell Data By Name    ${worksheet}    B${i}
       ${password}=    Read Cell Data By Name    ${worksheet}    C${i}
       ${result}=    Read Cell Data By Name    ${worksheet}    D${i}
       Input Text    ${dict['Console Login Username']}    ${username}
       Input Password    ${dict['Console Login Password']}    ${password}
       Click Element    ${dict['Console Login Button']}
       Run Keyword If    '${result}'=='Pass'    Login Should Succeed
       Run Keyword If    '${result}'=='Fail'    Login Should Fail
    END

*** Keywords ***
Login Should Fail
    Element Should be visible    ${dict['Console Login Error Message']}

Login Should Succeed
    Element Should not be visible    ${dict['Console Login Error Message']}
    Wait until page contains element    ${dict['Console Dashboard Recent Activities']}
    Click Element    ${dict['Dash Board Down Arrow']}
    Wait until page contains element    ${dict['Console Logout Button']}
    Click Element    ${dict['Console Logout Button']}
