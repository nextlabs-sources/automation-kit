*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        ComponentType
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
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

Host Subject Type Creation
    [Tags]    ComponentTypeSubject    ComponentTypeHost    Create    Build Acceptance Test
    ${edit_component_type_information_details}=    Set Variable    false    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    3    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    4    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Host Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Application Subject Type Creation
    [Tags]    ComponentTypeSubject    ComponentTypeApplication    Create    Build Acceptance Test
    ${edit_component_type_information_details}=    Set Variable    false    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    3    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    4    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Application Subject Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

Resource Type: Create 'Support Tickets' resource type (row 3)
    [Tags]    ComponentTypeResource    Create    Build Acceptance Test
    ${edit_component_type_information_details}=    Set Variable    true    #Information details section will be updated if 'true', else only attributes/actions/obligations if 'false'
    ${start_range}=    Set Variable    3    #Starting row from Excel worksheet to loop over.
    ${end_range}=    Set Variable    4    #Ending row from Excel worksheet + 1, e.g. end_range=21 refers to Excel row 20
    Resource Type Excel Columns    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    Add Or Edit Component Type

*** Keywords ***
User Subject Excel Columns
    [Arguments]    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    &{vars}=    Create Dictionary    comp_sname=user    #Subject Type shortname is 'user'
    Set To Dictionary    ${vars}    worksheet=PM_SUBJECT
    Set To Dictionary    ${vars}    ct_name_col=A    #User Subject Type 'Name' column
    Set To Dictionary    ${vars}    ct_sname_col=B    #User Subject Type 'Shortname' column
    Set To Dictionary    ${vars}    ct_desc_col=C    #User Subject Type 'Description' column
    Set To Dictionary    ${vars}    ct_tags_col=D    #User Subject Type 'Tags' column
    Set To Dictionary    ${vars}    pm_sub_att_col=E    #User Subject Type 'Subject Attribute S/N' column
    Set To Dictionary    ${vars}    result_col=F    #User Subject Type 'policy_model_result' column
    Set To Dictionary    ${vars}    remarks_col=G    #User Subject Type 'remark' column
    Set To Dictionary    ${vars}    att_name_col=B    #User Subject Type Attribute 'Name' column
    Set To Dictionary    ${vars}    att_sname_col=C    #User Subject Type Attribute 'Shortname' column
    Set To Dictionary    ${vars}    att_datatype_col=D    #User Subject Type Attribute 'Datatype' column
    Set To Dictionary    ${vars}    att_op_col=E    #User Subject Type Attribute 'Operator' column
    Set To Dictionary    ${vars}    edit_component_type_information_details=${edit_component_type_information_details}
    Set To Dictionary    ${vars}    start_range=${start_range}
    Set To Dictionary    ${vars}    end_range=${end_range}
    Set Test Variable    ${vars}
    Read XPaths and navigate to menu

Host Subject Excel Columns
    [Arguments]    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    &{vars}=    Create Dictionary    comp_sname=host    #Subject Type shortname is 'host'
    Set To Dictionary    ${vars}    worksheet=PM_SUBJECT
    Set To Dictionary    ${vars}    ct_name_col=K    #Host Subject Type 'Name' column
    Set To Dictionary    ${vars}    ct_sname_col=L    #Host Subject Type 'Shortname' column
    Set To Dictionary    ${vars}    ct_desc_col=M    #Host Subject Type 'Description' column
    Set To Dictionary    ${vars}    ct_tags_col=N    #Host Subject Type 'Tags' column
    Set To Dictionary    ${vars}    pm_sub_att_col=O    #Host Subject Type 'Subject Attribute S/N' column
    Set To Dictionary    ${vars}    result_col=P    #Host Subject Type 'policy_model_result' column
    Set To Dictionary    ${vars}    remarks_col=Q    #Host Subject Type 'remark' column
    Set To Dictionary    ${vars}    att_name_col=J    #Host Subject Type Attribute 'Name' column
    Set To Dictionary    ${vars}    att_sname_col=K    #Host Subject Type Attribute 'Name' column
    Set To Dictionary    ${vars}    att_datatype_col=L    #Host Subject Type Attribute 'Datatype' column
    Set To Dictionary    ${vars}    att_op_col=M    #Host Subject Type Attribute 'Operator' column
    Set To Dictionary    ${vars}    edit_component_type_information_details=${edit_component_type_information_details}
    Set To Dictionary    ${vars}    start_range=${start_range}
    Set To Dictionary    ${vars}    end_range=${end_range}
    Set Test Variable    ${vars}
    Read XPaths and navigate to menu

