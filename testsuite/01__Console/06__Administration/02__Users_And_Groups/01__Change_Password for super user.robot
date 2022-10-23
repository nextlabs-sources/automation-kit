*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        WebUI    priority/2    severity/mild    type/smoke    mode/full
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary

*** Variables ***
${old password_field}    //*[@id="cc-ps-main-content"]/div/div/div[1]/form/input[1]
${Submit_button}    //*[@id="cc-ps-main-content"]/div/div/div[1]/div[2]/a[2]
${error_message}    //*[@class="modal-content"]    # /html/body/div[1]/div/div/div[1]
${old password column}    1
${New password column}    2
${description column}    5
${workbook}       Console_Administration_reports_tools.xls    # \ ..\automation-kit\testdata\Control Center\UserCreation.xls
${worksheet}      Change password
${result column}    4
${REPORTER URL}    https://nxtqapr576-cc.cloudaz.com/reporter/
${Re-enter new password column}    3
${re-enter new password_field}    //*[@id="cc-ps-main-content"]/div/div/div[1]/form/input[3]
${new password_field}    //*[@id="cc-ps-main-content"]/div/div/div[1]/form/input[2]
${Discard button}    //*[@id="cc-ps-main-content"]/div/div/div[1]/div[2]/a[1]

*** Test Cases ***
Changing password in console
    Open Excel    ${DATA_DIR}/${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    1    ${nrows}
    \    ${old password}=    Read Cell Data By Coordinates    ${worksheet}    ${old password column}    ${row}
    \    ${new password}=    Read Cell Data By Coordinates    ${worksheet}    ${New password column}    ${row}
    \    ${Re_enter new password}=    Read Cell Data By Coordinates    ${worksheet}    ${Re-enter new password column}    ${row}
    \    ${description}=    Read Cell Data By Coordinates    ${worksheet}    ${description column}    ${row}
    \    Log    ${description}
    \    sleep    2
    \    Go To    ${Home}/${Change Password}
    \    wait until page contains element    ${old password_field}
    \    input text    ${old password_field}    ${old password}
    \    input text    ${new password_field}    ${new password}
    \    input text    ${re-enter new password_field}    ${Re_enter new password}
    \    ${result}=    Read Cell Data By Coordinates    ${worksheet}    ${result column}    ${row}
    \    Click Element    ${Submit_button}
    \    Run Keyword If    '${result}'=='Pass'    chnage spassword Should Succeed
    \    Run Keyword If    '${result}'=='Fail'    Change password Should Fail

*** Keywords ***
Change password Should Fail
    sleep    3
    ${error_message}=    Run Keyword And Return Status    click Element    ${error_message}
    Run Keyword And Return Status    Click element    //*[@class="btn btn-default cc-btn-primary ng-binding"]
    Run Keyword And Return Status    page should contain    New password can be shorter than 7 characters

chnage spassword Should Succeed
    ${error_message}=    Run Keyword And Return Status    click Element    ${error_message}
    Run Keyword And Return Status    Click element    //*[@class="btn btn-default cc-btn-primary ng-binding"]
