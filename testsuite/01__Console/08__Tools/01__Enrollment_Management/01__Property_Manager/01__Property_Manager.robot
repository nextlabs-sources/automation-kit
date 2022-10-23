*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        PropertyManager   ADDPropertyManager
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           Collections
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       Configuration_Tools.xls    # \ ..\automation-kit\testdata\Control Center\Configuration_Tools.xls
${worksheet}      Property_Manager
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Enrollment
${add property button}    //*[@id="property_btn_add"]
${name missing warning}    Name is mandatory.
${shortname missing warning}    Short name is mandatory.
${name field}     //*[@id="name"]
${shortname field}    //*[@id="sname"]
${description field}    //*[@id="description"]

*** Test Cases ***
Property Manger Creation
    [Tags]
	${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
	${index}=    Evaluate    1
    ${attribute_index}=    Evaluate    14
	Go To    ${Home}/${Enrollment Management List}
    Maximize browser window
	Wait until page contains Element    ${dict['Property Manager Menu']}
    Click Element    ${dict['Property Manager Menu']}
    : FOR    ${rows}    IN RANGE    17    24
    \    Open Excel    ${DATA_DIR}/${workbook} 
    \    ${attribute_entity_type}    Read Cell Data By Name    ${worksheet}    B${rows}
    \    ${attribute_name}    Read Cell Data By Name    ${worksheet}    C${rows}
    \    ${attribute_short_name}    Read Cell Data By Name    ${worksheet}    D${rows}
    \    ${attribute_data_type}    Read Cell Data By Name    ${worksheet}    E${rows}    
    \    Wait Until Page Contains Element    ${dict['PM Add Property Button']}    #ADD PROPERTY BUTTON
    \    Click Element    ${dict['PM Add Property Button']}
	\    Wait Until Page Contains Element    //*[@id="property_btn_entityName_${attribute_index}"]    #entity type drop down
	\    Input Text    //*[@id="property_input_label_${attribute_index}"]    ${attribute_name}
    \    Input Text    //*[@id="property_input_name_${attribute_index}"]    ${attribute_short_name}  //*[@id="property-btn-type-14"]
	\    Click Element    //*[@id="property_btn_entityName_${attribute_index}"]    #xpath of entity type
    \    ${data entity type int}=    Set Variable If    '${attribute_entity_type}'=='User'    1
    \    ${data entity type int}=    Set Variable If    '${attribute_entity_type}'=='Application'    2
    \    ${data entity type int}=    Set Variable If    '${attribute_entity_type}'=='Host'    3    ${data entity type int}
    \    Log    ${data entity type int}
    \    Click Element    //*[@id="property_btn_entityName_${attribute_index}"]
    
    \    Wait Until Page Contains Element    //*[@id="cc-sort-by-select"]/ul/li[${data entity type int}]    timeout=5
    \    Click Element    //*[@id="cc-sort-by-select"]/ul/li[${data entity type int}]    #select the correct data type
    \    Wait Until Page Contains Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/button    timeout=5    #wait until the add attribute button appear
    \    Click Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/button    #operator select box
    \    Sleep    0.5
    \    Wait Until Element Is Visible    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/ul/li[1]/label/span/span    #first operator in the list
    \    Sleep    1
    \    Click Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/ul/li[1]/label/span/span    # unselect the first operator
    \    Log    sdfsdfds
    \    Log    unselect the first checkbox
    \    Log    ${index}
    \    Select Attribute Operators    ${index}    ${attribute_operators}
    \    Wait Until Page Contains Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[6]/i[1]    timeout=5    #add to table button
    \    Click Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[6]/i[1]    #add to table button
    \    ${index}=    Evaluate    ${index}+1
    \    Log    One attribute added
    \    Sleep    1

testing search
    Go To    ${Home}/${Property Manager List}
    Maximize Browser Window
    Click Element    //*[@id="property_btn_search"]
    page should contain element    //*[@id="property_btn_search_submit"]
    ${Status}=    Run Keyword And Return Status    Element Should Be Enabled    //*[@id="property_btn_search_save"]
    Run Keyword If    '${Status}'=='True'    Click Element    //*[@id="property_btn_search_save"]
    go to    ${home}/${reporter_dashboard}
    Select Window    Control Center Rreporter: Dashboard

*** Keywords ***

Select Attribute Operators
    [Arguments]    ${index}    ${attribute_operators}
    #    Wait Until Page Contains Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/ul/li[1]/label/span/span    #first operator in the list
    #    Click Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/ul/li[1]/label/span/span    # unselect the first operator
    Log    ${attribute_operators}
    @{operators}=    Evaluate    [int(s) for s in '${attribute_operators}'.split() if s.isdigit()]
    Log    ${operators}
    : FOR    ${operator}    IN    @{operators}
    \    ${operator}=    Evaluate    int(${operator})
    \    Log    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/ul/li[${operator}]/label/span/span
    \    Wait Until Element Is Visible    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/ul/li[${operator}]/label/span/span    timeout=5
    \    Click Element    //*[@id="attr"]/div/div[1]/table/tbody/tr[${index}]/td[4]/div[1]/ul/li[${operator}]/label/span/span
    #    Sleep    1

