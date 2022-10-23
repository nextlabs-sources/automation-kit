*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        ComponentType
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Resource          ../ComponentType_Keywords.robot
Library           String
Library           Collections
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       ${DATA_DIR}\\Console_PM_Components_Policies.xls    # ${DATA_DIR}\\Policy Creation\\Policy Model\\create_policy_model.xls
${xpath workbook}    Xpaths.xls
${xpath worksheet}    Component Type

*** Test Cases ***
Resource Type: Edit support_tickets Resource Type without name
    [Tags]    ComponentTypeResource    Edit    Fail
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    52    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    53    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Edit support_tickets Resource Type name
    [Tags]    ComponentTypeResource    Edit
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    54    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    56    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Reset Name Edit
    [Tags]    ComponentTypeResource    Reset
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    54    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    55    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Reset Component Type After Changes    CT Name Editable textbox
