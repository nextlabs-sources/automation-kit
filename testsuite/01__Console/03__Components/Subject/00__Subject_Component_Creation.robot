*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Subject    Build_Acceptance
Library           Selenium2Library
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           String
Library           DatabaseLibrary
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Library           ${LIB_DIR}/ExcelUtil.py
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${save button}    //*[@id="componentForm.val"]/div[1]/div[3]/a[3]
${name field}     //*[@id="name"]
${description field}    //*[@id="description"]
${workbook}       ${DATA_DIR}\\Console_PM_Components_Policies.xls    # ${DATA_DIR}\\Policy Creation\\Subject\\create_subject.xls
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center
${xpath worksheet}    Subject

*** Test Cases ***
Subject
    [Tags]    
    ${xpath worksheet}=    Evaluate    'Subject'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Subject_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    2    3
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Subject_Components'
    \    ${subject_id_col}=    Evaluate    0
    \    ${subject_type_col}=    Evaluate    1
    \    ${subject_name_col}=    Evaluate    2
    \    ${subject_description_col}=    Evaluate    4
    \    ${subject_tags_col}=    Evaluate    5
    \    ${subject_condition_col}=    Evaluate    6
    \    ${subject_sub_components_col}=    Evaluate    7
    \    ${subject_type}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_type_col}    ${row}
    \    ${subject_name}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_name_col}    ${row}
    \    ${subject_description}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_description_col}    ${row}
    \    ${subject_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_tags_col}    ${row}
    \    ${subject_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_condition_col}    ${row}
    \    ${subject_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_sub_components_col}    ${row}
    \    Go To    ${Home}/${Create Subject Page}
    \    sleep    3
    \    Maximize Browser Window
    \    Wait Until Page Contains Element    ${dict['Subject Type Drop Down List']}
    \    Click Element    ${dict['Subject Type Drop Down List']}    #subject component selection drop down list
    \    Wait Until Page Contains Element    ${dict['Subject Type Dropdown Selection']}//a[text()="${subject_type}"]
    \    click element    ${dict['Subject Type Dropdown Selection']}//a[text()="${subject_type}"]
    \    Wait Until Page Contains Element    ${dict['SAVE Button']}    #save button
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${subject_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${subject_description}    #description field
    \    Add Tags to Subject    ${subject_tags}
    \    Add Condition to Subject    ${subject_condition}
    \    Sleep    2
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
	
Create Subject Component Name with Valid Names
    [Tags]    
    ${xpath worksheet}=    Evaluate    'Subject'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
	set selenium implicit wait    15 seconds
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Subject_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    13    18
	\    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Subject_Components'
    \    ${subject_type}=    Read Cell Data By Name    ${worksheet}    B${row}
    \    ${subject_name}=    Read Cell Data By Name    ${worksheet}    C${row}
	\    Go To    ${Home}/${Create Subject Page}
    \    Maximize Browser Window
    \    Wait Until Page Contains Element    ${dict['Subject Type Drop Down List']}
    \    Click Element    ${dict['Subject Type Drop Down List']}    #subject component selection drop down list
    \    Wait Until Page Contains Element    ${dict['Subject Type Dropdown Selection']}//a[text()="${subject_type}"]
    \    click element    ${dict['Subject Type Dropdown Selection']}//a[text()="${subject_type}"]
    \    Wait Until Page Contains Element    ${dict['SAVE Button']}    #save button
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${subject_name}    #name field
	\    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    Click Element   //*[@id="toast-container"]/div/div[3]/div/div/div
	\    sleep   2
	
Create Subject Component Name with Invalid Special Characters
    [Tags]    
    ${xpath worksheet}=    Evaluate    'Subject'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
	set selenium implicit wait    15 seconds
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Subject_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    19    30
	\    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Subject_Components'
    \    ${subject_type}=    Read Cell Data By Name    ${worksheet}    B${row}
    \    ${subject_name}=    Read Cell Data By Name    ${worksheet}    C${row}
	\    Go To    ${Home}/${Create Subject Page}
    \    Maximize Browser Window
    #\    Wait Until Page Contains Element    ${dict['Subject Type Drop Down List']}
    #\    Click Element    ${dict['Subject Type Drop Down List']}    #subject component selection drop down list
    #\    Wait Until Page Contains Element    ${dict['Subject Type Dropdown Selection']}//a[text()="${subject_type}"]
    #\    click element    ${dict['Subject Type Dropdown Selection']}//a[text()="${subject_type}"]
    \    Wait Until Page Contains Element    ${dict['SAVE Button']}    #save button
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${subject_name}    #name field
	\    Click Element    ${dict['SAVE Button']}    #save the policy model
	\    sleep   2
	
Create Subject Component Name With Long Length
    [Documentation]    Edit Name with Long Length
    ...
    ...    Expected Result: should be able to save
    ${xpath worksheet}=    Evaluate    'Policy Model'
	Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    15 seconds
	${worksheet}=    Evaluate    'PM_SUBJECT'
    Open Excel    ${DATA_DIR}/${workbook}
	Go To    ${Home}/${List Policy Model Page}
    Maximize Browser Window
    Click Element    ${dict['PM User on PM List Page']}
    : FOR    ${row}    IN RANGE    77    80
    \    ${Name}=    Read Cell Data By Name    ${worksheet}    B${row}
    \    input text    ${dict['PM User Name Editable textbox']}    ${Name}
    \    click element    ${dict['PM User SAVE Button']}
    \    sleep   2	
    input text    ${dict['PM User Name Editable textbox']}  User
	click element    ${dict['PM User SAVE Button']}
	sleep   2
	
Create Subject Component Name is Disabled
    [Documentation]    Short name should not be editable
    ${xpath worksheet}=    Evaluate    'Policy Model'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Go To    ${Home}/${List Policy Model Page}
    Maximize Browser Window
    Click Element    ${dict['PM User on PM List Page']}
    Wait Until Page Contains Element    ${dict['PM User Short Name Editable textbox']}
    Element Should Be Disabled    ${dict['PM User Short Name Editable textbox']}
	sleep   2

Create Subject Component Description
    [Documentation]    Edit Description
    ...
    ...    Expected Result: should be able to save and verify
    ${xpath worksheet}=    Evaluate    'Policy Model'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Go To    ${Home}/${List Policy Model Page}
    Maximize Browser Window
    Click Element    ${dict['PM User on PM List Page']}
    Wait Until Page Contains Element    ${dict['PM User Description Editable textbox']}
    input text    ${dict['PM User Description Editable textbox']}    New Description:-An actor whose attributes may be referenced in a component.
    click element    ${dict['PM User SAVE Button']}
    sleep    2
    input text    ${dict['PM User Description Editable textbox']}    An actor whose attributes may be referenced in a component.
    click element    ${dict['PM User SAVE Button']}
	sleep    2
	
Create Subject Component Description With Long Length
    [Documentation]    Edit Description with Long Length
    ...
    ...    Expected Result: should be able to save
    ${xpath worksheet}=    Evaluate    'Policy Model'
	Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    15 seconds
	${worksheet}=    Evaluate    'PM_SUBJECT'
    Open Excel    ${DATA_DIR}/${workbook}
	Go To    ${Home}/${List Policy Model Page}
    Maximize Browser Window
    Click Element    ${dict['PM User on PM List Page']}
    : FOR    ${row}    IN RANGE    81    85
    \    ${Description}=    Read Cell Data By Name    ${worksheet}    D${row}
    \    input text    ${dict['PM User Description Editable textbox']}    ${Description}
    \    click element    ${dict['PM User SAVE Button']}
    \    sleep   2	
    input text    ${dict['PM User Description Editable textbox']}    An actor whose attributes may be referenced in a component.
    click element    ${dict['PM User SAVE Button']} 
    sleep   2	


*** Keywords ***
Add Tags To Subject
    [Arguments]    ${subject_tags}
    ${xpath worksheet}=    Evaluate    'Subject'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    @{tags}=    Evaluate    [x.strip() for x in "${subject_tags}".split('//')]
    ${index}=    Evaluate    1
    : FOR    ${tag}    IN    @{tags}
    \    Wait Until Page Contains Element    ${dict['Tags Editable Text Field']}
    \    Input Text    ${dict['Tags Editable Text Field']}    ${tag}    #tag field //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[2]/div[5]/div[1]/div/div[1]
    \    Click Element    ${dict['Tags Editable Text Field']}
    \    sleep    0.5
    \    Wait Until Page Contains Element    ${dict['Tags Editable Text Field']}    timeout=3
    \    sleep    2
    \    Click Element    ${dict['Tags checkbox of the first checkbox from the dropdown list']}    #tag xpath //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[2]/div[5]/div[1]/div/div[2]/ul
    \    Sleep    2
    \    Click Element    ${dict['Tags Apply Button']}    #apply tag button
    \    Sleep    1
    \    ${index}=    Evaluate    ${index}+1

Select Attribute Operators
    [Arguments]    ${index}    ${attribute_operators}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Subject'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Log    ${attribute_operators}
    @{operators}=    Evaluate    [int(s) for s in '${attribute_operators}'.split() if s.isdigit()]
    : FOR    ${operator}    IN    @{operators}
    \    ${operator}=    Evaluate    int(${operator})
    \    Log    ${dict['Operator Drop Down List']}/tr[${index}]/td[4]/div[1]/ul/li[${operator}]/label/span/span
    \    Wait Until Element Is Visible    ${dict['Operator Drop Down List']}/tr[${index}]/td[4]/div[1]/ul/li[${operator}]/label/span/span    timeout=5
    \    Click Element    ${dict['Operator Drop Down List']}/tr[${index}]/td[4]/div[1]/ul/li[${operator}]/label/span/span
    \    Sleep    1

Add Condition to Subject
    [Arguments]    ${subject_condition}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Subject'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Subject_Components'
    ${attr_name_col}=    Evaluate    10
    ${operator_col}=    Evaluate    11
    ${value_col}=    Evaluate    12
    ${index}=    Evaluate    1
    @{condition_ids}=    Evaluate    [x.strip() for x in "${subject_condition}".split(',')]
    Execute JavaScript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    : FOR    ${id}    IN    @{condition_ids}
    \    ${id}=    Convert To Number    ${id}
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Subject_Components'
    \    ${attr_name}=    Read Cell Data By Coordinates    ${worksheet}    ${attr_name_col}    ${id}
    \    ${operator}=    Read Cell Data By Coordinates    ${worksheet}    ${operator_col}    ${id}
    \    ${value}=    Read Cell Data By Coordinates    ${worksheet}    ${value_col}    ${id}
    \    Execute JavaScript    window.document.getElementsByClassName('cc-ps-create-page-common-table')[0].scrollIntoView()
    \    Wait Until Page Contains Element    ${dict['ADD CONDITION Button']}    #add condition button
    \    Click Element    ${dict['ADD CONDITION Button']}    #add condition button
    \    Wait Until Page Contains Element    ${dict['Name Drop Down List']}/tr[${index}]/td[1]/select    #select attribute name
    \    Select From List By Label    ${dict['Name Drop Down List']}/tr[${index}]/td[1]/select    ${attr_name}
    \    Wait Until Page Contains Element    ${dict['Operator Drop Down List values']}/tr[${index}]/td[2]/select    #select operator
    \    Select From List By Label    ${dict['Operator Drop Down List values']}/tr[${index}]/td[2]/select    ${operator}
    \    Wait Until Page Contains Element    ${dict['Value Text Field']}/tr[${index}]/td[3]/div[1]/textarea    #input value
    \    Input Text    ${dict['Value Text Field']}/tr[${index}]/td[3]/div[1]/textarea    ${value}
    \    Click Element    ${dict['Condition Tick Button']}/tr[${index}]/td[4]/i[1]    #confirm add condition
    \    ${index}=    Evaluate    ${index}+1
    \    Sleep    1
