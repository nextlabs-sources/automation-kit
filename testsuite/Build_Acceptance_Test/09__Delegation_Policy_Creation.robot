*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Delegation Policy
Library           Selenium2Library
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       Login_UserSource_Users_Delegation.xls    # \ ..\automation-kit\testdata\Control Center\Login_UserSource_Users_Delegation.xls
${worksheet}      Delegation_Policies
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Delegation Policies
${name max length}    250
${test number}    4
${description max length}    4000
${min tag length}    1
${max tag length}    200

*** Test Cases ***
Delegation Policy With No Name
    [Documentation]    Create Delegation Policy with empty name
    ...    Expected Result: Should not save Delegation Policy name is mandatory
    [Tags]    Regression
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Go To    ${Home}/${ Delegation Policies Create}
    Maximize Browser Window
    Wait Until Page Contains Element    ${dict['SAVE Button']}
    click element    ${dict['SAVE Button']}
    Wait Until Page Contains    Name is mandatory.

Delegation Policy With Restricted Special Characters In Name
    [Tags]    Regression
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Go To    ${Home}/${ Delegation Policies Create}
    Maximize Browser Window
    wait until page contains Element    ${dict['DA Name Editable textbox']}
    Input Text    ${dict['DA Name Editable textbox']}    jhbcjh$&sdf    #name field
    Input Text    ${dict['DA Description Editable textbox']}    Delegation policy with restricted special character    #description field
    Click Element    ${dict['SAVE Button']}    #save button
    wait until page contains Element    ${dict['DA Name Error Message']}
    Page Should Contain Element    ${dict['DA Name Error Message']}
    sleep    2

Delegation Policy With Full Permissions
    [Tags]    Regression    BuildAcceptance
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${row}    IN RANGE    3    4
        ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${description}=    Read Cell Data By Name    ${worksheet}    C${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        Go To    ${Home}/${ Delegation Policies Create}
        Maximize Browser Window
        wait until page contains Element    ${dict['DA Name Editable textbox']}
        Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
        Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
        ${Name}=    Get Substring    ${Name}=    0    ${max name length}
        Click Element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
        Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
        Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
        Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
        Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
        Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
        Click Element    ${dict['All policy Folder checkbox']}    #All Permission on Policy Folder
        Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
        Click Element    ${dict['All Component Folder checkbox']}    #All Permission on Component Folder
        Click Element    ${dict['Policy Tab']}    # Policy Tab
        Click Element    ${dict['All Policy checkbox']}    #All Permission on Policy
        sleep    4
        Click Element    ${dict['Component Tab']}    #Component Tab
        Click Element    ${dict['ALL Component checkbox']}    #All Permission on Component
        sleep    4
        Click Element    ${dict['Component Type Tab']}    #Component Type Tab
        Click Element    ${dict['All Component Type Checkbox']}    #All Permission on Component Type
        Click Element    ${dict['Reports Tab']}    #Reports Tab
        Click Element    ${dict['All Reports Checkbox']}    #All Permission on Reports
        Click Element    ${dict['Administrator Tab']}    #Administrator Tab
        Click Element    ${dict['All Administrator Checkbox']}    #All Permission on Delegated administration
        Click Element    ${dict['Manage Server & Enforcer Checkbox']}    #Permission on Server and Enforcer
        Click Element    ${dict['Tools Tab']}    #Tools Tab
        Click Element    ${dict['Manage Enrollment Checkbox']}    #Manage Enrollment Permission
        Click Element    ${dict['Manage Certificate Checkbox']}    #Manage Certificate Permission
        Click Element    ${dict['Tag Tab']}    #Tags Tab
        Click Element    ${dict['All Tag Checkbox']}    #All Permission on Tag Management
        Click Element    ${dict['Configuration Tab']}    #Configuration Tab
        Click Element    ${dict['All Environment Checkbox']}    #All Permission on Environment configuration
        Click Element    ${dict['Manage Server Log Configuration Checkbox']}    #Permission on Server Log configuration
        Click Element    ${dict['Manage System Configuration Checkbox']}    #Permission on System configuration
        Click Element    ${dict['SAVE Button']}    #save button
        Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
        Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully
    END

Delegation Policy With Create Policy Folder
    [Tags]    Regression
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${row}    IN RANGE    5    6
        ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${description}=    Read Cell Data By Name    ${worksheet}    C${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
        Go To    ${Home}/${ Delegation Policies Create}
        Maximize Browser Window
        wait until page contains Element    ${dict['DA Name Editable textbox']}
        Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
        Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
        ${Name}=    Get Substring    ${Name}=    0    ${max name length}
        Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
        Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
        Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
        Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
        Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
        Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
        Click Element    ${dict['Create Policy Folder checkbox']}    #Create Policy Folder checkbox
        Click Element    ${dict['SAVE Button']}    #save button
        Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
        Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully
    END

*** Keywords ***
delegation policy should Be Created Successfully
    ${successfully created}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${dict['Success Message']}
    Click Element    ${dict['Success Message']}
    Should Be True    ${successfully created}
    sleep    2

Delegation pollicy should Not Be Created Successfully
    Page Should Not Contain    ${dict['Success Message']}
    sleep    2