Application Subject Excel Columns
    [Arguments]    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    &{vars}=    Create Dictionary    comp_sname=application    #Subject Type shortname is 'application'
    Set To Dictionary    ${vars}    worksheet=PM_SUBJECT
    Set To Dictionary    ${vars}    ct_name_col=U    #Application Subject Type 'Name' column
    Set To Dictionary    ${vars}    ct_sname_col=V    #Application Subject Type 'Shortname' column
    Set To Dictionary    ${vars}    ct_desc_col=W    #Application Subject Type 'Description' column
    Set To Dictionary    ${vars}    ct_tags_col=X    #Application Subject Type 'Tags' column
    Set To Dictionary    ${vars}    pm_sub_att_col=Y    #Application Subject Type 'Subject Attribute S/N' column
    Set To Dictionary    ${vars}    result_col=Z    #Application Subject Type 'policy_model_result' column
    Set To Dictionary    ${vars}    remarks_col=AA    #Application Subject Type 'remark' column
    Set To Dictionary    ${vars}    att_name_col=R    #Application Subject Type Attribute 'Name' column
    Set To Dictionary    ${vars}    att_sname_col=S    #Application Subject Type Attribute 'Shortname' column
    Set To Dictionary    ${vars}    att_datatype_col=T    #Application Subject Type Attribute 'Datatype' column
    Set To Dictionary    ${vars}    att_op_col=U    #Application Subject Type Attribute 'Operator' column
    Set To Dictionary    ${vars}    edit_component_type_information_details=${edit_component_type_information_details}
    Set To Dictionary    ${vars}    start_range=${start_range}
    Set To Dictionary    ${vars}    end_range=${end_range}
    Set Test Variable    ${vars}
    Read XPaths and navigate to menu

Resource Type Excel Columns
    [Arguments]    ${edit_component_type_information_details}    ${start_range}    ${end_range}
    &{vars}=    Create Dictionary
    Set To Dictionary    ${vars}    worksheet=PM_RESOURCE
    Set To Dictionary    ${vars}    ct_name_col=A    #Resource Type 'Name' column
    Set To Dictionary    ${vars}    ct_sname_col=B    #Resource Type 'Shortname' column
    Set To Dictionary    ${vars}    ct_desc_col=C    #Resource Type 'Description' column
    Set To Dictionary    ${vars}    ct_tags_col=D    #Resource Type 'Tags' column
    Set To Dictionary    ${vars}    pm_sub_att_col=E    #Resource Type 'Attributes S/N' column
    Set To Dictionary    ${vars}    pm_act_col=F    #Resource Type 'Actions S/N' column
    Set To Dictionary    ${vars}    pm_obl_col=G    #Resource Type 'Obligations S/N' column
    Set To Dictionary    ${vars}    result_col=H    #Resource Type 'policy_model_result' column
    Set To Dictionary    ${vars}    remarks_col=I    #Resource Type 'remark' column
    Set To Dictionary    ${vars}    att_name_col=B    #Resource Type Attribute 'Name' column
    Set To Dictionary    ${vars}    att_sname_col=C    #Resource Type Attribute 'Shortname' column
    Set To Dictionary    ${vars}    att_datatype_col=D    #Resource Type Attribute 'Datatype' column
    Set To Dictionary    ${vars}    att_op_col=E    #Resource Type Attribute 'Operator' column
    Set To Dictionary    ${vars}    act_name_col=H    #Resource Type Action 'Name' column
    Set To Dictionary    ${vars}    act_sname_col=I    #Resource Type Action 'Shortname' column
    Set To Dictionary    ${vars}    obl_name_col=L    #Resource Type Obligation 'Name' column
    Set To Dictionary    ${vars}    obl_sname_col=M    #Resource Type Obligation 'Shortname' column
    Set To Dictionary    ${vars}    obl_param_col=N    #Resource Type 'Obligation Parameter S/N' column
    Set To Dictionary    ${vars}    para_name_col=R    #Resource Type Obligation Parameter 'Name' column
    Set To Dictionary    ${vars}    para_short_name_col=S    #Resource Type Obligation Parameter 'Shortname' column
    Set To Dictionary    ${vars}    para_type_col=T    #Resource Type Obligation Parameter 'Type' column
    Set To Dictionary    ${vars}    para_list_value_col=U    #Resource Type Obligation Parameter 'List Value' column
    Set To Dictionary    ${vars}    para_default_value_col=V    #Resource Type Obligation Parameter 'Default Value' column
    Set To Dictionary    ${vars}    para_hidden_col=W    #Resource Type Obligation Parameter 'Hidden Checkbox' column
    Set To Dictionary    ${vars}    para_editable_col=X    #Resource Type Obligation Parameter 'Editable Checkbox' column
    Set To Dictionary    ${vars}    para_mandatory_col=Y    #Resource Type Obligation Parameter 'Mandatory Checkbox' column
    Set To Dictionary    ${vars}    edit_component_type_information_details=${edit_component_type_information_details}
    Set To Dictionary    ${vars}    start_range=${start_range}
    Set To Dictionary    ${vars}    end_range=${end_range}
    Set Test Variable    ${vars}
    Read XPaths and navigate to menu

