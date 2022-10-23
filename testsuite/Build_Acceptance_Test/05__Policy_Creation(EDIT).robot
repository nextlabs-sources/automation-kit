*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Policy    Build_Acceptance
Library           Selenium2Library
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           String
Library           Collections
Library           XML
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${name missing warning}    Name is mandatory.
${workbook}       ${DATA_DIR}\\Console_PM_Components_Policies.xls    # ${DATA_DIR}\\Policy Creation\\Policy\\create_policy.xls
#${xpath workbook}    Xpaths.xls
#${xpath worksheet}    Policies
${xpath workbook}    Xpaths.xls
${xpath worksheet}    Policies
${policy_id_col}    ${0}
${policy_name_col}    ${1}
${policy_folder}    ${2}
${policy_description_col}    ${3}
${policy_tags_col}    ${4}
${policy_effect_col}    ${5}
${subject_components_col}    ${6}
${and_recipient_col}    ${10}
${resource_components_col}    ${14}
${target_location_col}    ${18}
${action_components_col}    ${21}
${expression_col}    ${22}
${connection_type_col}    ${23}
${heartbeat_col}    ${24}
${policy_effective_duration_col}    ${27}
${policy_effective_valid_from_col}    ${28}
${policy_effective_valid_to_col}    ${29}
${policy_effective_recurring_days_col}    ${30}
${policy_effective_starting_from_col}    ${31}
${policy_effective_starting_to_col}    ${32}
${policy_effective_timezone_col}    ${33}
${policy_effective_timezone_choice_col}    ${34}
${allow_obligation_col}    ${35}
${deny_obligation_col}    ${36}
${obligation_name_col}    ${1}
${obligation_policy_model_col}    ${2}
${obligation_attributes_col}    ${3}
${attribute_name_col}    ${9}
${attribute_value_col}    ${10}
${worksheet}      Policies

*** Test cases ***
Policy
    [Tags]    sanity
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    Open Excel    ${workbook}
    ${nrows}=    Get Row Count    ${worksheet}
    set selenium implicit wait    40 seconds
    FOR    ${row}    IN RANGE    3    7
        ${policy_name}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_name_col}    ${row}
        ${policy_description}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_description_col}    ${row}
        ${policy_tags}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_tags_col}    ${row}
        ${policy_effect}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effect_col}    ${row}
        ${subject_components}=    Read Cell Data By Coordinates    ${worksheet}    ${subject_components_col}    ${row}
        ${resource_components}=    Read Cell Data By Coordinates    ${worksheet}    ${resource_components_col}    ${row}
        ${action_components}=    Read Cell Data By Coordinates    ${worksheet}    ${action_components_col}    ${row}
        ${expression}=    Read Cell Data By Coordinates    ${worksheet}    ${expression_col}    ${row}
        ${connection_type}=    Read Cell Data By Coordinates    ${worksheet}    ${connection_type_col}    ${row}
        ${heartbeat}=    Read Cell Data By Coordinates    ${worksheet}    ${heartbeat_col}    ${row}
        ${policy_effective_duration}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_duration_col}    ${row}
        ${allow_obligation}=    Read Cell Data By Coordinates    ${worksheet}    ${allow_obligation_col}    ${row}
        ${deny_obligation}=    Read Cell Data By Coordinates    ${worksheet}    ${deny_obligation_col}    ${row}
        ${and_recipient}=    Read Cell Data By Coordinates    ${worksheet}    ${and_recipient_col}    ${row}
        ${target_location}=    Read Cell Data By Coordinates    ${worksheet}    ${target_location_col}    ${row}
        Go To    ${Home}/${Create Policy Page}
        Maximize Browser Window
        Wait Until Page Contains Element    ${dict['Name Editable Text Field']}
        Input Text    ${dict['Name Editable Text Field']}    ${policy_name}    #name field
        Input Text    ${dict['Description Editabale Text Field']}    ${policy_description}    #description field
        Add Tags to Policy    ${policy_tags}
        Run Keyword if    '${policy_effect}'=='DENY'    Click Element    ${dict['Allow/Deny Toggle button']}
        Javascript Xpath    ${dict['Subject Components (Label)']}    scrollIntoView()
        Add Subjects To Policy    ${subject_components}    ${and_recipient}
        Javascript Xpath    ${dict['Resource Components (Label)']}    scrollIntoView()
        Add Resources To Policy    ${resource_components}    ${target_location}
        Javascript Xpath    ${dict['Action Components (Label)']}    scrollIntoView()
        Add Actions To Policy    ${action_components}
        Javascript Xpath    ${dict['Expression Label']}    scrollIntoView()
        Input Text    ${dict['Exprerssion Editiable text field']}    ${expression}    #expression field
        Sleep    1
        Javascript Xpath    ${dict['Validate (Button)']}    click()
        Select From List By Label    ${dict['Connectiton Drop down']}    ${connection_type}    #connectiontype field
        Input Text    ${dict['Heartbeat Increment box']}    ${heartbeat}    #hearbeat field
        Javascript Xpath    ${dict['Policy Effective duration (Label)']}    scrollIntoView()
        Run Keyword If    "${policy_effective_duration}"!="Always"    Policy Effective Duration    ${row}
        Javascript Xpath    ${dict['Obligation (Label)']}    scrollIntoView()
        Run Keyword If    '${allow_obligation}'!=''    Add Obligations To Policy    ${allow_obligation}    Allow    #add allow obligations
        Run Keyword If    '${deny_obligation}'!=''    Add Obligations To Policy    ${deny_obligation}    Deny    #add deny obligations
        Click Element    ${dict['SAVE Button']}
        Sleep    2
    END

