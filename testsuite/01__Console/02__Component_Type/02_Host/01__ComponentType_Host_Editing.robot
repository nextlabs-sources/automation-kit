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
Host Subject Type: Edit Name With Invalid Special Characters
    [Tags]    ComponentTypeSubject    ComponentTypeHost    Edit    Fail
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    9    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    20    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Host Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Host Subject Type: Edit Name With Long Length
    [Tags]    ComponentTypeSubject    ComponentTypeHost    Edit
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    21    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    24    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Host Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Host Subject Type: Edit Description
    [Tags]    ComponentTypeSubject    ComponentTypeHost    Edit
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    25    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    31    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Host Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Host Subject Type: Edit Name
    [Tags]    ComponentTypeSubject    ComponentTypeHost    Edit
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    32    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    37    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Host Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Host Subject Type: Invalid Attribute Name
    [Tags]    ComponentTypeSubject    ComponentTypeHost    Edit
    ${edit_component_type_information_details}=    Set Variable    false    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    38    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    40    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Host Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Host Subject Type: Edit Attribute
    [Tags]    ComponentTypeSubject    ComponentTypeHost    Edit
    ${edit_component_type_information_details}=    Set Variable    false    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    41    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    42    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Host Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type
