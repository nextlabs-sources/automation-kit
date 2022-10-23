*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Policy
Library           Selenium2Library
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           String
Library           Collections
Library           XML
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${name missing warning}    Name is mandatory.
${workbook}       ${DATA_DIR}\\Console_PM_Components_Policies.xls    # ${DATA_DIR}\\Policy Creation\\Policy\\create_policy.xls
${xpath workbook}    Xpaths.xls
${xpath worksheet}    Policies

*** Test cases ***
Policy
    [Tags]    sanity
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Policies'
    ${name field}=    Read Cell Data By Name    ${xpath worksheet}    C13
    ${description field}=    Read Cell Data By Name    ${xpath worksheet}    C21
    ${expression label}=    Read Cell Data By Name    ${xpath worksheet}    C87
    ${expression text area}=    Read Cell Data By Name    ${xpath worksheet}    C91
    ${connection dropdown list}=    Read Cell Data By Name    ${xpath worksheet}    C97
    ${policy effect switch}=    Read Cell Data By Name    ${xpath worksheet}    C34
    ${heartbeat increment box}=    Read Cell Data By Name    ${xpath worksheet}    C105
    ${Save Button}=    Read Cell Data By Name    ${xpath worksheet}    C6
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Policies'
    ${policy_id_col}=    Evaluate    0
    ${policy_name_col}=    Evaluate    1
    ${policy_description_col}=    Evaluate    2
    ${policy_tags_col}=    Evaluate    3
    ${policy_effect_col}=    Evaluate    4
    ${subject_components_col}=    Evaluate    5
    ${resource_components_col}=    Evaluate    13
    ${action_components_col}=    Evaluate    20
    ${expression_col}=    Evaluate    21
    ${connection_type_col}=    Evaluate    22
    ${heartbeat_col}=    Evaluate    23
    ${policy_effective_duration_col}=    Evaluate    26
    ${allow_obligation_col}=    Evaluate    27
    ${deny_obligation_col}=    Evaluate    28
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    3    ${nrows}
    \    ${policy_name}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_name_col}    ${row}
    \    ${policy_description}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_description_col}    ${row}
    \    ${policy_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_tags_col}    ${row}
    \    ${policy_effect}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effect_col}    ${row}
    \    ${subject_components}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_components_col}    ${row}
    \    ${resource_components}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_components_col}    ${row}
    \    ${action_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_components_col}    ${row}
    \    ${expression}=    Read Cell Data By Coordinates    ${worksheet}    ${expression_col}    ${row}
    \    ${connection_type}=    Read Cell Data By Coordinates    ${worksheet}    ${connection_type_col}    ${row}
    \    ${heartbeat}=    Read Cell Data By Coordinates    ${worksheet}    ${heartbeat_col}    ${row}
    \    ${policy_effective_duration}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_duration_col}    ${row}
    \    ${allow_obligation}=    Read Cell Data By Coordinates    ${worksheet}    ${allow_obligation_col}    ${row}
    \    ${deny_obligation}=    Read Cell Data By Coordinates    ${worksheet}    ${deny_obligation_col}    ${row}
    \    Go To    ${Home}/${Create Policy Page}
    \    Maximize Browser Window
    \    Wait Until Page Contains Element    ${Save Button}    #save button
    \    Wait Until Page Contains Element    ${name field}
    \    Input Text    ${name field}    ${policy_name}    #name field
    \    Input Text    ${description field}    ${policy_description}    #description field
    \    Add Tags to Policy    ${policy_tags}
    \    Run Keyword if    '${policy_effect}'=='DENY'    Click Element    ${policy effect switch}
    \    Add Subjects To Policy    ${subject_components}
    \    Add Resources To Policy    ${resource_components}
    \    Add Actions To Policy    ${action_components}
    \    Input Text    ${expression text area}    ${expression}    #expression field
    \    Click Element    ${expression label}
    \    #Click Element    //label[@for="connectionType"]
    \    Select From List By Label    ${connection dropdown list}    ${connection_type}    #connectiontype field
    \    Input Text    ${heartbeat increment box}    ${heartbeat}    #hearbeat field
    \    Run Keyword If    "${policy_effective_duration}"!="Always"    Policy Effective Duration    ${policy_effective_duration}
    \    Add Obligations To Policy    ${allow_obligation}    1    #add allow obligations
    \    Add Obligations To Policy    ${deny_obligation}    2    #add deny obligations
    \    Sleep    2
    \    Click Element    ${Save Button}
    \    Sleep    2

