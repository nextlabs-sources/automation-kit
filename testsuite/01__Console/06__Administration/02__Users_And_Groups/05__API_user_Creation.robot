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
Library           Collections
Library           OperatingSystem

*** Variables ***
${username_field}    //*[@id="name"]
${password_field}    //*[@id="password"]
${save_button}    //*[@id="cc-ps-main-content"]/div/div/div/div[1]/div[3]/a[2]
${sucess message}    //*[@id="toast-container"]/comment()    # //*[@id="toast-container"]/div/div[3]/div/div/div
${username column}    3
${password column}    4
${description column}    7
${workbook}       Console_Administration_reports_tools.xls    # \ ..\automation-kit\testdata\Control Center\user creation.xls
${worksheet}      User_Creation
${result column}    6
${firstname_field}    //*[@id="firstName"]
${password}       //*[@id="password"]
${confirm password_field}    //*[@id="conFirmpassword"]
${firstname column}    1
${confirm password column}    5
${lastname column}    2
${lastname_field}    //*[@id="lastName"]
${Add User Attribute}    //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[4]/div/div[2]/div/input
${user attribute name}    //*[@name="attribute_key_0"]
${user attribute value}    //*[@name="attribute_value_0"]
${Check button}    //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[4]/div/div[2]/table/tbody/tr[1]/td[3]/i[1]    # Click on the tick button to add the attribute

*** Test Cases ***
User Creation
    ${worksheet}=    Evaluate    'User_Creation'
    ${firstname column}=    Evaluate    1
    ${lastname column}=    Evaluate    2
    ${username column}=    Evaluate    3
    ${pasword column}=    Evaluate    4
    ${confirm password column}=    Evaluate    5
    ${result column}=    Evaluate    6
    ${description Column}=    Evaluate    7
    Open Excel    ${DATA_DIR}/${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    51    ${nrows}-1
    \    Go To    ${Home}/${Create User page}
    \    ${description}=    Read Cell Data By Coordinates    ${worksheet}    ${description column}    ${row}
    \    Log    ${description}
    \    ${firstname}=    Read Cell Data By Coordinates    ${worksheet}    ${firstname column}    ${row}
    \    ${lastname}=    Read Cell Data By Coordinates    ${worksheet}    ${lastname column}    ${row}
    \    ${username}=    Read Cell Data By Coordinates    ${worksheet}    ${username column}    ${row}
    \    ${password}=    Read Cell Data By Coordinates    ${worksheet}    ${password column}    ${row}
    \    ${confirm password}    Read Cell Data By coordinates    ${worksheet}    ${confirm password column}    ${row}
    \    ${result}    Read cell Data By Coordinates    ${worksheet}    ${result column}    ${row}
    \    wait until page contains Element    ${firstname_field}
    \    Click Element    //span[@class="cc-ps-dropdown-btn-label"]    #category
    \    Wait Until Page Contains Element    //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[2]/div[1]/ul/li[3]/a
    \    Click element    //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[2]/div[1]/ul/li[3]/a    #choosing apiclient account from the list
    \    Input Text    ${firstname_field}    ${firstname}
    \    Input Text    ${lastname_field}    ${lastname}
    \    Input Text    ${username_field}    ${username}
    \    Input Password    ${password_field}    ${password}
    \    Input Password    ${confirm password_field}    ${confirm password}
    \    Click Element    ${Add User Attribute}    #to add user attribute
    \    wait until page contains Element    ${user attribute name}
    \    Input Text    ${user attribute name}    jwt_passphrase
    \    Input Text    ${user attribute value}    anyvalue of your choice
    \    Click Element    ${Check button}    #click on tick mark to save
    \    Click element    ${save_button}
    \    Run Keyword And Ignore Error    Click Element    //button[@class="btn btn-default cc-btn-primary ng-binding"]    #pop up
    \    Run Keyword If    '${result}'=='pass'    user creation Should succeed
    \    Run Keyword If    '${result}'=='Fail'    user creation Should Fail

*** Keywords ***
user creation Should Fail
    ${mandatory field missing}=    Run Keyword And Return Status    Page Should Contain    mandatory
    ${password wrong}=    Run Keyword And Return Status    Page Should Contain    (Note: The password must be between 7 and 12 characters and must contain at least one number, one character and one non-alphanumeric character other than '_')
    ${confirm password wrong}=    Run Keyword And Return Status    Page Should Contain    Confirm password does not match new password
    ${an active user exists}=    Run Keyword And Return Status    Element Should Be Visible    //*[@class='btn btn-default cc-btn-primary ng-binding' and name()='button']
    Run Keyword If    ${an active user exists}    Click Element    //*[@class='btn btn-default cc-btn-primary ng-binding' and name()='button']
    ${username wrong}=    Run Keyword And Return Status    Page Should Contain    Username must begin with a letter followed by letters, numbers, periods (.), or underscores (_).
    ${not successful}=    Evaluate    ${mandatory field missing} or ${password wrong} or ${username wrong} or ${confirm password wrong} or ${an active user exists}
    Should Be True    ${not successful}

user creation Should Succeed
    Run Keyword And Ignore Error    Click Element    //button[@class="btn btn-default cc-btn-primary ng-binding"]
    sleep    3
    Wait Until Page Contains Element    ${sucess message}