*** Keywords ***
Add Tags To Policy
    [Arguments]    ${policy_tags}
    [Documentation]    Adding tags to policy from excel sheet
    @{tags}=    Evaluate    [x.strip() for x in "${policy_tags}".split('//')]
    Open Excel    ${workbook}
    FOR    ${tag}    IN    @{tags}
        Wait Until Page Contains Element    ${dict['Tags Editable Text Field']}
        Javascript Xpath    ${dict['Tags Editable Text Field']}    scrollIntoView()
        Input Text    ${dict['Tags Editable Text Field']}    ${tag}
        Wait Until Page Contains Element    ${dict['Tags Check Box Drop Down List'].format("${tag}")}
        Sleep    1
        Click Element    ${dict['Tags Check Box Drop Down List'].format("${tag}")}
        Sleep    1
        Click Element    ${dict['Tags Apply Button']}    #apply tag button
        Sleep    1
    END

Add Subjects To Policy
    [Arguments]    ${subject_components}    ${and_recipient}
    Run Keyword If    "${subject_components}"!="none"    AND OR FILL    ${subject_components}    ${dict['Subject Components parent']}
    Run Keyword If    "${and_recipient}"!=""    Click Element    ${dict['And Recipients Enable switch']}
    Run Keyword If    "${and_recipient}"!=""    AND OR FILL    ${and_recipient}    ${dict['And Recipient parent']}

Add Resources To Policy
    [Arguments]    ${resource_components}    ${target_location}
    Run Keyword If    "${resource_components}"!="none"    AND OR FILL    ${resource_components}    ${dict['Resource Components parent']}
    Run Keyword If    "${target_location}"!=""    Click Element    ${dict['Target Location Enable switch']}
    Run Keyword If    "${target_location}"!=""    AND OR FILL    ${target_location}    ${dict['Target Location parent']}

Add Actions To Policy
    [Arguments]    ${action_components}
    @{actions_list}=    Run Keyword If    "${action_components}"!="none"    Evaluate    [x.strip() for x in "${action_components}".split(',')]
    Run Keyword If    "${action_components}"!="none"    Component Row Fill    ${actions_list}    ${dict['Action Components parent']}

AND OR Fill
    [Arguments]    ${cond_string}    ${xpath}
    @{conditions_list}=    Evaluate    [x.strip() for x in "${cond_string}".split('&&')]
    ${num_conditions}=    Get Length    ${conditions_list}
    ${index}=    Evaluate    1
    FOR    ${conditions}    IN    @{conditions_list}
        ${parent_xpath}=    Set Variable    ${xpath.format("${index}")}
        ${dropdown_value}=    Set Variable    ${conditions.split('::')[0]}
        ${conditions_string}=    Set Variable    ${conditions.split('::')[1]}
        Select From List By Label    ${parent_xpath}${dict['child Dropdown']}    ${dropdown_value}
        @{components_string_list}=    Evaluate    [x.strip() for x in "${conditions_string}".split('||')]
        Component Row Fill    ${components_string_list}    ${parent_xpath}
        Run Keyword If    ${index}!=${num_conditions}    Click Element    ${parent_xpath}${dict['child Add Condition']}
        ${index}    Evaluate    ${index} + 1
    END

Component Row Fill
    [Arguments]    ${components_string_list}    ${parent_xpath}
    FOR    ${component_string}    IN    @{components_string_list}
        ${component_type}=    Set Variable    ${component_string.split(':')[0]}
        ${component}=    Set Variable    ${component_string.split(':')[1]}
        Click Element    ${parent_xpath}${dict['child Input Field']}
        Input Text    ${parent_xpath}${dict['child Input Field']}    ${component}
        Wait Until Page Contains Element    ${parent_xpath}${dict['child Input checkbox'].format("${component}","${component_type}")}
        Click Element    ${parent_xpath}${dict['child Input checkbox'].format("${component}","${component_type}")}
        Click Element    ${parent_xpath}${dict['child Apply Button']}
    END