Read XPaths and navigate to menu
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    Open Excel    ${workbook}
    Go To    ${Home}/${List Policy Model Page}
    Wait Until Element Is Visible    ${dict['Component Types Header']}    10
    set selenium implicit wait    40 seconds

Add Or Edit Component Type
    Run Keyword If    '${vars['worksheet']}'=='PM_SUBJECT'    Set To Dictionary    ${vars}    worksheet2=PM_SUB_ATTR
    ...    ELSE    Set To Dictionary    ${vars}    worksheet2=PM_RES_ATTR
    FOR    ${row}    IN RANGE    ${vars['start_range']}    ${vars['end_range']}
        ${worksheet}=    Set Variable    ${vars['worksheet']}
        Wait Until Element Is Visible    ${dict['Component Types Header']}
        Wait Until Element Is Visible    ${dict['SUBJECT Type Check']}
        Run Keyword If    '${vars['edit_component_type_information_details']}' == 'true'    Subject or Resource Type Information Details    ${row}
        ...    ELSE    Check If Shortname Exists    ${vars['comp_sname']}
        ${CT_att}=    Read Cell Data By Name    ${worksheet}    ${vars['pm_sub_att_col']}${row}
        ${result}=    Read Cell Data By Name    ${worksheet}    ${vars['result_col']}${row}
        @{attribute_ids}=    Evaluate    [x.strip() for x in "${CT_att}".split(',') if x != '']
        Attribute Details    ${attribute_ids}
        Run Keyword If    '${worksheet}'=='PM_RESOURCE'    Action and Obligation Details    ${row}
        Click Element    ${dict['SAVE Button']}
        Run Keyword IF    '${result}' == 'pass'    Check For Successful Save
        ...    ELSE IF    '${result}' == 'fail'    Check For Failed Save    ${row}
    END

Reset Component Type After Changes
    [Arguments]    ${element_to_check}
    Set To Dictionary    ${vars}    element_to_check=${element_to_check}
    Run Keyword If    '${vars['worksheet']}'=='PM_SUBJECT'    Set To Dictionary    ${vars}    worksheet2=PM_SUB_ATTR
    ...    ELSE    Set To Dictionary    ${vars}    worksheet2=PM_RES_ATTR
    FOR    ${row}    IN RANGE    ${vars['start_range']}    ${vars['end_range']}
        ${worksheet}=    Set Variable    ${vars['worksheet']}
        Run Keyword If    '${vars['edit_component_type_information_details']}' == 'true'    Subject or Resource Type Information Details    ${row}    reset=true
        ...    ELSE    Check If Shortname Exists    ${vars['comp_sname']}    reset=true
        ${CT_att}=    Read Cell Data By Name    ${worksheet}    ${vars['pm_sub_att_col']}${row}
        ${result}=    Read Cell Data By Name    ${worksheet}    ${vars['result_col']}${row}
        @{attribute_ids}=    Evaluate    [x.strip() for x in "${CT_att}".split(',') if x != '']
        Attribute Details    ${attribute_ids}
        Run Keyword If    '${worksheet}'=='PM_RESOURCE'    Action and Obligation Details    ${row}
        ${reset_value}=    Get Text    ${dict['${element_to_check}']}
        Click Element    ${dict['RESET Button']}
        Click Element    ${dict['RESET Confirm Button']}
        Should Be Equal    ${vars['original_value']}    ${reset_value}
    END

