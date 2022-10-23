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
User Subject Type Creation
    [Tags]    ComponentTypeSubject    ComponentTypeUser    Create    Build Acceptance Test
    ${edit_component_type_information_details}=    Set Variable    false    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    3    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    21    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    User Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type
