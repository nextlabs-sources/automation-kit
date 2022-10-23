*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
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
${worksheet}      Change_Password
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center
${xpath worksheet}    Login_ChangePassword
${old password column}    1
${new password column}    2
${confirm password column}    3
${result column}    4
${description column}    5

*** Test Cases ***
Change_Password_For_Administrator_ON_Reporter
    [Tags]
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    1    ${nrows}
    \    ${worksheet}=    Evaluate    'Change_Password'
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${old password}=    Read Cell Data By Coordinates    ${worksheet}    ${old password column}    ${row}
    \    ${new password}=    Read Cell Data By Coordinates    ${worksheet}    ${new password column}    ${row}
    \    ${confirm password}=    Read Cell Data By Coordinates    ${worksheet}    ${confirm password column}    ${row}
    \    ${result}=    Read Cell Data By Coordinates    ${worksheet}    ${result column}    ${row}
    \    ${description}=    Read Cell Data By Coordinates    ${worksheet}    5    ${row}
    \    Log    ${description}
    \    Go To    ${Home}/${Reporter Change Password}
    \    wait until page contains element    ${dict['Reporter Old Password Field']}
    \    input text    ${dict['Reporter Old Password Field']}    ${old password}
    \    input text    ${dict['Reporter New Password Field']}    ${new password}
    \    input text    ${dict['Reporter Confirm Password Field']}    ${confirm password}
    \    Click Element    ${dict['Reporter Password Submit Button']}
    \    Run Keyword If    '${result}'=='Pass'    Change Password Should Succeed
    \    Run Keyword If    '${result}'=='Fail'    Change password Should Fail

*** Keywords ***
Change Password Should Fail
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${workbook}
    sleep    3
    Element Should Be Visible    ${dict['Reporter Password Error Message']}
    ${message}=    Get Text    //*[@class="reason"]
    Log    ${message}

Change Password Should Succeed
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${workbook}
    Sleep    3
    Element Should Be Visible    ${dict['Reporter Password Info Message']}
    ${message}=    Get Text    ${dict['Reporter Password Info Message']}/div
    Log    ${message}