Delete From Component Type
    Run Keyword If    '${vars['worksheet']}'=='PM_SUBJECT'    Set To Dictionary    ${vars}    worksheet2=PM_SUB_ATTR
    ...    ELSE    Set To Dictionary    ${vars}    worksheet2=PM_RES_ATTR
    FOR    ${row}    IN RANGE    ${vars['start_range']}    ${vars['end_range']}
        ${worksheet}=    Set Variable    ${vars['worksheet']}
        ${CT_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['ct_sname_col']}${row}
        Wait Until Element is Visible    ${dict['Component Type Link'].format("${CT_sname}")}
        Click Element    ${dict['Component Type Link'].format("${CT_sname}")}
        ${CT_att}=    Read Cell Data By Name    ${worksheet}    ${vars['pm_sub_att_col']}${row}
        @{attribute_ids}=    Evaluate    [x.strip() for x in "${CT_att}".split(',') if x != '']
        Attribute Delete    ${attribute_ids}
        Run Keyword If    '${worksheet}'=='PM_RESOURCE'    Action and Obligation Delete    ${row}
        Click Element    ${dict['SAVE Button']}
        Wait Until Element is Visible    ${dict['CT Success Back Link']}
        Click Element    ${dict['CT Success Back Link']}
        Sleep    1
    END

Delete Resource Type
    FOR    ${row}    IN RANGE    ${vars['start_range']}    ${vars['end_range']}
        ${worksheet}=    Set Variable    ${vars['worksheet']}
        ${CT_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['ct_sname_col']}${row}
        Wait Until Element is Visible    ${dict['Component Type Link'].format("${CT_sname}")}
        Click Element    ${dict['Ellipse Button'].format("${CT_sname}")}
        Click Element    ${dict['Delete Button'].format("${CT_sname}")}
        Click Element    ${dict['Cancel Button']}
        Page Should Contain    ${dict['Resource Delete Confirmation']}
    END

Subject or Resource Type Information Details
    [Arguments]    ${row}    ${reset}=false
    ${worksheet}=    Set Variable    ${vars['worksheet']}
    ${CT_name}=    Read Cell Data By Name    ${worksheet}    ${vars['ct_name_col']}${row}
    ${CT_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['ct_sname_col']}${row}
    ${CT_desc}=    Read Cell Data By Name    ${worksheet}    ${vars['ct_desc_col']}${row}
    ${CT_tags}=    Read Cell Data By Name    ${worksheet}    ${vars['ct_tags_col']}${row}
    ${exists}=    Check If Shortname Exists    ${CT_sname.lower()}    ${reset}
    Input Text    ${dict['CT Name Editable textbox']}    ${CT_name}
    IF    '${worksheet}'=='PM_RESOURCE' and '${exists}'=='0'
    Input Text    ${dict['CT Short Name Editable textbox']}    ${CT_sname}
    END
    Input Text    ${dict['CT Description Editable textbox']}    ${CT_desc}
    Run Keyword If    '${CT_tags}' != ''    Tag Details    ${CT_tags}

Check If Shortname Exists
    [Arguments]    ${sname}    ${reset}=false
    ${xpath}=    Set Variable    ${dict['Component Type Link'].format("${sname}")}
    ${CT_exist}=    Count Rows    ${xpath}
    IF    "${CT_exist}" == "0"
    Click Element    ${dict['ADD RESOURCE TYPE Button']}
    ELSE IF    "${CT_exist}" == "1"
    IF    '${vars['worksheet']}'=='PM_SUBJECT'
    Element Text Should Be    ${dict['Subject or Resource'].format("${sname}")}    SUBJECT
    ELSE IF    '${vars['worksheet']}'=='PM_RESOURCE'
    Element Text Should Be    ${dict['Subject or Resource'].format("${sname}")}    RESOURCE
    END
    Click Element    ${xpath}
    Wait Until Page Contains Element    ${dict['CT Short Name Editable textbox']}
    Sleep    1
    Element Should Be Disabled    ${dict['CT Short Name Editable textbox']}
    IF    "${reset}"=="true"
    ${original_value}=    Get Text    ${dict['${vars['element_to_check']}']}
    Set To Dictionary    ${vars}    original_value=${original_value}
    END
    END
    Sleep    1
    [Return]    ${CT_exist}

