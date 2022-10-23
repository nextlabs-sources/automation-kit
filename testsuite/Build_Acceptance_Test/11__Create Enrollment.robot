*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Enrollment    CreateEnrollment
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary
Library           Collections
Library           Screenshot
Library           ${LIB_DIR}/ExcelUtil.py
Library           OperatingSystem

*** Variables ***
${workbook}       Configuration_Tools.xls    # \ ..\automation-kit\testdata\Control Center\Configuration_Tools.xls
${worksheet}      Enrollment_Manager v2
${worksheet_details}    Enrollment_Manager_Details
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Enrollment_New_UI

*** Test Cases ***
Enrolment New UI Template
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Maximize Browser Window
    Start Enrollment Fill    3    18

Create LDIF Enrollment
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Maximize Browser Window
    Start Enrollment Fill    3    6

Invalid Enrollment Username Or Password
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Maximize Browser Window
    Start Enrollment Fill    12    18

*** Keywords ***
Start Enrollment Fill
    [Arguments]    ${start}    ${end}
    FOR    ${i}    IN RANGE    ${start}    ${end}
        Open Excel    ${DATA_DIR}/${workbook}
        ${enrollmentname}=    Read Cell Data By Name    ${worksheet}    B${i}
        ${description}=    Read Cell Data By Name    ${worksheet}    C${i}
        ${enrollment_type}=    Read Cell Data By Name    ${worksheet}    D${i}
        ${autosync_id}=    Read Cell Data By Name    ${worksheet}    E${i}
        ${autosync_id}=    Run Keyword If    "${autosync_id}"!=""    Convert To Integer    ${autosync_id}
        ${conn_id}=    Read Cell Data By Name    ${worksheet}    F${i}
        ${conn_id}=    Run Keyword If    "${conn_id}"!=""    Convert To Integer    ${conn_id}
        ${def_id}=    Read Cell Data By Name    ${worksheet}    G${i}
        ${def_id}=    Run Keyword If    "${def_id}"!=""    Convert To Integer    ${def_id}
        ${ldif_loc}=    Read Cell Data By Name    ${worksheet}    H${i}
        ${result}=    Read Cell Data By Name    ${worksheet}    I${i}
        Set Test Variable    ${autosync_id}
        Set Test Variable    ${conn_id}
        Set Test Variable    ${def_id}
        Set Test Variable    ${ldif_loc}
        Go To    ${Home}/${Enrollment Management List}
        Wait until page contains Element    ${dict['Enrollment Menu']}
        Sleep    1
        Click Element    ${dict['Enrollment Menu']}
        Wait until page contains Element    ${dict['EM Create Enrollment Button']}
        Click Element    ${dict['EM Create Enrollment Button']}
        Wait until page contains Element    ${dict['EM Enrollment Name Editable textbox']}
        Input Text    ${dict['EM Enrollment Name Editable textbox']}    ${enrollmentname}
        Run Keyword If    "${description}"!=""    Input Text    ${dict['EM Description Editable textbox']}    ${description}
        Set Enrollment Type    ${enrollment_type}
        Wait until page contains Element    ${dict['EM Sync Success Back Link']}
        Click Element    ${dict['EM Sync Success Back Link']}
        Wait until page contains Element    ${dict['EM Ellipse'].format("${enrollmentname}")}
        Click Element    ${dict['EM Ellipse'].format("${enrollmentname}")}
        Click Element    ${dict['EM Sync Button'].format("${enrollmentname}")}
        Wait until page contains Element    ${dict['EM Confirm Button']}
        Click Element    ${dict['EM Confirm Button']}
        Wait Until Keyword Succeeds    2 min    10 sec    Sync Check    ${enrollmentname}
    END

Set Enrollment Type
    [Arguments]    ${type}
    Click Element    ${dict['EM Source of Information Dropdown']}
    Click element    ${dict['EM Source of Information Dropdown']}/option[@label="${type}"]
    Run Keyword If    "${type}" == "Active Directory"    AD Conn Fill
    Run Keyword If    "${type}" == "Azure"    AAD Conn Fill
    Run Keyword If    "${type}" == "LDIF"    LDIF Def Fill

