*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        PolicyModelSubject
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary

*** Variables ***
${add property button}    //*[@id="property_btn_add"]
${name missing warning}    Name is mandatory.
${shortname missing warning}    Short name is mandatory.
${name field}     //*[@id="name"]
${shortname field}    //*[@id="sname"]
${description field}    //*[@id="description"]
${workbook}       ${DATA_DIR}\\Tools.xls

*** Test Cases ***
Property Manager Creatiton
    [Tags]
    ${worksheet}=    Evaluate    'property_manager'
    ${attribute_entity_type_col}=    Evaluate    1
    ${attribute_name_col}=    Evaluate    2
    ${attribute_short_name_col}=    Evaluate    3
    ${attribute_data_type_col}=    Evaluate    4
    Open Excel    ${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    ${index}=    Evaluate    1
    ${attribute_index}=    Evaluate    18
    : FOR    ${row}    IN RANGE    1    ${nrows}
    \    Go To    ${Home}/${Property Manager List}
    \    Maximize Browser Window
    \    Wait Until Page Contains Element    ${add property button}    #ADD PROPERTY BUTTON
    \    ${attribute_entity_type}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_entity_type_col}    ${row}
    \    ${attribute_name}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_name_col}    ${row}
    \    ${attribute_short_name}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_short_name_col}    ${row}
    \    ${attribute_data_type}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_data_type_col}    ${row}
    \    Wait Until Page Contains Element    ${add property button}    timeout=5
    \    Click Element    ${add property button}    #xpath of add attribute link
    \    Wait Until Page Contains Element    //*[@id="property_btn_entityName_${attribute_index}"]    #entity type drop down
    \    Input Text    //*[@id="property_input_label_${attribute_index}"]    ${attribute_name}
    \    Input Text    //*[@id="property_input_name_${attribute_index}"]    ${attribute_short_name}
    \    Click Element    //*[@id="property_btn_entityName_${attribute_index}"]    #xpath of entity type
    \    ${data entity type int}=    Set Variable If    '${attribute_entity_type}'=='String'    1
    \    ${data entity type int}=    Set Variable If    '${attribute_entity_type}'=='Application'    2
    \    ${data entity type int}=    Set Variable If    '${attribute_entity_type}'=='Host'    3
    \    Log    ${data entity type int}
    \    #Click Element    //*[@id="property_btn_entityName_${attribute_index}"]
    \    #Wait Until Page Contains Element    //*[@id="cc-sort-by-select"]/ul/li[${data entity type int}]    timeout=5
    \    #Click Element    //*[@id="property_btn_entityName_${attribute_index}"]
    \    #Click Element    //*[@id="cc-sort-by-select"]/ul/li[${data entity type int}]    #select the correct data type
    \    Press Key    //*[@id="property_btn_entityName_${attribute_index}"]    Enter
    \    Wait until page contains Element    //*[@id="cc-sort-by-select"]/ul/li[${data entity type int}]
    \    Mouse Over    //*[@id="cc-sort-by-select"]/ul/li[${data entity type int}]
    \    Click Element    //*[@id="cc-sort-by-select"]/ul/li[${data entity type int}]

*** Keywords ***
Add Attributes
    [Arguments]    ${policy_model_subject_attribute}
    Sleep    2
    Click Element    ${add property button}    # ADD POPERTY BUTTON
    ${attribute_entity_type_col}=    Evaluate    2
    ${attribute_name_col}=    Evaluate    3
    ${attribute_short_name_col}=    Evaluate    4
    ${attribute_data_type_col}=    Evaluate    5
    ${worksheet}=    Evaluate    'property_manager'
    ${index}=    Evaluate    1
    ${attribute_index}=    Evaluate    16
    @{attribute_ids}=    Evaluate    [x.strip() for x in "${property_manager_subject_attribute}".split(',')]
    : FOR    ${id}    IN    @{attribute_ids}
    \    ${id}=    Convert To Number    ${id}
    \    ${attribute_entity_type}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_entity_type_col}    ${id}
    \    ${attribute_name}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_name_col}    ${id}
    \    ${attribute_short_name}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_short_name_col}    ${id}
    \    ${attribute_data_type}    Read Cell Data By Coordinates    ${worksheet}    ${attribute_data_type_col}    ${id}
    \    Wait Until Page Contains Element    ${add property button}    timeout=5
    \    Click Element    ${add property button}    #xpath of add attribute link
    \    Wait Until Page Contains Element    //*[@id="property_btn_entityName_${attribute_index}"]    #entity type drop down
    \    Input Text    //*[@id="property_input_label_${attribute_index}"]    ${attribute_name}
    \    Input Text    //*[@id="property_input_name_${attribute_index}"]    ${attribute_short_name}
    \    Click Element    //*[@id="property_btn_entityName_${attribute_index}"]    #xpath of entity type
    \    ${data entity type int}=    Set Variable If    '${attribute_entity_type}'=='String'    1
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

Add Obligations To Policy Model
    [Arguments]    ${policy_model_obligations}
    Sleep    2
    Click Element    //*[@id="attr"]/ul/li[4]/a/uib-tab-heading/span    #click action tab to add obligations
    ${obligation_name_col}=    Evaluate    1
    ${obligation_short_name_col}=    Evaluate    2
    ${obligation_params_col}=    Evaluate    3
    ${worksheet}=    Evaluate    'policy_model_obligation'
    ${index}=    Evaluate    1
    @{obligation_ids}=    Evaluate    [x.strip() for x in "${policy_model_obligations}".split(',')]
    : FOR    ${id}    IN    @{obligation_ids}
    \    ${id}=    Convert To Number    ${id}
    \    ${obligation_name}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_name_col}    ${id}
    \    ${obligation_short_name}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_short_name_col}    ${id}
    \    ${obligation_params}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_params_col}    ${id}
    \    Wait Until Page Contains Element    //*[@id="attr"]/div/div[4]/div/div[2]/input    #add obligation button
    \    Click Element    //*[@id="attr"]/div/div[4]/div/div[2]/input    #add obligation button
    \    Wait Until Page Contains Element    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[1]/input    #input name of obligation
    \    Input Text    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[1]/input    ${obligation_name}
    \    Wait Until Page Contains Element    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[2]/input    #input short name field
    \    Input Text    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[2]/input    ${obligation_short_name}
    \    Wait Until Page Contains Element    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[3]/i[1]    #confirm add obligation button
    \    Click Element    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[3]/i[1]    #confirm add obligation button
    \    Wait Until Page Contains Element    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[1]/label[1]    #show params
    \    Click Element    //*[@id="attr"]/div/div[4]/div/table/tbody[${index}]/tr/td[1]/label[1]    #show params
    \    Add Obligation Params    ${index}    ${obligation_params}
    \    ${index}=    Evaluate    ${index}+1
    \    Sleep    1
    #${EMPTY}
