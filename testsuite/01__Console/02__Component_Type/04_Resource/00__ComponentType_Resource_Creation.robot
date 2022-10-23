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
Resource Type: Create Resource Type with all data (Support Tickets, Sap, sharepoint_enforcer)
    [Tags]    ComponentTypeResource    Create    Build Acceptance Test
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    3    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    6    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type no name
    [Tags]    ComponentTypeResource    Create    Fail
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    46    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    47    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type no shortname
    [Tags]    ComponentTypeResource    Create    Fail
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    48    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    49    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with invalid special characters in name
    [Tags]    ComponentTypeResource    Create    Fail
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    25    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    36    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with invalid special characters in shortname
    [Tags]    ComponentTypeResource    Create    Fail
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    50    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    51    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with description
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    6    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    7    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type without description
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    7    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    8    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with tags
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    8    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    9    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type without tags
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    9    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    10    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with attributes
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    10    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    11    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type without attributes
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    11    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    12    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with action
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    12    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    13    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with obligation
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    14    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    15    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type without action
    [Tags]    ComponentTypeResource    Create
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    13    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    14    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create Resource Type with existing name
    [Tags]    ComponentTypeResource    Edit
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    57    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    58    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type