Add Obligations To Policy
    [Arguments]    ${obligations}    ${allow_deny}
    Open Excel    ${workbook}
    ${worksheet}=    Evaluate    'Policy_OBL_Attr'
    @{obligation_ids}=    Evaluate    [x.strip() for x in "${obligations}".split(',')]
    FOR    ${id}    IN    @{obligation_ids}
        ${id}=    Convert To Number    ${id}
        ${obligation_name}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_name_col}    ${id}
        ${obligation_policy_model}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_policy_model_col}    ${id}
        ${obligation_attributes}=    Read Cell Data By Coordinates    ${worksheet}    ${obligation_attributes_col}    ${id}
        ${parent_xpath}=    Run Keyword if    "${obligation_policy_model}" =="none"    Set Variable    ${dict['Obligation No PM parent'].format("${allow_deny}","${obligation_name}")}
        ...    ELSE    Set Variable    ${dict['Obligation with PM parent'].format("${allow_deny}","${obligation_name}","${obligation_policy_model}")}
        Click Element    ${parent_xpath}${dict['child Obligation checkbox']}
        Run Keyword if    "${obligation_attributes}"!="none"    Add Obligation Attribute    ${parent_xpath}    ${obligation_attributes}
    END

Add Obligation Attribute
    [Arguments]    ${parent_xpath}    ${obligation_attributes}
    @{attributes}=    Evaluate    [x.strip() for x in '${obligation_attributes}'.split(',')]
    ${worksheet}=    Evaluate    'Policy_OBL_Attr'
    Click Element    ${parent_xpath}${dict['child Obligation Expand Attributes']}
    FOR    ${id}    IN    @{attributes}
        ${id}=    Convert To Bytes    ${id}
        ${attribute_name}=    Read Cell Data By Coordinates    ${worksheet}    ${attribute_name_col}    ${id}
        ${attribute_value}=    Read Cell Data By Coordinates    ${worksheet}    ${attribute_value_col}    ${id}
        Input Text    ${parent_xpath}${dict['child Obligation Attribute Textarea'].format("${attribute_name}")}    ${attribute_value}    #attribute value field
    END

Policy Effective Duration
    [Arguments]    ${row}
    Open Excel    ${workbook}
    ${policy_effective_valid_from}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_valid_from_col}    ${row}
    ${policy_effective_valid_to}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_valid_to_col}    ${row}
    ${policy_effective_recurring_days}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_recurring_days_col}    ${row}
    ${policy_effective_starting_from}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_starting_from_col}    ${row}
    ${policy_effective_starting_to}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_starting_to_col}    ${row}
    ${policy_effective_timezone}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_timezone_col}    ${row}
    ${policy_effective_timezone_choice}=    Read Cell Data By Coordinates    ${worksheet}    ${policy_effective_timezone_choice_col}    ${row}
    @{starting_from}=    Evaluate    "${policy_effective_starting_from}".replace(':',' ').split()
    @{starting_to}=    Evaluate    "${policy_effective_starting_to}".replace(':',' ').split()
    @{fromto}=    Create List    From    To
    Click Element    ${dict['Specific Days( Radio Button)']}
    Run Keyword If    "${policy_effective_valid_from}"!=""    Javascript Xpath    ${dict['Valid From Editable Textbox']}    value="${policy_effective_valid_from}"
    Run Keyword If    "${policy_effective_valid_to}"!=""    Javascript Xpath    ${dict['Valid To Editable Textbox']}    value="${policy_effective_valid_to}"
    Run Keyword If    "${policy_effective_recurring_days}"!=""    Select Days    ${policy_effective_recurring_days}
    FOR    ${from_to}    IN    @{fromto}
        Run Keyword If    "${starting_${from_to.lower()}}[0]"!=""    Javascript Xpath    ${dict['Starting ${from_to} Hour Editable Textbox']}    value="${starting_${from_to.lower()}}[0]"
        Run Keyword If    "${starting_${from_to.lower()}}[1]"!=""    Javascript Xpath    ${dict['Starting ${from_to} Minute Editable Textbox']}    value="${starting_${from_to.lower()}}[1]"
        ${ampm}=    Execute Javascript    return document.evaluate('${dict['Starting ${from_to} AMPM Button']}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.innerText
        Run Keyword If    "${ampm}"!="${starting_${from_to.lower()}}[2]" and "${starting_${from_to.lower()}}[2]"!=""    Click Element    ${dict['Starting ${from_to} AMPM Button']}
        Run Keyword If    "${policy_effective_timezone}"=="enforcer"    Click Element    ${dict['Policy controller time zone Radio Button']}
        Run Keyword If    "${policy_effective_timezone}"=="manual"    Click Element    ${dict['Choose time zone Radio Button']}
        Run Keyword If    "${policy_effective_timezone}"=="manual"    Select From List By Label    ${dict['Choose time zone Dropdown']}    ${policy_effective_timezone_choice}
    END

Select Days
    [Arguments]    ${policy_effective_recurring_days}
    @{recurring_days}=    Evaluate    [x.strip() for x in "${policy_effective_recurring_days}".split(',')]
    @{all_days}=    Create List    SUN    MON    TUE    WED    THU    FRI    SAT
    FOR    ${day}    IN    @{all_days}
        Continue For Loop If    $day in $recurring_days
        Click Element    ${dict['Recurring Days Button'].format("${day}")}
    END
