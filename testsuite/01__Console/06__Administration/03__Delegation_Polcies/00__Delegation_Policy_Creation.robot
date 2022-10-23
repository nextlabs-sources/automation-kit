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
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    Go To    ${Home}/${ Delegation Policies Create}
    Maximize Browser Window
    Wait Until Page Contains Element    ${dict['SAVE Button']}
    click element    ${dict['SAVE Button']}
    Wait Until Page Contains    Name is mandatory.
	
Delegation Policy With Name Of Different Length
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Selenium Timeout    10 seconds
    @{name length}=    Generate ${test number} Random Numbers Within 1 And ${name max length}
    : FOR    ${length}    IN    @{name length}
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
	\    ${name}=    Generate Random String    ${length}
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${name}
    \    Click Element    ${dict['SAVE Button']}
    \    Page Should Not Contain    Name is mandatory.
    \    sleep    2
	
Delegation Policy With Special Characters In Name
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    Go To    ${Home}/${ Delegation Policies Create}
    Maximize Browser Window
    wait until page contains Element    ${dict['DA Name Editable textbox']}
    Input Text    ${dict['DA Name Editable textbox']}    ABC!@#%^(!@#%^()_+=-`'DEF    #name field
    Input Text    ${dict['DA Description Editable textbox']}    Delegation policy with special characters    #description field
    Click Element    ${dict['SAVE Button']}    #save button
    Wait Until Page Contains Element    ${dict['Success Message']}
	sleep    2

Delegation Policy With Numbers In Name
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    Go To    ${Home}/${ Delegation Policies Create}
    Maximize Browser Window
    wait until page contains Element    ${dict['DA Name Editable textbox']}
    Input Text    ${dict['DA Name Editable textbox']}    123456kdflgjdfkv    #name field
    Input Text    ${dict['DA Description Editable textbox']}    Delegation policy with numbers    #description field
    Click Element    ${dict['SAVE Button']}    #save button
    Wait Until Page Contains Element    ${dict['Success Message']}
	sleep    2

Delegation Policy With Restricted Special Characters In Name
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    Go To    ${Home}/${ Delegation Policies Create}
    Maximize Browser Window
    wait until page contains Element    ${dict['DA Name Editable textbox']}
    Input Text    ${dict['DA Name Editable textbox']}    jhbcjh$&sdf    #name field
    Input Text    ${dict['DA Description Editable textbox']}    Delegation policy with restricted special character    #description field
    Click Element    ${dict['SAVE Button']}    #save button
	wait until page contains Element   ${dict['DA Name Error Message']}
    Page Should Contain Element    ${dict['DA Name Error Message']}
	sleep    2

Delegation Policy With Existing Delegation Policy Name
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    Go To    ${Home}/${ Delegation Policies Create}
    Maximize Browser Window
    wait until page contains Element    ${dict['DA Name Editable textbox']}
    Input Text    ${dict['DA Name Editable textbox']}    123456kdflgjdfkv    #name field
    Input Text    ${dict['DA Description Editable textbox']}    Delegation Policy with existing Name    #description field
    Click Element    ${dict['SAVE Button']}    #save button
	sleep   2
    Wait Until Page Contains Element    //*[@type="button" and @data-ng-click="ok()"]    #OK Pop-up Button
    Click Element    //*[@type="button" and @data-ng-click="ok()"]
    Reload Page
    Page Should Not Contain Element   ${dict['Success Message']}
	
Delegation Policy With Description Of Different Length
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Selenium Timeout    10 seconds
    @{description length}=    Generate ${test number} Random Numbers Within 1 And ${description max length}
    : FOR    ${length}    IN    @{description length}
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    ${name}=    Generate Random String    50
    \    ${description}=    Generate Random String    ${length}
    \    Wait Until Page Contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${name}
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Page Should Not Contain    Name is mandatory.
    \    sleep    2