*** Keywords ***
Add Tags To Policy
    [Arguments]    ${policy_tags}
    [Documentation]    Adding tags to policy from excel sheet
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Policies'
    ${tags editable field}=    Read Cell Data By Name    ${xpath worksheet}    C26
    ${tag selection}=    Read Cell Data By Name    ${xpath worksheet}    D27
    ${apply tag button}=    Read Cell Data By Name    ${xpath worksheet}    D28
    @{tags}=    Evaluate    [x.strip() for x in "${policy_tags}".split('//')]
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Policies'
    ${index}=    Evaluate    1
    : FOR    ${tag}    IN    @{tags}
    \    Wait Until Page Contains Element    ${tags editable field}
    \    sleep    3
    \    Input Text    ${tags editable field}    ${tag}    #tag field //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[2]/div[5]/div[1]/div/div[1]
    \    sleep    5
    \    #    Wait Until Page Contains Element    //*[@id="policyForm.val"]/div[2]/div[2]/div[2]/div[4]/div[1]/div/div[2]/ul/li/label    timeout=3
    \    Click Element    ${tag selection}    #tag xpath //*[@id="cc-ps-main-content"]/div/div/div/div[2]/div[2]/form/div[2]/div[5]/div[1]/div/div[2]/ul
    \    Sleep    1
    \    Click Element    ${apply tag button}    #apply tag button
    \    Sleep    1
    \    ${index}=    Evaluate    ${index}+1

Add Subjects To Policy
    [Arguments]    ${subjects}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Policies'
    ${Search for subject dropdown List first Check Box}=    Read Cell Data By Name    ${xpath worksheet}    C41
    ${subject add condition button}=    Read Cell Data By Name    ${xpath worksheet}    C46
    ${index}=    Evaluate    1
    @{and_components}=    Evaluate    [x.strip() for x in "${subjects}".split('&&')]
    ${index}    Evaluate    2
    ${length}=    Get Length    ${and_components}
    : FOR    ${and_block}    IN    @{and_components}
    \    Exit For Loop if    "${subjects}"=="none"
    \    @{and_block_details}=    Split String    ${and_block}    ::
    \    ${in_or_not}=    Get From List    ${and_block_details}    0
    \    ${component_string}=    Get From List    ${and_block_details}    1
    \    sleep    3
    \    Select From List By Label    ${Search for subject dropdown List first Check Box}/div[${index}]/div[1]/select    ${in_or_not}
    \    @{or_components}=    Evaluate    [x.strip() for x in "${component_string}".split('||')]
    \    Add Subject Component    ${or_components}    ${index}
    \    Run Keyword If    ${index}!=${length}+1    Click Element    ${subject add condition button}
    \    ${index}    Evaluate    ${index} + 1

Add Resources To Policy
    [Arguments]    ${resources}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Policies'
    ${Search for resouce dropdown List first Check Box}=    Read Cell Data By Name    ${xpath worksheet}    D60
    ${resource add condition button}=    Read Cell Data By Name    ${xpath worksheet}    C65
    ${index}=    Evaluate    1
    @{and_components}=    Evaluate    [x.strip() for x in "${resources}".split('&&')]
    ${index}    Evaluate    2
    ${length}=    Get Length    ${and_components}
    : FOR    ${and_block}    IN    @{and_components}
    \    Exit For Loop if    "${resources}"=="none"
    \    @{and_block_details}=    Split String    ${and_block}    ::
    \    ${in_or_not}=    Get From List    ${and_block_details}    0
    \    ${component_string}=    Get From List    ${and_block_details}    1
    \    Select From List By Label    ${Search for resouce dropdown List first Check Box}/div[${index}]/div[1]/select    ${in_or_not}
    \    @{or_components}=    Evaluate    [x.strip() for x in "${component_string}".split('||')]
    \    Add Resource Component    ${or_components}    ${index}
    \    Run Keyword If    ${index}!=${length}+1    Click Element    ${resource add condition button}
    \    ${index}    Evaluate    ${index} + 1

