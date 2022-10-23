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
Library           ${LIB_DIR}/ExcelUtil.py

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
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Resource_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    40 seconds
    FOR    ${row}    IN RANGE    2    4
        Open Excel    ${workbook}
        ${worksheet}=    Evaluate    'Resource_Components'
        ${resource_id_col}=    Evaluate    0
        ${resource_name_col}=    Evaluate    2
        ${resource_type_col}=    Evaluate    1
        ${resource_description_col}=    Evaluate    4
        ${resource_tags_col}=    Evaluate    5
        ${resource_condition_col}=    Evaluate    6
        ${resource_sub_components_col}=    Evaluate    7
        ${resource_name}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_name_col}    ${row}
        ${resource_type}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_type_col}    ${row}
        ${resource_description}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_description_col}    ${row}
        ${resource_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_tags_col}    ${row}
        ${resource_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_condition_col}    ${row}
        ${resource_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_sub_components_col}    ${row}
        Go To    ${Home}/${Create Resource Page}
        Maximize browser window
        #    Close Overlay
        Wait Until Page Contains Element    ${dict['Resource Component SAVE Button']}    #save button
        Wait Until Page Contains Element    ${dict['Resource Component Type Drop Down List']}
        sleep    5
        Click Element    ${dict['Resource Component Type Drop Down List']}    #type field
        Sleep    3
        Wait Until Element is Visible    ${dict['Resource Component Type Drop Down List Selection']}/a[text()="${resource_type}"]
        Click Element    ${dict['Resource Component Type Drop Down List Selection']}/a[text()="${resource_type}"]    #select resource type
        Input Text    ${dict['Display Name Editiable Text Field']}    ${resource_name}    #name field
        Input Text    ${dict['Desciption Editable Text Field']}    ${resource_description}    #description field
        Add Tags to Resource    ${resource_tags}
        Add Condition to Resource    ${resource_condition}
        Click Element    ${dict['Resource Component SAVE Button']}    #save the policy model
        sleep    5
    END

*** Keywords ***
Add Tags To Resource
    [Arguments]    ${resource_tags}
    ${xpath worksheet}=    Evaluate    'Resource'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    @{tags}=    Evaluate    [x.strip() for x in "${resource_tags}".split('//')]
    ${index}=    Evaluate    1
    FOR    ${tag}    IN    @{tags}
        Wait Until Page Contains Element    ${dict['Tags Editable Text Field']}
        Input Text    ${dict['Tags Editable Text Field']}    ${tag}
        Click element    ${dict['Tags Editable Text Field']}
        Wait Until Page Contains Element    ${dict['Tags Check Box of 1st Drop Down List']}    timeout=3
        Sleep    2
        Click Element    ${dict['Tag Selection from drop down list']}
        Sleep    2
        Click Element    ${dict['Tags Apply Button']}    #apply tag button
        Sleep    1
        ${index}=    Evaluate    ${index}+1
    END

Add Condition to Resource
    [Arguments]    ${resource_condition}
    ${xpath worksheet}=    Evaluate    'Resource'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Resource_Components'
    ${attr_name_col}=    Evaluate    10
    ${operator_col}=    Evaluate    11
    ${value_col}=    Evaluate    12
    ${index}=    Evaluate    1
    @{condition_ids}=    Evaluate    [x.strip() for x in "${resource_condition}".split(',')]
    FOR    ${id}    IN    @{condition_ids}
        ${id}=    Convert To Number    ${id}
        Open Excel    ${workbook}
        ${worksheet}=    Evaluate    'Resource_Components'
        ${attr_name}=    Read Cell Data By Coordinates    ${worksheet}    ${attr_name_col}    ${id}
        ${operator}=    Read Cell Data By Coordinates    ${worksheet}    ${operator_col}    ${id}
        ${value}=    Read Cell Data By Coordinates    ${worksheet}    ${value_col}    ${id}
        Wait Until Page Contains Element    ${dict['Add Condition Button']}    #add condition button
        Click Element    ${dict['Add Condition Button']}    #add condition button
        Wait Until Page Contains Element    ${dict['Selecting Atrrribute Name']}/tr[${index}]/td[1]/select    #select attribute name
        Comment    Click Element    //*[@id="componentForm.val"]/div[2]/div[2]/div[6]/div[2]/table/tbody/tr[${index}]/td[1]/select
        Sleep    2
        Select From List By Label    ${dict['Selecting Atrrribute Name']}/tr[${index}]/td[1]/select    ${attr_name}
        Wait Until Page Contains Element    ${dict['Operator Drop Down List']}/tr[${index}]/td[2]/select    #select operator
        Select From List By Label    ${dict['Operator Drop Down List']}/tr[${index}]/td[2]/select    ${operator}
        Wait Until Page Contains Element    ${dict['Value Text Field']}/tr[${index}]/td[3]/div[1]/textarea    #input value
        Input Text    ${dict['Value Text Field']}/tr[${index}]/td[3]/div[1]/textarea    ${value}
        Click Element    ${dict['Condition Tick Button']}/tr[${index}]/td[4]/i[1]    #confirm add condition
        ${index}=    Evaluate    ${index}+1
        Sleep    1
        Comment    Click Element    ${dict['Resource Component SAVE Button']}
    END