Attribute Details
    [Arguments]    ${attribute_ids}
    ${tab_status}=    Run Keyword And Return Status    Element Should be Enabled    ${dict['CT ATTRIBUTES Tab']}
    Run Keyword If    "${tab_status}"=="True"    Click Element    ${dict['CT ATTRIBUTES Tab']}
    ${row_index}=    Count Rows    ${dict['CT Row Count']}
    ${worksheet}=    Set Variable    ${vars['worksheet2']}
    FOR    ${id}    IN    @{attribute_ids}
    ${id}=    Evaluate    str(int(${id}))
    ${row_count}=    Evaluate    ${row_index}+1
    ${attribute_name}=    Read Cell Data By Name    ${worksheet}    ${vars['att_name_col']}${id}
    ${attribute_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['att_sname_col']}${id}
    ${attribute_data_type}=    Read Cell Data By Name    ${worksheet}    ${vars['att_datatype_col']}${id}
    ${attribute_operators}=    Read Cell Data By Name    ${worksheet}    ${vars['att_op_col']}${id}
    Javascript XPath    ${dict['CT ADD Button']}    scrollIntoView()
    ${sn_exist}=    Count Rows    ${dict['CT att/act/obl by shortname'].format("${attribute_sname.lower()}")}
    IF    "${sn_exist}" == "0"
    Click Element    ${dict['CT ADD Button']}
    Sleep    1
    Javascript XPath    ${dict['CT Attribute Name Editable textbox'].format("${row_index}")}    scrollIntoView()
    Input Text    ${dict['CT Attribute Name Editable textbox'].format("${row_index}")}    ${attribute_name}
    Input Text    ${dict['CT Attribute Short Name Editable textbox'].format("${row_index}")}    ${attribute_sname}
    ${dropdown_xpath}=    Set Variable    ${dict['CT Attribute Data Type Dropdown'].format("${row_index}")}
    Dropdown Select    ${dropdown_xpath}    ${attribute_data_type}
    Attribute Operators    ${attribute_operators}    ${row_count}
    ${row_index}=    Set Variable    ${row_count}
    ELSE IF    "${sn_exist}" == "1"
    Javascript XPath    ${dict['CT att/act/obl by shortname'].format("${attribute_sname.lower()}")}    scrollIntoView()
    Click Element    ${dict['CT att/act/obl by shortname'].format("${attribute_sname.lower()}")}/../..//i[@title="Edit"]
    Input Text    ${dict['CT att/act/obl Name Editable textbox']}    ${attribute_name}
    Element Should Be Disabled    ${dict['CT att/act/obl Short Name Editable textbox']}
    Dropdown Select    ${dict['CT att/act/obl Data Type Dropdown']}    ${attribute_data_type}
    Execute JavaScript    for (operator of document.querySelectorAll('input[data-ng-model*=".$_checked"]'))    {operator.checked=false; operator.dispatchEvent(new Event('change'));}
    @{operators}    Evaluate    [x.strip() for x in "${attribute_operators}".split(',')]
    FOR    ${operator}    IN    @{operators}
        Checkbox Interact    ${dict['CT att/act/obl Operators Checkbox'].format("${operator}")}    true
    END
    END
    Click Element    ${dict['CT Add to table Icon']}
    END

Attribute Delete
    [Arguments]    ${attribute_ids}
    ${worksheet}=    Set Variable    ${vars['worksheet2']}
    FOR    ${id}    IN    @{attribute_ids}
        ${id}=    Evaluate    str(int(${id}))
        ${attribute_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['att_sname_col']}${id}
        Sleep    1
        Javascript XPath    ${dict['CT att/act/obl by shortname'].format("${attribute_sname.lower()}")}    scrollIntoView()
        Click Element    ${dict['CT att/act/obl by shortname'].format("${attribute_sname.lower()}")}/../..//i[@title="Delete"]
    END