Add Actions To Policy
    [Arguments]    ${actions}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Policies'
    ${action input text field}=    Read Cell Data By Name    ${xpath worksheet}    D79
    ${action selection from drop down list}=    Read Cell Data By Name    ${xpath worksheet}    D82
    ${action appply button}=    Read Cell Data By Name    ${xpath worksheet}    C84
    ${index}=    Evaluate    1
    @{action_components}    Evaluate    [x.strip() for x in "${actions}".split(',')]
    ${length}=    Get Length    ${action_components}
    : FOR    ${component}    IN    @{action_components}
    \    Exit For Loop if    "${actions}"=="none"
    \    @{component_details}=    Split String    ${component}    :
    \    ${policy_model}=    Get From List    ${component_details}    0
    \    ${action}=    Get From List    ${component_details}    1
    \    Input Text    ${action input text field}/div[${index}]/input    ${action}
    \    Sleep    4
    \    Wait Until Page Contains Element    ${action selection from drop down list}/span[text()[contains(.,"${action}")]]    #action with the correct policy_model    #//*[@id="policyForm.val"]/div[2]/div[2]/div[8]/div/div/div[1]/div[2]/ul/li/label/span[text()="${action}"]/span[text()="${space}\u00A0(${policy_model})"]
    \    Sleep    4
    \    Click Element    ${action selection from drop down list}/span[text()[contains(.,"${action}")]]    #click the checkbox
    \    Sleep    4
    \    Click Element    ${action appply button}    #apply button
    \    ${index}    Evaluate    ${index} + 1

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

Add Subject Component
    [Arguments]    ${components}    ${index}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Policies'
    ${search for subject input text field}=    Read Cell Data By Name    ${xpath worksheet}    C40
    ${Search for subject dropdown List first Check Box}=    Read Cell Data By Name    ${xpath worksheet}    D41
    ${subject dropdown apply button}=    Read Cell Data By Name    ${xpath worksheet}    C45
    ${sub_index}=    Evaluate    1
    : FOR    ${component}    IN    @{components}
    \    @{component_details}=    Split String    ${component}    :
    \    ${policy_model}=    Get From List    ${component_details}    0
    \    ${subject}=    Get From List    ${component_details}    1
    \    Click Element    ${search for subject input text field}
    \    Input Text    ${search for subject input text field}    ${subject}
    \    sleep    5
    \    #    Wait Until Page Contains Element    //span[@class="cc-ps-label-for-checkbox-radio ng-binding"]    # check box for the subject with the correct policy model
    \    Click Element    ${Search for subject dropdown List first Check Box}    #//span[@class="cc-ps-label-for-checkbox-radio ng-binding"]
    \    Click Element    ${subject dropdown apply button}    #//button[@class="btn btn-default go-as-you-type-btn-apply ng-binding"]
    \    ${sub_index}=    Evaluate    ${sub_index}+1

Add Resource Component
    [Arguments]    ${components}    ${index}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${xpath worksheet}=    Evaluate    'Policies'
    ${search for resource type text field}=    Read Cell Data By Name    ${xpath worksheet}    D59
    ${search for resource type text dropdown}=    Read Cell Data By Name    ${xpath worksheet}    C63
    ${search for resource apply button}=    Read Cell Data By Name    ${xpath worksheet}    C64
    ${sub_index}=    Evaluate    1
    : FOR    ${component}    IN    @{components}
    \    @{component_details}=    Split String    ${component}    :
    \    ${policy_model}=    Get From List    ${component_details}    0
    \    ${resource}=    Get From List    ${component_details}    1
    \    Input Text    ${search for resource type text field}/div[${index}]/div[2]/div[1]/div[${sub_index}]/input    ${resource}
    \    Sleep    5
    \    #    Wait Until Page Contains Element    //*[@id="policyForm.val"]/div[2]/div[2]/div[6]/div/div/div[${index}]/div[2]/div[2]/ul/li/label/span[text()="${resource}"]/span[text()="${space}\u00A0(${policy_model})"]    # check box for the resource with the correct policy model
    \    Click Element    ${search for resource type text dropdown}    #//*[@id="policyForm.val"]/div[2]/div[2]/div[6]/div/div/div[${index}]/div[2]/div[2]/ul/li/label/span[text()="${resource}"]/span[text()="${space}\u00A0(${policy_model})"]
    \    Click Element    ${search for resource apply button}
    \    ${sub_index}=    Evaluate    ${sub_index}+1

