*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Action    Build_Acceptance
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           Collections
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       ${DATA_DIR}\\Console_PM_Components_Policies.xls    # ${DATA_DIR}\\Policy Creation\\Action\\create_action.xls
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center
${xpath worksheet}    Actions
${worksheet}      Action_Components

*** Test Cases ***
Action
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    40 seconds
    FOR    ${row}    IN RANGE    2    5
        Open Excel    ${workbook}
        ${worksheet}=    Evaluate    'Action_Components'
        ${action_id_col}=    Evaluate    0
        ${action_name_col}=    Evaluate    2
        ${action_type_col}=    Evaluate    1
        ${action_description_col}=    Evaluate    3
        ${action_tags_col}=    Evaluate    4
        ${action_condition_col}=    Evaluate    5
        ${action_sub_components_col}=    Evaluate    6
        ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
        ${action_type}=    Read Cell Data By Coordinates    ${worksheet}    ${action_type_col}    ${row}
        ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
        ${action_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${action_tags_col}    ${row}
        ${action_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${action_condition_col}    ${row}
        ${action_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_sub_components_col}    ${row}
        Go To    ${Home}/${Create Action Page}
        Maximize browser window
        Click Element    ${dict['Resource Type Drop Down List']}    #type field
        Click Element    ${dict['Resource Type Drop Down List Selection']}/a[text()="${action_type}"]    #select resource type
        Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
        Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
        Add Tags to Action    ${action_tags}
        sleep    3
        Click Element    ${dict['ACTIONS Drop Down List']}
        Click Element    ${dict['ACTIONS Drop Down List Selection With Name']}/span[2][text()[contains(.,"${action_condition}")]]
        Click Element    ${dict['SAVE Button']}    #save the policy model
        sleep    3
    END

*** Keywords ***
Add Tags To Action
    [Arguments]    ${action_tags}
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    @{tags}=    Evaluate    [x.strip() for x in "${action_tags}".split('//')]
    ${index}=    Evaluate    1
    FOR    ${tag}    IN    @{tags}
        #\    set selenium implicit wait    15 seconds
        Input Text    ${dict['Tags Editable Text Field']}    ${tag}    #tag field
        Click element    ${dict['Tags Editable Text Field']}
        Wait Until Page Contains Element    ${dict['Tags Drop Down List Button']}    timeout=3
        sleep    3
        Click Element    ${dict['Tags Drop Down List Button']}    #tag xpath
        Click Element    ${dict['Tags Apply Button']}
        ${index}=    Evaluate    ${index}+1
    END