Attribute Operators
    [Arguments]    ${attribute_operators}    ${row_count}
    ${firstrow}=    Set Variable    (//tr[@ng-repeat="attr in resource.attributes"][{0}]//label/input)[1]
    ${firstrow_xpath}=    Set Variable    ${firstrow.format("${row_count}")}
    Checkbox Interact    ${firstrow_xpath}    false
    @{operators}    Evaluate    [x.strip() for x in "${attribute_operators}".split(',')]
    FOR    ${operator}    IN    @{operators}
        Checkbox Interact    ${dict['CT Attribute Operators Checkbox'].format("${row_count}","${operator}")}    true
    END

Action and Obligation Details
    [Arguments]    ${row}
    ${worksheet}=    Set Variable    ${vars['worksheet']}
    ${policy_model_action}=    Read Cell Data By Name    ${worksheet}    ${vars['pm_act_col']}${row}
    @{action_ids}=    Evaluate    [x.strip() for x in "${policy_model_action}".split(',') if x != '']
    ${policy_model_obl}=    Read Cell Data By Name    ${worksheet}    ${vars['pm_obl_col']}${row}
    @{obl_ids}=    Evaluate    [x.strip() for x in "${policy_model_obl}".split(',') if x != '']
    Action Details    ${action_ids}
    Obligation Details    ${obl_ids}

Action and Obligation Delete
    ${worksheet}=    Set Variable    ${vars['worksheet']}
    ${policy_model_action}=    Read Cell Data By Name    ${worksheet}    ${vars['pm_act_col']}${row}
    @{action_ids}=    Evaluate    [x.strip() for x in "${policy_model_action}".split(',') if x != '']
    ${policy_model_obl}=    Read Cell Data By Name    ${worksheet}    ${vars['pm_obl_col']}${row}
    @{obl_ids}=    Evaluate    [x.strip() for x in "${policy_model_obl}".split(',') if x != '']
    Javascript XPath    ${dict['Re ACTIONS Tab']}    scrollIntoView()
    Click Element    ${dict['Re ACTIONS Tab']}
    ${worksheet}=    Set Variable    ${vars['worksheet2']}
    FOR    ${id}    IN    @{action_ids}
        ${id}=    Evaluate    str(int(${id}))
        ${action_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['act_sname_col']}${id}
        Sleep    1
        Javascript XPath    ${dict['CT att/act/obl by shortname'].format("${action_sname.upper()}")}    scrollIntoView()
        Click Element    ${dict['CT att/act/obl by shortname'].format("${action_sname.upper()}")}/../..//i[@title="Delete"]
    END
    Javascript XPath    ${dict['Re OBLIGATIONS Tab']}    scrollIntoView()
    Click Element    ${dict['Re OBLIGATIONS Tab']}
    FOR    ${id}    IN    @{obl_ids}
        ${id}=    Evaluate    str(int(${id}))
        ${obl_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['obl_sname_col']}${id}
        Sleep    1
        Javascript XPath    ${dict['CT att/act/obl by shortname'].format("${obl_sname}")}    scrollIntoView()
        Click Element    ${dict['CT att/act/obl by shortname'].format("${obl_sname}")}/../..//i[@title="Delete"]
    END

Action Details
    [Arguments]    ${action_ids}
    Javascript XPath    ${dict['Re ACTIONS Tab']}    scrollIntoView()
    ${tab_status}=    Run Keyword And Return Status    Element Should be Enabled    ${dict['Re ACTIONS Tab']}
    Run Keyword If    "${tab_status}"=="True"    Click Element    ${dict['Re ACTIONS Tab']}
    ${row_index}=    Count Rows    ${dict['CT Row Count']}
    ${worksheet}=    Set Variable    ${vars['worksheet2']}
    FOR    ${id}    IN    @{action_ids}
        ${id}=    Evaluate    str(int(${id}))
        ${row_count}=    Evaluate    ${row_index}+1
        ${action_name}=    Read Cell Data By Name    ${worksheet}    ${vars['act_name_col']}${id}
        ${action_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['act_sname_col']}${id}
        Javascript XPath    ${dict['CT ADD Button']}    scrollIntoView()
        ${sn_exist}=    Count Rows    ${dict['CT att/act/obl by shortname'].format("${action_sname.upper()}")}
        IF    "${sn_exist}" == "0"
        Click Element    ${dict['CT ADD Button']}
        Sleep    1
        Javascript XPath    ${dict['Re Action Name Editable textbox'].format("${row_index}")}    scrollIntoView()
        Input Text    ${dict['Re Action Name Editable textbox'].format("${row_index}")}    ${action_name}
        Input Text    ${dict['Re Action Short Name Editable textbox'].format("${row_index}")}    ${action_sname}
        ${row_index}=    Set Variable    ${row_count}
        ELSE IF    "${sn_exist}" == "1"
        Javascript XPath    ${dict['CT att/act/obl by shortname'].format("${action_sname.upper()}")}    scrollIntoView()
        Click Element    ${dict['CT att/act/obl by shortname'].format("${action_sname.upper()}")}/../..//i[@title="Edit"]
        Input Text    ${dict['CT att/act/obl Name Editable textbox']}    ${action_name}
        Element Should Be Disabled    ${dict['CT att/act/obl Short Name Editable textbox']}
    END
    Click Element    ${dict['CT Add to table Icon']}
    END

Obligation Details
    [Arguments]    ${obl_ids}
    Javascript XPath    ${dict['Re OBLIGATIONS Tab']}    scrollIntoView()
    ${tab_status}=    Run Keyword And Return Status    Element Should be Enabled    ${dict['Re OBLIGATIONS Tab']}
    Run Keyword If    "${tab_status}"=="True"    Click Element    ${dict['Re OBLIGATIONS Tab']}
    ${row_index}=    Count Rows    ${dict['CT Row Count']}
    ${worksheet}=    Set Variable    ${vars['worksheet2']}
    FOR    ${id}    IN    @{obl_ids}
        ${id}=    Evaluate    str(int(${id}))
        ${row_count}=    Evaluate    ${row_index}+1
        ${obl_name}=    Read Cell Data By Name    ${worksheet}    ${vars['obl_name_col']}${id}
        ${obl_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['obl_sname_col']}${id}
        ${obl_sname}=    Set Variable    ${obl_sname.strip()}
        ${obl_params}=    Read Cell Data By Name    ${worksheet}    ${vars['obl_param_col']}${id}
        @{param_ids}=    Evaluate    [x.strip() for x in "${obl_params}".split(',') if x != '']
        Javascript XPath    ${dict['CT ADD Button']}    scrollIntoView()
        ${sn_exist}=    Count Rows    ${dict['CT att/act/obl by shortname'].format("${obl_sname}")}
        IF    "${sn_exist}" == "0"
        Click Element    ${dict['CT ADD Button']}
        Sleep    1
        Javascript XPath    ${dict['Re Obligation Name Editable textbox'].format("${row_index}")}    scrollIntoView()
        Input Text    ${dict['Re Obligation Name Editable textbox'].format("${row_index}")}    ${obl_name}
        Input Text    ${dict['Re Obligation Short Name Editable textbox'].format("${row_index}")}    ${obl_sname}
        Click Element    ${dict['CT Add to table Icon']}
        Run Keyword If    @{param_ids} != @{EMPTY}    Obligation Parameter Details    ${param_ids}    ${obl_sname}
        ${row_index}=    Set Variable    ${row_count}
        ELSE IF    "${sn_exist}" == "1"
        Sleep    1
        Javascript XPath    ${dict['CT att/act/obl by shortname'].format("${obl_sname}")}    scrollIntoView()
        Click Element    ${dict['CT att/act/obl by shortname'].format("${obl_sname}")}/../..//i[@title="Edit"]
        Input Text    ${dict['CT att/act/obl Name Editable textbox']}    ${obl_name}
        Element Should Be Disabled    ${dict['CT att/act/obl Short Name Editable textbox']}
        Click Element    ${dict['CT Add to table Icon']}
        Run Keyword If    @{param_ids} != @{EMPTY}    Obligation Parameter Details    ${param_ids}    ${obl_sname}
    END
    END

Obligation Parameter Details
    [Arguments]    ${param_ids}    ${obl_sname}
    Click Element    ${dict['Re Obligation hide/show parameters Link by shortname'].format("${obl_sname}")}
    ${worksheet}=    Set Variable    ${vars['worksheet2']}
    FOR    ${id}    IN    @{param_ids}
        ${id}=    Evaluate    str(int(${id}))
        ${para_name}=    Read Cell Data By Name    ${worksheet}    ${vars['para_name_col']}${id}
        ${para_sname}=    Read Cell Data By Name    ${worksheet}    ${vars['para_short_name_col']}${id}
        ${para_type}=    Read Cell Data By Name    ${worksheet}    ${vars['para_type_col']}${id}
        ${para_list}=    Read Cell Data By Name    ${worksheet}    ${vars['para_list_value_col']}${id}
        ${para_default}=    Read Cell Data By Name    ${worksheet}    ${vars['para_default_value_col']}${id}
        ${para_hidden}=    Read Cell Data By Name    ${worksheet}    ${vars['para_hidden_col']}${id}
        ${para_editable}=    Read Cell Data By Name    ${worksheet}    ${vars['para_editable_col']}${id}
        ${para_mandatory}=    Read Cell Data By Name    ${worksheet}    ${vars['para_mandatory_col']}${id}
        ${sn_exist}=    Count Rows    ${dict['Re Obligation Parameter by shortname'].format("${obl_sname}","${para_sname}")}
        IF    "${sn_exist}" == "0"
        Click Element    ${dict['Re Obligation Add Parameter Link by shortname'].format("${obl_sname}")}
        Sleep    1
        Javascript XPath    ${dict['Re Obligation Parameter Name Editable textbox']}    scrollIntoView()
        Input Text    ${dict['Re Obligation Parameter Name Editable textbox']}    ${para_name}
        Input Text    ${dict['Re Obligation Parameter Short Name Editable textbox']}    ${para_sname}
        Dropdown Select    ${dict['Re Obligation Parameter Type Dropdown']}    ${para_type}
        Run Keyword If    '${para_list}' != ''    Input Text    ${dict['Re Obligation Parameter List value Editable textbox']}    ${para_list}
        Input Text    ${dict['Re Obligation Parameter Default value Editable textbox']}    ${para_default}
        Checkbox Interact    ${dict['Re Obligation Parameter Hidden Checkbox']}    ${para_hidden}
        Checkbox Interact    ${dict['Re Obligation Parameter Editable Checkbox']}    ${para_editable}
        Checkbox Interact    ${dict['Re Obligation Parameter Mandatory Checkbox']}    ${para_mandatory}
        ELSE IF    "${sn_exist}" == "1"
        Javascript XPath    ${dict['Re Obligation Edit Parameter Icon'].format("${para_sname}")}    scrollIntoView()
        Click Element    ${dict['Re Obligation Edit Parameter Icon'].format("${para_sname}")}
        Sleep    1
        Input Text    ${dict['Re Obligation Parameter Name Editable textbox']}    ${para_name}
        Element Should Be Disabled    ${dict['Re Obligation Parameter Short Name Editable textbox']}
        Dropdown Select    ${dict['Re Obligation Parameter Type Dropdown']}    ${para_type}
        Run Keyword If    '${para_list}' != ''    Input Text    ${dict['Re Obligation Parameter List value Editable textbox']}    ${para_list}
        Input Text    ${dict['Re Obligation Parameter Default value Editable textbox']}    ${para_default}
        Checkbox Interact    ${dict['Re Obligation Parameter Hidden Checkbox']}    ${para_hidden}
        Checkbox Interact    ${dict['Re Obligation Parameter Editable Checkbox']}    ${para_editable}
        Checkbox Interact    ${dict['Re Obligation Parameter Mandatory Checkbox']}    ${para_mandatory}
    END
    Click Element    ${dict['CT Add to table Icon']}
    END

Check For Successful Save
    Wait Until Element is Visible    ${dict['CT Success Back Link']}
    Click Element    ${dict['CT Success Back Link']}
    Wait Until Element Is Visible    ${dict['Component Types Header']}
    Sleep    1

Check For Failed Save
    [Arguments]    ${row}
    ${failure_text}=    Read Cell Data By Name    ${vars['worksheet']}    ${vars['remarks_col']}${row}
    ${popup_check}=    Evaluate    "${failure_text}".split("::")[0]
    IF    "${popup_check}"=="popup"
    ${msg_text}=    Evaluate    "${failure_text}".split("::")[1]
    Wait Until Element Is Visible    ${dict['CT Popup message']}
    Element Should Contain    ${dict['CT Popup message']}    ${msg_text}
    Click Element    ${dict['CT Popup OK Button']}
    ELSE
    Page Should Contain    ${failure_text}
    END
    Click Element    ${dict['Back Arrow Button']}
    Wait Until Element Is Visible    ${dict['BACK TO COMPONENT TYPE LIST Button']}
    Click Element    ${dict['BACK TO COMPONENT TYPE LIST Button']}
    Wait Until Element Is Visible    ${dict['Component Types Header']}
    Sleep    1

Tag Details
    [Arguments]    ${CT_tags}
    @{CT_tag_list}=    Evaluate    [x.strip() for x in "${CT_tags}".split(',')]
    FOR    ${tag}    IN    @{CT_tag_list}
        ${tag_exist}=    Count Rows    //div[@id="resourceTag"]//div[text()="${tag}"]
        IF    "${tag_exist}"=="0"
        Javascript Xpath    ${dict['CT Tags Editable textbox']}    value="${tag}"
        Sleep    1
        Checkbox Interact    ${dict['CT Tags Tag Checkbox'].format("${tag}")}    true
        Click Element    ${dict['CT Tags Apply Button']}
        Sleep    1
        ELSE
        Log    The tag <${tag}> already exists.
    END
    END

Count Rows
    [Arguments]    ${xpath}
    ${row_count}=    Execute Javascript    return document.evaluate('count(${xpath.replace("\'","\\'")})', document, null, XPathResult.NUMBER_TYPE, null).numberValue
    [Return]    ${row_count}
