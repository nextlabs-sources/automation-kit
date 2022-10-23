*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        WebUI    priority/2    severity/mild    type/smoke    mode/full    Users
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       Login_UserSource_Users_Delegation.xls    # \ ..\automation-kit\testdata\Control Center\Login_UserSource_Users_Delegation.xls
${worksheet}      User_Creation
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Users_Groups_UserSource

*** Test Cases ***
API User Creation
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    10 seconds
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${i}    IN RANGE    3    5
        ${fname}=    Read Cell Data By Name    ${worksheet}    AD${i}
        ${lname}=    Read Cell Data By Name    ${worksheet}    AE${i}
        ${uname}=    Read Cell Data By Name    ${worksheet}    AF${i}
        ${pwd}=    Read Cell Data By Name    ${worksheet}    AH${i}
        ${confirmpwd}=    Read Cell Data By Name    ${worksheet}    AI${i}
        ${description}=    Read Cell Data By Name    ${worksheet}    AM${i}
        Log    ${description}
        Go To    ${Home}/${Create User page}
        Maximize browser window
        wait until page contains Element    ${dict['First Name']}
        Click Element    ${dict['Category']}    #Clicking the Category down arrow button
        Wait until page contains Element    ${dict['API Account']}
        Click Element    ${dict['API Account']}    #Selecting API Account category from the drop-down list
        Input Text    ${dict['First Name']}    ${fname}
        Input Text    ${dict['Last Name']}    ${lname}
        Input Text    ${dict['Username']}    ${uname}
        Input Text    ${dict['Password']}    ${pwd}
        Input Text    ${dict['Confirm Password']}    ${confirmpwd}
        ${result}=    Read Cell Data By Name    ${worksheet}    AL${i}
        Click Element    ${dict['Save']}
        sleep    1
        Run Keyword If    '${result}'=='Pass'    user creation Should Succeed
        Run Keyword If    '${result}'=='Fail'    user creation Should Fail
    END

Creating Admin User
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${i}    IN RANGE    3    6
        ${fname}=    Read Cell Data By Name    ${worksheet}    P${i}
        ${lname}=    Read Cell Data By Name    ${worksheet}    Q${i}
        ${uname}=    Read Cell Data By Name    ${worksheet}    R${i}
        ${uemail}=    Read Cell Data By Name    ${worksheet}    S${i}
        ${pwd}=    Read Cell Data By Name    ${worksheet}    T${i}
        ${confirmpwd}=    Read Cell Data By Name    ${worksheet}    U${i}
        ${description}=    Read Cell Data By Name    ${worksheet}    Y${i}
        Log    ${description}
        Go To    ${Home}/${Create User page}
        Maximize browser window
        wait until page contains Element    ${dict['First Name']}
        Click Element    ${dict['Category']}    #Clicking the Category down arrow button
        wait until page contains Element    ${dict['Administrator']}
        Click Element    ${dict['Administrator']}    #Selecting Administrator category from the drop-down list
        Input Text    ${dict['First Name']}    ${fname}
        Input Text    ${dict['Last Name']}    ${lname}
        Input Text    ${dict['Username']}    ${uname}
        Input Text    ${dict['Email']}    ${uemail}
        Input Text    ${dict['Password']}    ${pwd}
        Input Text    ${dict['Confirm Password']}    ${confirmpwd}
        ${result}=    Read Cell Data By Name    ${worksheet}    X${i}
        Click Element    ${dict['Save']}
        sleep    1
        Run Keyword If    '${result}'=='Pass'    user creation Should Succeed
        Run Keyword If    '${result}'=='Fail'    user creation Should Fail
    END