Delegation Policy With Full Permissions
    [Tags]    Regression    BuildAcceptance
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
	: FOR    ${row}    IN RANGE    3    4
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click Element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
	\    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['All policy Folder checkbox']}    #All Permission on Policy Folder
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['All Component Folder checkbox']}    #All Permission on Component Folder
    \    Click Element    ${dict['Policy Tab']}    # Policy Tab
    \    Click Element    ${dict['All Policy checkbox']}    #All Permission on Policy
    \    Click Element    ${dict['Component Tab']}    #Component Tab
    \    Click Element    ${dict['ALL Component checkbox']}    #All Permission on Component
    \    Click Element    ${dict['Component Type Tab']}    #Component Type Tab
    \    Click Element    ${dict['All Component Type Checkbox']}    #All Permission on Component Type
    \    Click Element    ${dict['Reports Tab']}    #Reports Tab
    \    Click Element    ${dict['All Reports Checkbox']}    #All Permission on Reports
    \    Click Element    ${dict['Administrator Tab']}    #Administrator Tab
    \    Click Element    ${dict['All Administrator Checkbox']}    #All Permission on Delegated administration
    \    Click Element    ${dict['Manage Server & Enforcer Checkbox']}    #Permission on Server and Enforcer
    \    Click Element    ${dict['Tools Tab']}    #Tools Tab
    \    Click Element    ${dict['Manage Enrollment Checkbox']}    #Manage Enrollment Permission
    \    Click Element    ${dict['Manage Certificate Checkbox']}    #Manage Certificate Permission
    \    Click Element    ${dict['Tag Tab']}    #Tags Tab
    \    Click Element    ${dict['All Tag Checkbox']}    #All Permission on Tag Management
    \    Click Element    ${dict['Configuration Tab']}    #Configuration Tab
    \    Click Element    ${dict['All Environment Checkbox']}    #All Permission on Environment configuration
    \    Click Element    ${dict['Manage Server Log Configuration Checkbox']}    #Permission on Server Log configuration
    \    Click Element    ${dict['Manage System Configuration Checkbox']}    #Permission on System configuration
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With View Policy Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
	: FOR    ${row}    IN RANGE    4    5
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['View Policy Folder checkbox']}    #View Policy Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Policy Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    5    6
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Create Policy Folder checkbox']}    #Create Policy Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Rename Policy Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    6    7
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Rename Policy Folder checkbox']}    #Rename Policy Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Move Policy Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    7    8
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Move Policy Folder checkbox']}    #Move Policy Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Delete Policy Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    8    9
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Delete Policy Folder checkbox']}    #Delete Policy Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With View Component Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    9    10
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['View Component Folder checkbox']}    #View Component Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Component Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    10    11
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Create Component Folder checkbox']}    #Create Component Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Rename Component Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    11    12
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Rename Component Folder checkbox']}    #Rename Component Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Move Component Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    12    13
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Move Component Folder checkbox']}    #Move Component Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Delete Component Folder
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    13    14
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Delete Component Folder checkbox']}    #Delete Component Folder checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Component Type
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    14    15
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Type Tab']}    #Component Type Tab
	\    Click Element    ${dict['Create Component Type Checkbox']}    #Create Component Type checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Delete Component Type
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    15    16
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE LASTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Type Tab']}    #Component Type Tab
	\    Click Element    ${dict['Delete Component Type Checkbox']}    #Delete Component Type checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Edit Component Type
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    16    17
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE LASTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Type Tab']}    #Component Type Tab
	\    Click Element    ${dict['Edit Component Type Checkbox']}    #Edit Component Type checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With View Component Type
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    17    18
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Type Tab']}    #Component Type Tab
	\    Click Element    ${dict['View Component Type Checkbox']}    #View Component Type checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Component
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    18    19
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE COUNTRY ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Tab']}    #Component Tab
    \    Click Element    ${dict['Create Component checkbox']}    #Create Component checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Delete Component
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    19    20
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Tab']}    #Component Tab
    \    Click Element    ${dict['Delete Component checkbox']}    #Delete Component checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Deploy Component
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    20    21
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE EMAIL ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Tab']}    #Component Tab
    \    Click Element    ${dict['Deploy Component checkbox']}    #Deploy Component checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Edit Component
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    21    22
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Tab']}    #Component Tab
    \    Click Element    ${dict['Edit Component checkbox']}    #Edit Component checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Move Component
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    22    23
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Tab']}    #Component Tab
    \    Click Element    ${dict['Move Component checkbox']}    #Move Component checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With View Component
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    23    24
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Component Tab']}    #Component Tab
    \    Click Element    ${dict['View Component checkbox']}    #View Component checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Policy
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    24    25
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Policy Tab']}    #Policy Tab
    \    Click Element    ${dict['Create Policy checkbox']}    #Create Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Delete Policy
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    25    26
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Policy Tab']}    #Policy Tab
    \    Click Element    ${dict['Delete Policy checkbox']}    #Delete Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Deploy Policy
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    26    27
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Policy Tab']}    #Policy Tab
    \    Click Element    ${dict['Deploy Policy checkbox']}    #Deploy Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Edit Policy
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    27    28
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE COUNTRY ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Policy Tab']}    #Policy Tab
    \    Click Element    ${dict['Edit Policy checkbox']}    #Edit Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Move Policy
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    28    29
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE COUNTRY ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Policy Tab']}    #Policy Tab
    \    Click Element    ${dict['Move Policy checkbox']}    #Move Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With View Policy
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    29    30
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Policy Tab']}    #Policy Tab
    \    Click Element    ${dict['View Policy checkbox']}    #View Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully
	