Add Obligation Attribute
    [Arguments]    ${block_index}    ${obligation_attributes}    ${obligation_name}    ${obligation_policy_model}
    @{attributes}=    Evaluate    [x.strip() for x in '${obligation_attributes}'.split(',')]
    ${attribute_name_col}=    Evaluate    9
    ${attribute_value_col}=    Evaluate    10
    ${worksheet}=    Evaluate    'Policy_OBL_Attr'
    ${index}=    Evaluate    1
    : FOR    ${id}    IN    @{attributes}
    \    ${id}=    Convert To Bytes    ${id}
    \    ${attribute_name}=    Read Cell Data By Coordinates    ${worksheet}    ${attribute_name_col}    ${id}
    \    ${attribute_value}=    Read Cell Data By Coordinates    ${worksheet}    ${attribute_value_col}    ${id}
    \    Sleep    5
    \    Run Keyword if    "${obligation_policy_model}" != "none"    Input Text    //*[@id="policyForm.val"]/div[2]/div[2]/div[14]/div[${block_index}]/div/div[3]/div[.//text()="${obligation_name}"]/p/span[text()="(${obligation_policy_model})"]/../../div/div[1]/div[.//text()="${attribute_name}"]/div[1]/textarea    ${attribute_value}    #attribute value field
    \    Sleep    5
    \    Run Keyword if    "${obligation_policy_model}" == "none"    Input Text    //*[@id="policyForm.val"]/div[2]/div[2]/div[14]/div[${block_index}]/div/div[2]/div[.//text()="${obligation_name}"]/p/span[text()="(${obligation_policy_model})"]/../../div/div[1]/div[.//text()="${attribute_name}"]/div[1]/textarea    ${attribute_value}    #attribute value field

Add Obligations To Policy
    [Arguments]    ${allow_obligations}    ${block_index}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Policy_OBL_Attr'
    ${obligation_name_col}=    Evaluate    1
    ${obligation_policy_model_col}=    Evaluate    2
    ${obligation_attributes_col}=    Evaluate    3
    @{obligation_ids}=    Evaluate    [x.strip() for x in "${allow_obligations}".split(',')]
    : FOR    ${id}    IN    @{obligation_ids}
    \    ${id}=    Convert To Number    ${id}
    \    ${obligation_name}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_name_col}    ${id}
    \    ${obligation_policy_model}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_policy_model_col}    ${id}
    \    ${obligation_attributes}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_attributes_col}    ${id}
    \    sleep    5
    \    ${condition}=    Run Keyword if    "${obligation_policy_model}" !="none"    Run keyword And Return Status    Wait Until Page Contains Element    //*[@id="policyForm.val"]/div[2]/div[2]/div[14]/div[${block_index}]/div/div[3]/div[.//text()="${obligation_name}"]/p/span[text()="(${obligation_policy_model})"]/../span[1]/span[contains(@class, "checked")]
    \    ...    timeout=2    error=false    # if the switch is not checked
    \    Sleep    2
    \    Run Keyword if    '${condition}'=='False'    Run Keyword if    "${obligation_policy_model}" !="none"    Click Element    //*[@id="policyForm.val"]/div[2]/div[2]/div[14]/div[${block_index}]/div/div[3]/div[.//text()="${obligation_name}"]/p/span[text()="(${obligation_policy_model})"]/../span[1]/span
    \    ...    # if policy_model is presented
    \    Sleep    2
    \    ${condition}=    Run Keyword if    "${obligation_policy_model}" =="none"    Run keyword And Return Status    Wait Until Page Contains Element    //*[@id="policyForm.val"]/div[2]/div[2]/div[14]/div[${block_index}]/div/div[2]/div[.//text()="${obligation_name}"]/p/span[1]/span[contains(@class, "checked")]
    \    ...    timeout=2    error=false    # if the switch is not checked
    \    Sleep    2
    \    Run Keyword if    '${condition}'=='False'    Run Keyword if    "${obligation_policy_model}" =="none"    Click Element    //*[@id="policyForm.val"]/div[2]/div[2]/div[14]/div[${block_index}]/div/div[2]/div[.//text()="${obligation_name}"]/p/span[1]/span
    \    ...    # if policy_model is not presented
    \    Sleep    2
    \    #    Run Keyword if    "${obligation_attributes}"!="none"    Add Obligation Attribute    ${block_index}    ${obligation_attributes}
    \    ...    # ${obligation_name}    # ${obligation_policy_model}
    #    Click Element    ${save button}