Sync Check
    [Arguments]    ${enrollmentname}
    Reload Page
    Sleep    2
    ${status}=    Get Element Attribute    ${dict['EM Sync Status'].format("${enrollmentname}")}    innerText
    Should Be Equal    ${status}    SUCCESS

AD Conn Fill
    ${ad_server}=    Read Cell Data By Name    ${worksheet_details}    I${conn_id}
    ${ad_port}=    Read Cell Data By Name    ${worksheet_details}    J${conn_id}
    ${ad_username}=    Read Cell Data By Name    ${worksheet_details}    K${conn_id}
    ${ad_password}=    Read Cell Data By Name    ${worksheet_details}    L${conn_id}
    ${ad_ssl}=    Read Cell Data By Name    ${worksheet_details}    M${conn_id}
    ${ad_root}=    Read Cell Data By Name    ${worksheet_details}    N${conn_id}
    ${ad_filter}=    Read Cell Data By Name    ${worksheet_details}    O${conn_id}
    ${ad_paging}=    Read Cell Data By Name    ${worksheet_details}    P${conn_id}
    ${ad_dirsync}=    Read Cell Data By Name    ${worksheet_details}    Q${conn_id}
    Run Keyword If    "${ad_server}"!=""    Input Text    ${dict['EM AD Server Editable textbox']}    ${ad_server}
    Run Keyword If    "${ad_port}"!=""    Input Text    ${dict['EM AD Port Editable textbox']}    ${ad_port}
    Run Keyword If    "${ad_username}"!=""    Input Text    ${dict['EM AD AD Server Username Editable textbox']}    ${ad_username}
    Run Keyword If    "${ad_password}"!=""    Input Text    ${dict['EM AD AD Server Password Editable textbox']}    ${ad_password}
    Run Keyword If    "${ad_ssl}"!=""    Checkbox Interact    ${dict['EM AD SSL Secure Mode Checkbox']}    ${ad_ssl}
    Run Keyword If    "${ad_root}"!=""    Fill Roots    ${ad_root}
    Run Keyword If    "${ad_filter}"!=""    Input Text    ${dict['EM AD Filter Editable textbox']}    ${ad_filter}
    #    Click Element    ${dict['EM TEST CONNECTION Button']}
    Execute Javascript    document.evaluate('${dict['EM AD Paging Control Support Label']}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.scrollIntoView()
    Run Keyword If    "${ad_paging}"!=""    Checkbox Interact    ${dict['EM AD Paging Control Support Checkbox']}    ${ad_paging}
    Run Keyword If    "${ad_dirsync}"!=""    Checkbox Interact    ${dict['EM AD DirSync Control Support Checkbox']}    ${ad_dirsync}
    Run Keyword If    "${autosync_id}"!=""    Handle Autosync    ${autosync_id}
    Run Keyword If    "${def_id}" != ""    Def Fill    ad
    ...    ELSE    Log    No Definition Details specified
    Click Element    ${dict['EM Enroll Button']}
    Take Screenshot

AAD Conn Fill
    ${aad_oauth}=    Read Cell Data By Name    ${worksheet_details}    U${conn_id}
    ${aad_tenant}=    Read Cell Data By Name    ${worksheet_details}    V${conn_id}
    ${aad_app_id}=    Read Cell Data By Name    ${worksheet_details}    W${conn_id}
    ${aad_app_key}=    Read Cell Data By Name    ${worksheet_details}    X${conn_id}
    Run Keyword If    "${aad_oauth}"!=""    Input Text    ${dict['EM AAD Azure OAuth URL Editable textbox']}    ${aad_oauth}
    Run Keyword If    "${aad_tenant}"!=""    Input Text    ${dict['EM AAD Application ID Editable textbox']}    ${aad_tenant}
    Run Keyword If    "${aad_app_id}"!=""    Input Text    ${dict['EM AAD Tenant Editable textbox']}    ${aad_app_id}
    Run Keyword If    "${aad_app_key}"!=""    Input Text    ${dict['EM AAD Application Key Editable textbox']}    ${aad_app_key}
    #    Click Element    ${dict['EM TEST CONNECTION Button']}
    Run Keyword If    "${autosync_id}"!=""    Handle Autosync    ${autosync_id}
    Run Keyword If    "${def_id}" != ""    Def Fill    azure
    ...    ELSE    Log    No Definition Details specified
    Click Element    ${dict['EM Enroll Button']}
    Take Screenshot

LDIF Def Fill
    ${ldif_file_loc}=    Normalize Path    ${DATA_DIR}/${ldif_loc}
    Choose File    ${dict['EM LDIF File Input']}    ${ldif_file_loc}
    Run Keyword If    "${def_id}" != ""    Def Fill    ldif
    ...    ELSE    Log    No Definition Details specified
    Click Element    ${dict['EM Enroll Button']}
    Take Screenshot

Def Fill
    [Arguments]    ${enrollment}
    ${guid}=    Read Cell Data By Name    ${worksheet_details}    AB${def_id}
    ${delete_inactive}=    Read Cell Data By Name    ${worksheet_details}    AC${def_id}
    ${store_missing}=    Read Cell Data By Name    ${worksheet_details}    AD${def_id}
    ${to_enroll}=    Read Cell Data By Name    ${worksheet_details}    AE${def_id}
    ${Users_filter}=    Read Cell Data By Name    ${worksheet_details}    AF${def_id}
    ${Users_att}=    Read Cell Data By Name    ${worksheet_details}    AG${def_id}
    ${Contacts_filter}=    Read Cell Data By Name    ${worksheet_details}    AH${def_id}
    ${Contacts_att}=    Read Cell Data By Name    ${worksheet_details}    AI${def_id}
    ${Computers_filter}=    Read Cell Data By Name    ${worksheet_details}    AJ${def_id}
    ${Computers_att}=    Read Cell Data By Name    ${worksheet_details}    AK${def_id}
    ${Applications_filter}=    Read Cell Data By Name    ${worksheet_details}    AL${def_id}
    ${Applications_att}=    Read Cell Data By Name    ${worksheet_details}    AM${def_id}
    ${Groups_filter}=    Read Cell Data By Name    ${worksheet_details}    AN${def_id}
    ${Other Entities_filter}=    Read Cell Data By Name    ${worksheet_details}    AQ${def_id}
    Run Keyword If    "${guid}"!=""    Input Text    ${dict['EM GUID Editable textbox']}    ${guid}
    Run Keyword If    "${delete_inactive}"!=""    Checkbox Interact    ${dict['EM Delete inactive group members Checkbox']}    ${delete_inactive}
    Run Keyword If    "${store_missing}"!=""    Checkbox Interact    ${dict['EM Store missing attributes Checkbox']}    ${store_missing}
    @{enroll_list}=    Evaluate    [x.strip() for x in "${to_enroll}".split(',')]
    Checkbox interact    ${dict['EM Entities to enroll Checkbox'].format("${enrollment}","Users")}    false
    FOR    ${entity}    IN    @{enroll_list}
        Checkbox interact    ${dict['EM Entities to enroll Checkbox'].format("${enrollment}","${entity}")}    true
        Click Element    ${dict['EM def Filter tab'].format("${entity}")}
        Run Keyword If    "${${entity}_filter}"!=""    Input Text    ${dict['EM def Filter Editable textbox']}    ${${entity}_filter}
        Run Keyword If    "${entity}"=="Groups"    Group Fill
        ${att_exist}=    Get Variable Value    ${${entity}_att}
        Run Keyword If    "${att_exist}"!="None" or "${att_exist}"!=""    Fill Attributes    ${entity}    ${${entity}_att}    ${enrollment}
    END

Group Fill
    ${Groups_enumeration}=    Read Cell Data By Name    ${worksheet_details}    AO${def_id}
    ${Structural_groups}=    Read Cell Data By Name    ${worksheet_details}    AP${def_id}
    Run Keyword If    "${Groups_enumeration}"!=""    Input Text    ${dict['EM Group attributes Editable textbox']}    ${Groups_enumeration}
    Run Keyword If    "${Structural_groups}"!=""    Checkbox interact    ${dict['EM Structural Group Filter Checkbox']}    true
    Run Keyword If    "${Structural_groups}"!=""    Input Text    ${dict['EM Structural Group Filter Editable textbox']}    ${Structural_groups}

Fill Attributes
    [Arguments]    ${entity}    ${all_att}    ${enrollment}
    ${index}=    Execute Javascript    return document.evaluate('count(${dict['EM def Filter ADD ATTRIBUTE'].format("${enrollment}","${entity}")}/..//tbody/tr)', document, null, XPathResult.NUMBER_TYPE, null).numberValue
    @{att_list}=    Evaluate    [x.strip() for x in "${all_att}".split(';')]
    FOR    ${att}    IN    @{att_list}
        ${cc_att}=    Set Variable    ${att.split(':')[0]}
        ${dir_att}=    Set Variable    ${att.split(':')[1]}
        ${exists}=    Execute Javascript    return document.evaluate('count(${dict['EM def Filter ADD ATTRIBUTE'].format("${enrollment}","${entity}")}/..//tbody//button[contains(.,"${cc_att}")])', document, null, XPathResult.NUMBER_TYPE, null).numberValue
        ${new_index}=    Run Keyword If    ${exists}==0    Fill Attribute Row    ${enrollment}    ${entity}    ${cc_att}    ${dir_att}    ${index}
        ...    ELSE    Set Variable    ${index}
        ${index}=    Set Variable    ${new_index}
    END

Fill Attribute Row
    [Arguments]    ${type}    ${entity}    ${label}    ${value}    ${index}
    Click Element    ${dict['EM def Filter ADD ATTRIBUTE'].format("${type}","${entity}")}
    Javascript Xpath    ${dict['EM def Filter CC Attributes'].format("${index}","${label}")}    scrollIntoView()
    Javascript Xpath    ${dict['EM def Filter CC Attributes'].format("${index}","${label}")}    click()
    Input Text    ${dict['EM def Filter Dir Attributes'].format("${index}")}    ${value}
    ${new_index}=    Evaluate    ${index}+1
    [Return]    ${new_index}

Handle Autosync
    [Arguments]    ${autosync_id}
    ${autosync_check}=    Read Cell Data By Name    ${worksheet_details}    C${autosync_id}
    Checkbox Interact    ${dict['EM Auto Sync Checkbox']}    ${autosync_check}
    Run Keyword If    "${autosync_check}"=="True"    Autosync Fill    ${autosync_id}

Autosync Fill
    [Arguments]    ${autosync_id}
    ${first_sync}=    Read Cell Data By Name    ${worksheet_details}    D${autosync_id}
    ${repeat_every}=    Read Cell Data By Name    ${worksheet_details}    E${autosync_id}
    ${Date}=    Evaluate    ' '.join("${first_sync}".split()[:3])
    ${Hour}=    Evaluate    "${first_sync}".split()[3].split(':')[0]
    ${Minute}=    Evaluate    "${first_sync}".split()[3].split(':')[1]
    ${AMPM}=    Evaluate    "${first_sync}".split()[4]
    ${repeat_value}=    Evaluate    "${repeat_every}".split()[0]
    ${repeat_label}=    Evaluate    "${repeat_every}".split()[1]
    @{varlist}=    Create list    Date    Hour    Minute    AMPM
    FOR    ${var}    IN    @{varlist}
        Javascript Xpath    ${dict['EM First sync on ${var} Editable textbox']}    value='${${var}}'
        Javascript Xpath    ${dict['EM Repeat for every Value Editable textbox']}    value=${repeat_value}
        Select From List By Label    ${dict['EM Repeat for every Period Dropdown']}    ${repeat_label}
    END

Fill Roots
    [Arguments]    ${roots}
    @{root_list}=    Evaluate    [x.strip() for x in "${roots}".split(':')]
    ${num_roots}=    Get length    ${root_list}
    Input Text    ${dict['EM AD Root Editable textbox'].format("0")}    ${root_list[0]}
    Run Keyword If    ${num_roots}>1    Fill Multiroots    ${root_list[1:]}

Fill Multiroots
    [Arguments]    ${multiroots}
    ${index}=    Set Variable    1
    FOR    ${root}    IN    @{multiroots}
        Click Element    ${dict['EM AD ADD ROOT Button']}
        Input Text    ${dict['EM AD Root Editable textbox'].format("${index}")}    ${root}
        ${index}=    Evaluate    ${index}+1
    END