Delegation Policy With Migrate Policy
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    30    34
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Operator}=    Read Cell Data By Name    ${worksheet}    F${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
	\    Click Element    ${dict['DA Condition Operator Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Operator}"]    #SELECT THE OPERATOR FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Policy Tab']}    #Policy Tab
    \    Click Element    ${dict['Migrate Policy checkbox']}    #Migrate Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Manage Delegation Policies
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    34    35
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value1}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Str1}=    Convert to String    ${Condition Value1}
    \    ${Condition Value}=    Replace String    ${Str1}    .0    ${Empty}
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE COUNTRY ATTRIBUTE FROM THE DROP DOWN LIST
	\    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Administrator Tab']}    #Administrator Tab
    \    Click Element    ${dict['Manage Delegation Policies Checkbox']}    #Manage Delegation Policy checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Manage Users
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    35    36
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Administrator Tab']}    #Administrator Tab
    \    Click Element    ${dict['Manage Users Checkbox']}    #Manage Users checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Manage Server And Enforcer
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    36    37
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Administrator Tab']}    #Administrator Tab
    \    Click Element    ${dict['Manage Server & Enforcer Checkbox']}    #Manage Server and Enforcer checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Manage Reports
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    37    38
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Reports Tab']}    #Reports Tab
    \    Click Element    ${dict['Manage Reports Checkbox']}    #Manage Reports checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With View Reports
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
	: FOR    ${row}    IN RANGE    38    39
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Reports Tab']}    #Reports Tab
    \    Click Element    ${dict['View Reports Checkbox']}    #View Reports checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Component Type Tags
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    39    40
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE COUNTRY ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Tag Tab']}    #Tags Tab
    \    Click Element    ${dict['Create Component Type Tags Checkbox']}    #Create Component Type Tags checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Component Tags
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    40    41
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Tag Tab']}    #Tags Tab
    \    Click Element    ${dict['Create Component Tags Checkbox']}    #Create Component Tags checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Create Policy Tags
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    41    42
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value1}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Str1}=    Convert to String    ${Condition Value1}
    \    ${Condition Value}=    Replace String    ${Str1}    .0    ${Empty}
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE COUNTRY ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Tag Tab']}    #Tags Tab
    \    Click Element    ${dict['Create Policy Tags Checkbox']}    #Create Policy Tags checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Certificate Management
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    42    43
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Tools Tab']}    #Tools Tab
    \    Click Element    ${dict['Manage Certificate Checkbox']}    #Manage Certificate Checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Manage Enrollments
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    43    44
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE COUNTRY ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Tools Tab']}    #Tools Tab
    \    Click Element    ${dict['Manage Enrollment Checkbox']}    #Manage Enrollment Checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Manage Server Log
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    44    45
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Configuration Tab']}    #Configuration Tab
    \    Click Element    ${dict['Manage Server Log Configuration Checkbox']}    #Manage Server Log checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

