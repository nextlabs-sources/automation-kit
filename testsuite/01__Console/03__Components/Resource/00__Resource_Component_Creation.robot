*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Resource
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary

*** Variables ***
${workbook}       ${DATA_DIR}\\Console_PM_Components_Policies.xls    # ${DATA_DIR}\\Policy Creation\\Resource\\create_resource.xls
${worksheet}      Resource_Components
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center
${xpath worksheet}    Reporter

*** Test Cases ***
Resource
    [Tags]
    ${xpath worksheet}=    Evaluate    'Resource'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${name field}=    Read Cell Data By Name    ${xpath worksheet}    C18
    ${description field}=    Read Cell Data By Name    ${xpath worksheet}    C26
    ${resource type field}=    Read Cell Data By Name    ${xpath worksheet}    C12
    ${Save Button}=    Read Cell Data By Name    ${xpath worksheet}    C6
    ${ResourceType DropDown List Selection}=    Read Cell Data By Name    ${xpath worksheet}    D13
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Resource_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    : FOR    ${row}    IN RANGE    2    ${nrows}
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Resource_Components'
    \    ${resource_id_col}=    Evaluate    0
    \    ${resource_name_col}=    Evaluate    2
    \    ${resource_type_col}=    Evaluate    1
    \    ${resource_description_col}=    Evaluate    4
    \    ${resource_tags_col}=    Evaluate    5
    \    ${resource_condition_col}=    Evaluate    6
    \    ${resource_sub_components_col}=    Evaluate    7
    \    ${resource_name}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_name_col}    ${row}
    \    ${resource_type}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_type_col}    ${row}
    \    ${resource_description}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_description_col}    ${row}
    \    ${resource_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_tags_col}    ${row}
    \    ${resource_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_condition_col}    ${row}
    \    ${resource_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_sub_components_col}    ${row}
    \    Go To    ${Home}/${Create Resource Page}
    \    Maximize browser window
    \    #    Close Overlay
    \    Wait Until Page Contains Element    ${Save Button}    #save button
    \    Wait Until Page Contains Element    ${resource type field}
    \    sleep    5
    \    Click Element    ${resource type field}    #type field
    \    Sleep    3
    \    Wait Until Element is Visible    //*[@id="componentForm.val"]/div[2]/div[2]/div[2]/div[2]/div[1]/ul/li/a[text()="${resource_type}"]
    \    Click Element    //*[@id="componentForm.val"]/div[2]/div[2]/div[2]/div[2]/div[1]/ul/li/a[text()="${resource_type}"]    #select resource type
    \    Input Text    ${name field}    ${resource_name}    #name field
    \    Input Text    ${description field}    ${resource_description}    #description field
    \    Add Tags to Resource    ${resource_tags}
    \    Add Condition to Resource    ${resource_condition}
    \    Sleep    2
    Click Element    ${Save Button}    #save the policy model

*** Keywords ***
Add Tags To Resource
    [Arguments]    ${resource_tags}
    ${xpath worksheet}=    Evaluate    'Resource'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${tags editable field}=    Read Cell Data By Name    ${xpath worksheet}    C31
    ${apply tag button}=    Read Cell Data By Name    ${xpath worksheet}    C33
    ${tag selection}=    Read Cell Data By Name    ${xpath worksheet}    C60
    ${tag dropdown menu}=    Read Cell Data By Name    ${xpath worksheet}    C32
    @{tags}=    Evaluate    [x.strip() for x in "${resource_tags}".split('//')]
    ${index}=    Evaluate    1
    : FOR    ${tag}    IN    @{tags}
    \    Wait Until Page Contains Element    ${tags editable field}
    \    Input Text    ${tags editable field}    ${tag}
    \    Click element    ${tags editable field}
    \    Wait Until Page Contains Element    ${tag dropdown menu}    timeout=3
    \    Sleep    2
    \    Click Element    ${tag selection}
    \    Sleep    2
    \    Click Element    ${apply tag button}    #apply tag button
    \    Sleep    1
    \    ${index}=    Evaluate    ${index}+1

Add Condition to Resource
    [Arguments]    ${resource_condition}
    ${xpath worksheet}=    Evaluate    'Resource'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${add condition}=    Read Cell Data By Name    ${xpath worksheet}    C38
    ${Select attribute name}=    Read Cell Data By Name    ${xpath worksheet}    D61
    ${Save Button}=    Read Cell Data By Name    ${xpath worksheet}    C6
    ${operator name list}=    Read Cell Data By Name    ${xpath worksheet}    D45
    ${value text field}=    Read Cell Data By Name    ${xpath worksheet}    D47
    ${condition}=    Read Cell Data By Name    ${xpath worksheet}    D48
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Resource_Components'
    ${attr_name_col}=    Evaluate    10
    ${operator_col}=    Evaluate    11
    ${value_col}=    Evaluate    12
    ${index}=    Evaluate    1
    @{condition_ids}=    Evaluate    [x.strip() for x in "${resource_condition}".split(',')]
    Comment    ${id}=    Evaluate    2
    : FOR    ${id}    IN    @{condition_ids}
    \    ${id}=    Convert To Number    ${id}
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Resource_Components'
    \    ${attr_name}=    Read Cell Data By Coordinates    ${worksheet}    ${attr_name_col}    ${id}
    \    ${operator}=    Read Cell Data By Coordinates    ${worksheet}    ${operator_col}    ${id}
    \    ${value}=    Read Cell Data By Coordinates    ${worksheet}    ${value_col}    ${id}
    \    Wait Until Page Contains Element    ${add condition}    #add condition button
    \    Click Element    ${add condition}    #add condition button
    \    Wait Until Page Contains Element    ${Select attribute name}/tr[${index}]/td[1]/select    #select attribute name
    \    Comment    Click Element    //*[@id="componentForm.val"]/div[2]/div[2]/div[6]/div[2]/table/tbody/tr[${index}]/td[1]/select
    \    Sleep    2
    \    Select From List By Label    ${Select attribute name}/tr[${index}]/td[1]/select    ${attr_name}
    \    Wait Until Page Contains Element    ${operator name list}/tr[${index}]/td[2]/select    #select operator
    \    Select From List By Label    ${operator name list}/tr[${index}]/td[2]/select    ${operator}
    \    Wait Until Page Contains Element    ${value text field}/tr[${index}]/td[3]/div[1]/textarea    #input value
    \    Input Text    ${value text field}/tr[${index}]/td[3]/div[1]/textarea    ${value}
    \    Click Element    ${condition}/tr[${index}]/td[4]/i[1]    #confirm add condition
    \    ${index}=    Evaluate    ${index}+1
    \    Sleep    1
    \    Click Element    ${Save Button}
