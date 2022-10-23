*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Action
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
${name max length}    250
${description max length}    4000
${min tag length}    1
${max tag length}    200
${default timeout}    40

*** Test Cases ***
Create Action Component With All Data
    [Tags]    Build_Acceptance    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    15 seconds
    : FOR    ${row}    IN RANGE    2    10
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_name_col}=    Evaluate    2
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    2
	
Create Action Component With NO-Description
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    11    15
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_type_col}=    Evaluate    1
    \    ${action_tags_col}=    Evaluate    4
    \    ${action_condition_col}=    Evaluate    5
    \    ${action_sub_components_col}=    Evaluate    6
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_type}=    Read Cell Data By Coordinates    ${worksheet}    ${action_type_col}    ${row}
    \    ${action_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${action_tags_col}    ${row}
    \    ${action_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${action_condition_col}    ${row}
    \    ${action_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_sub_components_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Click Element    ${dict['Resource Type Drop Down List']}    #type field
    \    Click Element    ${dict['Resource Type Drop Down List Selection']}/a[text()="${action_type}"]    #select resource type
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Add Tags to Action    ${action_tags}
    \    Click Element    ${dict['ACTIONS Drop Down List']}
    \    Click Element    ${dict['ACTIONS Drop Down List Selection With Name']}/span[2][text()[contains(.,"${action_condition}")]]
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3

Create Action Component With NO-Tag
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    16    19
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_type_col}=    Evaluate    1
    \    ${action_description_col}=    Evaluate    3
    \    ${action_condition_col}=    Evaluate    5
    \    ${action_sub_components_col}=    Evaluate    6
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_type}=    Read Cell Data By Coordinates    ${worksheet}    ${action_type_col}    ${row}
    \    ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
    \    ${action_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${action_condition_col}    ${row}
    \    ${action_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_sub_components_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Click Element    ${dict['Resource Type Drop Down List']}    #type field
    \    Click Element    ${dict['Resource Type Drop Down List Selection']}/a[text()="${action_type}"]    #select resource type
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
    \    Click Element    ${dict['ACTIONS Drop Down List']}
    \    Click Element    ${dict['ACTIONS Drop Down List Selection With Name']}/span[2][text()[contains(.,"${action_condition}")]]
    \    Click Element    ${dict['SAVE Button']}    #save the Action Component
    \    sleep    3

Create Action Component With NO-Action
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    20    22
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_type_col}=    Evaluate    1
    \    ${action_description_col}=    Evaluate    3
    \    ${action_tags_col}=    Evaluate    4
    \    ${action_sub_components_col}=    Evaluate    6
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_type}=    Read Cell Data By Coordinates    ${worksheet}    ${action_type_col}    ${row}
    \    ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
    \    ${action_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${action_tags_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Click Element    ${dict['Resource Type Drop Down List']}    #type field
    \    Click Element    ${dict['Resource Type Drop Down List Selection']}/a[text()="${action_type}"]    #select resource type
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
    \    Add Tags to Action    ${action_tags}
    \    Click Element    ${dict['SAVE Button']}    #save the action component
    \    sleep    4

Create action component with No Resource Type
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    51    52
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_description_col}=    Evaluate    3
    \    ${action_tags_col}=    Evaluate    4
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
    \    ${action_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${action_tags_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
    \    Add Tags to Action    ${action_tags}
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3

Create action component without Resource Type-noTag
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    52    53
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_description_col}=    Evaluate    3
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3

Create action component without Resource Type-noDescription
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    53    54
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_tags_col}=    Evaluate    4
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${action_tags_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Add Tags to Action    ${action_tags}
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3

Create action component without Resource Type-noDescription-noTag
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    54    55
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3

Create action component with NO-Name
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    10 seconds
    Go To    ${Home}/${Create Action Page}
    Maximize browser window
    Click Element    ${dict['SAVE Button']}    #save the policy model
    sleep    3
    Wait Until Page Contains    Add a name for the component

Create Action Component Name With Special characters
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    15 seconds
    : FOR    ${row}    IN RANGE    57    67
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_type_col}=    Evaluate    1
    \    ${action_description_col}=    Evaluate    3
    \    ${action_condition_col}=    Evaluate    5
    \    ${action_sub_components_col}=    Evaluate    6
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_type}=    Read Cell Data By Coordinates    ${worksheet}    ${action_type_col}    ${row}
    \    ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
    \    ${action_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${action_condition_col}    ${row}
    \    ${action_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_sub_components_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Click Element    ${dict['Resource Type Drop Down List']}    #type field
    \    Click Element    ${dict['Resource Type Drop Down List Selection']}/a[text()="${action_type}"]    #select resource type
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
    \    Click Element    ${dict['ACTIONS Drop Down List']}
    \    Click Element    ${dict['ACTIONS Drop Down List Selection With Name']}/span[2][text()[contains(.,"${action_condition}")]]
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3

Create Action Component Name Of Different Length
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    15 seconds
    : FOR    ${row}    IN RANGE    66    69
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_type_col}=    Evaluate    1
    \    ${action_description_col}=    Evaluate    3
    \    ${action_condition_col}=    Evaluate    5
    \    ${action_sub_components_col}=    Evaluate    6
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_type}=    Read Cell Data By Coordinates    ${worksheet}    ${action_type_col}    ${row}
    \    ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
    \    ${action_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${action_condition_col}    ${row}
    \    ${action_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_sub_components_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Click Element    ${dict['Resource Type Drop Down List']}    #type field
    \    Click Element    ${dict['Resource Type Drop Down List Selection']}/a[text()="${action_type}"]    #select resource type
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
    \    Click Element    ${dict['ACTIONS Drop Down List']}
    \    Click Element    ${dict['ACTIONS Drop Down List Selection With Name']}/span[2][text()[contains(.,"${action_condition}")]]
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3

Create Action Component Description Of Different Length
    [Tags]    Regression
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Action_Components'
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    10 seconds
    : FOR    ${row}    IN RANGE    70    74
    \    Open Excel    ${workbook}
    \    ${worksheet}=    Evaluate    'Action_Components'
    \    ${action_id_col}=    Evaluate    0
    \    ${action_name_col}=    Evaluate    2
    \    ${action_type_col}=    Evaluate    1
    \    ${action_description_col}=    Evaluate    3
    \    ${action_condition_col}=    Evaluate    5
    \    ${action_sub_components_col}=    Evaluate    6
    \    ${action_name}=    Read Cell Data By Coordinates    ${worksheet}    ${action_name_col}    ${row}
    \    ${action_type}=    Read Cell Data By Coordinates    ${worksheet}    ${action_type_col}    ${row}
    \    ${action_description}=    Read Cell Data By Coordinates    ${worksheet}    ${action_description_col}    ${row}
    \    ${action_condition}=    Read Cell Data By Coordinates    ${worksheet}    ${action_condition_col}    ${row}
    \    ${action_sub_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_sub_components_col}    ${row}
    \    Go To    ${Home}/${Create Action Page}
    \    Maximize browser window
    \    Click Element    ${dict['Resource Type Drop Down List']}    #type field
    \    Click Element    ${dict['Resource Type Drop Down List Selection']}/a[text()="${action_type}"]    #select resource type
    \    Input Text    ${dict['Display Name Editiable Text Field']}    ${action_name}    #name field
    \    Input Text    ${dict['Desciption Editable Text Field']}    ${action_description}    #description field
    \    Click Element    ${dict['ACTIONS Drop Down List']}
    \    Click Element    ${dict['ACTIONS Drop Down List Selection With Name']}/span[2][text()[contains(.,"${action_condition}")]]
    \    Click Element    ${dict['SAVE Button']}    #save the policy model
    \    sleep    3
    #Create Action Component With Tag Of Different Length
    #Creation Action component with Subcomponent

*** Keywords ***
Add Tags To Action
    [Arguments]    ${action_tags}
    ${xpath worksheet}=    Evaluate    'Actions'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    @{tags}=    Evaluate    [x.strip() for x in "${action_tags}".split('//')]
    ${index}=    Evaluate    1
    : FOR    ${tag}    IN    @{tags}
    \    Input Text    ${dict['Tags Editable Text Field']}    ${tag}    #tag field
    \    Click element    ${dict['Tags Editable Text Field']}
    \    Wait Until Page Contains Element    ${dict['Tags Drop Down List Button']}    timeout=10
    \    Click Element    ${dict['Tags Drop Down List Button']}    #tag xpath
    \    Click Element    ${dict['Tags Apply Button']}
    \    ${index}=    Evaluate    ${index}+1