Delegation Policy With Manage System Configuration
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    45    46
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Configuration Tab']}    #Configuration Tab
    \    Click Element    ${dict['Manage System Configuration Checkbox']}    #Manage System Configuration Checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully
	
Delegation Policy With View Environment Configuration
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    46    47
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE FIRSTNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Configuration Tab']}    #Configuration Tab
    \    Click Element    ${dict['View Environment Configuration Checkbox']}    #View Environment Configuration Checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully
	
Delegation Policy With Create Environment Configuration
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    47    48
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Configuration Tab']}    #Configuration Tab
    \    Click Element    ${dict['Create Environment Configuration Checkbox']}    #Create Environment Configuration Checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully
	
Delegation Policy With Edit Environment Configuration
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    48    49
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE DEPARTMENT ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Configuration Tab']}    #Configuration Tab
    \    Click Element    ${dict['Edit Environment Configuration Checkbox']}    #Edit Environment Configuration Checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully
	
Delegation Policy With Delete Environment Configuration
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    ${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    : FOR    ${row}    IN RANGE    49    50
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${row}   #Getting data from Login_UserSource_Users_Delegation.xls
	\    ${Condition Name}=    Read Cell Data By Name    ${worksheet}    E${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${Condition Value}=    Read Cell Data By Name    ${worksheet}    G${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${expected result}=    Read Cell Data By Name    ${worksheet}    I${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    J${row}    #Getting data from Login_UserSource_Users_Delegation.xls
    \    Go To    ${Home}/${ Delegation Policies Create}
    \    Maximize Browser Window
    \    wait until page contains Element    ${dict['DA Name Editable textbox']}
    \    Input Text    ${dict['DA Name Editable textbox']}    ${Name}    #name field
    \    Input Text    ${dict['DA Description Editable textbox']}    ${description}    #description field
    \    ${Name}=    Get Substring    ${Name}=    0    ${max name length}
    \    Click element    ${dict['DA ADD CONDITION Button']}    #Add Condition button
    \    Click Element    ${dict['DA Condition Name Dropdown Select textbox']}    #drop down list
    \    Click Element    //*[@class="ng-binding" and text()="${Condition Name}"]    #SELECT THE USERNAME ATTRIBUTE FROM THE DROP DOWN LIST
    \    Input Text    ${dict['DA Condition Value Editable textbox']}    ${Condition Value}    #Condition value to be fetched
    \    Click Element    ${dict['DA Condition Add to Table Icon']}    #Add to Table Icon
    \    Execute Javascript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Click Element    ${dict['Configuration Tab']}    #Configuration Tab
    \    Click Element    ${dict['Delete Environment Configuration Checkbox']}    #Delete Environment Configuration Checkbox
    \    Click Element    ${dict['SAVE Button']}    #save button
    \    Run Keyword If    '${expected result}'=='Pass'    delegation policy should Be Created Successfully
    \    Run Keyword If    '${expected result}'=='Fail'    Delegation pollicy should Not Be Created Successfully

*** Keywords ***
delegation policy should Be Created Successfully
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    ${successfully created}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${dict['Success Message']}
    Click Element    ${dict['Success Message']}
    Should Be True    ${successfully created}
	${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
	sleep    2
    
Delegation pollicy should Not Be Created Successfully
    ${xpath worksheet}=    Evaluate    'Delegation Policies'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Page Should Not Contain    ${dict['Success Message']}
	${worksheet}=    Evaluate    'Delegation_Policies'
    Open Excel    ${DATA_DIR}/${workbook}
    sleep    2