General User Creation
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${i}    IN RANGE    15    19
        ${fname}=    Read Cell Data By Name    ${worksheet}    B${i}
        ${lname}=    Read Cell Data By Name    ${worksheet}    C${i}
        ${uname}=    Read Cell Data By Name    ${worksheet}    D${i}
        ${pwd}=    Read Cell Data By Name    ${worksheet}    F${i}
        ${confirmpwd}=    Read Cell Data By Name    ${worksheet}    G${i}
        ${description}=    Read Cell Data By Name    ${worksheet}    K${i}
        Log    ${description}
        Go To    ${Home}/${Create User page}
        Maximize browser window
        wait until page contains Element    ${dict['First Name']}
        Click Element    ${dict['Category']}    #Clicking the Category down arrow button
        wait until page contains Element    ${dict['General User']}
        sleep    3
        Click Element    ${dict['General User']}    #Selecting General User category from the drop-down list
        Input Text    ${dict['First Name']}    ${fname}
        Input Text    ${dict['Last Name']}    ${lname}
        Input Text    ${dict['Username']}    ${uname}
        Input Text    ${dict['Password']}    ${pwd}
        Input Text    ${dict['Confirm Password']}    ${confirmpwd}
        ${result}=    Read Cell Data By Name    ${worksheet}    I${i}
        Click Element    ${dict['Save']}
        sleep    1
        Run Keyword If    '${result}'=='Pass'    user creation Should Succeed
        Run Keyword If    '${result}'=='Fail'    user creation Should Fail
    END

User Creation with Condition
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${i}    IN RANGE    36    39
        ${fname}=    Read Cell Data By Name    ${worksheet}    B${i}
        ${lname}=    Read Cell Data By Name    ${worksheet}    C${i}
        ${uname}=    Read Cell Data By Name    ${worksheet}    D${i}
        ${pwd}=    Read Cell Data By Name    ${worksheet}    F${i}
        ${confirmpwd}=    Read Cell Data By Name    ${worksheet}    G${i}
        ${cname}=    Read Cell Data By Name    ${worksheet}    H${i}
        ${cvalue}=    Read Cell Data By Name    ${worksheet}    I${i}
        ${description}=    Read Cell Data By Name    ${worksheet}    K${i}
        Log    ${description}
        Go To    ${Home}/${Create User page}
        Maximize browser window
        wait until page contains Element    ${dict['First Name']}
        Click Element    ${dict['Category']}    #Clicking the Category down arrow button
        wait until page contains Element    ${dict['General User']}
        sleep    3
        Click Element    ${dict['General User']}    #Selecting General User category from the drop-down list
        Input Text    ${dict['First Name']}    ${fname}
        Input Text    ${dict['Last Name']}    ${lname}
        Input Text    ${dict['Username']}    ${uname}
        Input Password    ${dict['Password']}    ${pwd}
        Input Password    ${dict['Confirm Password']}    ${confirmpwd}
        Click Element    ${dict['Add Attribute']}
        sleep    2
        Input Text    ${dict['Cname']}    ${cname}
        Input Text    ${dict['Cvalue']}    ${cvalue}
        Click Element    ${dict['Tick Button']}
        sleep    2
        ${result}=    Read Cell Data By Name    ${worksheet}    J${i}
        Click Element    ${dict['Save']}
        sleep    1
        Run Keyword If    '${result}'=='Pass'    user creation Should Succeed
        Run Keyword If    '${result}'=='Fail'    user creation Should Fail
    END

*** Keywords ***
user creation Should Fail
    ${previous kw}=    Register Keyword To Run On Failure    NOTHING
    ${mandatory field missing}=    Run Keyword And Return Status    Page Should Contain    mandatory
    ${password wrong}=    Run Keyword And Return Status    Page Should Contain    The password does not meet complexity requirements
    ${confirm password wrong}=    Run Keyword And Return Status    Page Should Contain    Confirm password does not match new password
    ${an active user exists}=    Run Keyword And Return Status    Element Should Be Visible    //*[@class='btn btn-default cc-btn-primary ng-binding' and name()='button']
    ${attribute value blank}=    Run Keyword And Return Status    Page Should Contain    Add an attribute value
    ${attribute name blank}=    Run Keyword And Return Status    Page Should Contain    Add an attribute name
    Run Keyword If    ${an active user exists}    Click Element    //*[@class='btn btn-default cc-btn-primary ng-binding' and name()='button']
    ${username wrong}=    Run Keyword And Return Status    Page Should Contain    Username must begin with a letter followed by letters, numbers, periods (.), or underscores (_).
    ${not successful}=    Evaluate    ${mandatory field missing} or ${password wrong} or ${username wrong} or ${confirm password wrong} or ${an active user exists} or ${attribute value blank} or ${attribute name blank}
    Register Keyword To Run On Failure    ${previous kw}
    Should Be True    ${not successful}

user creation Should Succeed
    ${successfully created}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${dict['Success Message']}
    Should Be True    ${successfully created}
    Comment    Click Element    //*[@id="cc-ps-main-content"]/div/div/div/div[1]/div[1]/a/button/i
    sleep    3
