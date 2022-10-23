*** Settings ***
Suite Setup       Sign In To Console
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
Change_Password_For_Administrator_On_Console
    [Tags]
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    Open Excel    ${DATA_DIR}/${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    FOR    ${row}    IN RANGE    2    ${nrows}
        ${old password}=    Read Cell Data By Coordinates    ${worksheet}    ${old password column}    ${row}
        ${new password}=    Read Cell Data By Coordinates    ${worksheet}    ${new password column}    ${row}
        ${confirm password}=    Read Cell Data By Coordinates    ${worksheet}    ${confirm password column}    ${row}
        ${result}=    Read Cell Data By Coordinates    ${worksheet}    ${result column}    ${row}
        ${description}=    Read Cell Data By Coordinates    ${worksheet}    5    ${row}
        Log    ${description}
        Go To    ${Home}/${Console Change Password}
        wait until page contains element    ${dict['Console Old Password Field']}
        input text    ${dict['Console Old Password Field']}    ${old password}
        input text    ${dict['Console New Password Field']}    ${new password}
        input text    ${dict['Console Confirm Password Field']}    ${confirm password}
        Click Element    ${dict['Console Password Submit Button']}
        Run Keyword If    '${result}'=='Pass'    Change Password Should Succeed
        Run Keyword If    '${result}'=='Fail'    Change password Should Fail
    END

*** Keywords ***
Change Password Should Fail
    Sleep    3
    ${previous kw}=    Register Keyword To Run On Failure    NOTHING
    ${bool}=    Run Keyword And Return Status    Element Should Be Visible    ${dict['Console Passwor Mandatory Message']}
    ${Pass} =    Run Keyword If    ${bool} == True    Get Text    ${dict['Console Passwor Mandatory Message']}
    ...    ELSE    Set Variable    ${EMPTY}
    ${bool}=    Run Keyword And Return Status    Element Should Be Visible    ${dict['Console New Password Message']}
    ${NPass} =    Run Keyword If    ${bool} == True    Get Text    ${dict['Console New Password Message']}
    ...    ELSE    Set Variable    ${EMPTY}
    ${bool}=    Run Keyword And Return Status    Element Should Be Visible    ${dict['Console Confirm Password Not Match Message']}
    ${CPass} =    Run Keyword If    ${bool} == True    Get Text    ${dict['Console Confirm Password Not Match Message']}
    ...    ELSE    Set Variable    ${EMPTY}
    ${bool}=    Run Keyword And Return Status    Page Should Contain Element    ${dict['Console Password Success Popup Window']}
    ${SamePass} =    Run Keyword If    ${bool} == True    Get Text    ${dict['Console Password Success Popup Window']}
    ...    ELSE    Set Variable    ${EMPTY}
    Register Keyword To Run On Failure    ${previous kw}
    Should Be True    '${Pass}' == 'Password is mandatory' or '${NPass}' == 'New password is mandatory' or '${NPass}' == 'The password does not meet complexity requirements' or '${CPass}' == 'Confirm new password does not match new password'

Change Password Should Succeed
    Sleep    3
    ${previous kw}=    Register Keyword To Run On Failure    NOTHING
    ${bool}=    Run Keyword And Return Status    Page Should Contain Element    ${dict['Console Password Success Popup Window']}
    Register Keyword To Run On Failure    ${previous kw}
    Run Keyword If    ${bool} == True    Click Element    ${dict['console Popup Window OK Button']}
    ...    ELSE    Click Element    ${dict['console Popup Windows Same PW OK Button']}
    sleep    3
    Go To    ${Home}/${Console Change Password}
    sleep    3
