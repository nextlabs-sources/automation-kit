*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Library           Collections
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${policy full name field}    //*[@id="rptDefCntInPlcTxt"]
${lookup plc btn}    //*[@id="lookupPlcBtn"]
${lookup plc dialog}    //*[@id="appBdy"]/div[7]
${plc selected count}    //*[@id="policy_selected_count"]
${lookup plc table length}    //*[@id="lookup_policyTable_length"]/label/select
${lookup plc table filter}    //*[@id="lookup_policyTable_filter"]/label/input
${lookup plc table row}    //*[@id="lookup_policyTable"]/tbody/tr
${lookup plc table paginate}    //*[@id="lookup_policyTable_paginate"]/span/a
${lookup plc next btn}    //*[@id="lookup_policyTable_next"]
${lookup plc ok btn}    //*[@id="policy_selected-form"]/div[2]/button[1]
${search times}    2
${no result message}    No Data Available.
${data table row}    //*[@id="dataTableReport"]/tbody/tr
${run btn}        //*[@id="run_button"]
${data table head}    //*[@id="dataTableReport_wrapper"]/div/div[3]/div[1]/div/table/thead/tr/th    # data table column name
${data table}     //*[@id="dataTableViewer"]
${data table next btn}    //*[@id="pagination"]/li[3]
${column title}    POLICY_FULLNAME

*** Test Cases ***
Policy lookup table length
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    Click Button    ${lookup plc btn}
    Wait Until Element Is Visible    ${lookup plc dialog}    error=The lookup button does not work.
    ${default}    Get Selected List Value    ${lookup plc table length}
    Should Be Equal    ${default}    50
    Element Should Be Visible    ${lookup plc table row}[1]    There is no enrolled user.
    @{options}    Get List Items    ${lookup plc table length}
    : FOR    ${length}    IN    @{options}
    \    Select From List By Value    ${lookup plc table length}    ${length}
    \    @{paginates}    Get Webelements    ${lookup plc table paginate}
    \    ${p}    Get Length    ${paginates}
    \    ${pages}    Get Text    ${lookup plc table paginate}[${p}]
    \    ${pages}    Convert To Integer    ${pages}
    \    Check page length    ${pages}    ${length}
    \    Click Element    ${lookup plc table paginate}[1]

Policy selection
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    ${selection}    Get Value    ${policy full name field}
    Should Be Equal    ${selection}    ${EMPTY}
    Click Button    ${lookup plc btn}
    Wait Until Element Is Visible    ${lookup plc dialog}    error=The lookup button does not work.
    Element Should Be Visible    ${lookup plc table row}[1]    There is no deployed policy.
    @{paginates}    Get Webelements    ${lookup plc table paginate}
    ${p}    Get Length    ${paginates}
    ${pages}    Get Text    ${lookup plc table paginate}[${p}]
    ${pages}    Convert To Integer    ${pages}
    # Select policies
    @{selected policy}    Create List    ${EMPTY}
    : FOR    ${n}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup plc table row}
    \    ${amounts}    Get Length    ${rows}
    \    ${index}    Evaluate    random.randint(1,${amounts})    random
    \    Checkbox Should Not Be Selected    ${lookup plc table row}[${index}]/td/input
    \    Select Checkbox    ${lookup plc table row}[${index}]/td/input
    \    Element Text Should Be    ${plc selected count}    Total selected policies :${n+1}
    \    ${policy name}    Get Text    ${lookup plc table row}[${index}]/td
    \    ${policy name}    Strip String    ${policy name}    mode=left
    \    Append To List    ${selected policy}    ${policy name}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup plc next btn}
    Click Button    ${lookup plc ok btn}
    Remove Values From List    ${selected policy}    ${EMPTY}
    ${selection}    Get Value    ${policy full name field}
    @{name list}    Split String    ${selection}    ,
    Remove Values From List    ${name list}    ${EMPTY}
    Log    ${name list}
    Log    ${selected policy}
    Lists Should Be Equal    ${selected policy}    ${name list}
    # Unselect users
    Click Button    ${lookup plc btn}
    : FOR    ${m}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup plc table row}
    \    ${amounts}    Get Length    ${rows}
    \    Unselect policies    ${amounts}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup plc next btn}
    Click Button    ${lookup plc ok btn}
    ${selection}    Get Value    ${policy full name field}
    Should Be Equal    ${selection}    ${EMPTY}

*** Keywords ***
Check page length
    [Arguments]    ${pages}    ${length should be}
    : FOR    ${n}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup plc table row}
    \    ${length actual}    Get Length    ${rows}
    \    ${length actual}    Convert To String    ${length actual}
    \    Run Keyword If    ${length should be}==10    Should Match Regexp    ${length actual}    ^([1-9]|10)$
    \    ...    ELSE IF    ${length should be}==25    Should Match Regexp    ${length actual}    ^([1-9]|1[0-9]|2[0-5])$
    \    ...    ELSE IF    ${length should be}==50    Should Match Regexp    ${length actual}    ^([1-9]|[1-4][0-9]|50)$
    \    ...    ELSE    Should Match Regexp    ${length actual}    ^([1-9]|[1-9][0-9]|100)$
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup plc next btn}

Collect policy name
    [Arguments]    ${count}    @{policies}
    : FOR    ${i}    IN RANGE    ${count}
    \    ${name}    Get Text    ${lookup plc table row}[${i+1}]/td
    \    ${name}    Strip String    ${name}    mode=left
    \    Append To List    ${policies}    ${name}
    Return From Keyword    @{policies}

Exact matching
    [Arguments]    ${get name}
    Input Text    ${lookup plc table filter}    ${get name}
    @{rows}    Get Webelements    ${lookup plc table row}
    ${amounts}    Get Length    ${rows}
    Should Be Equal    ${amounts}    ${1}
    ${result name}    Get Text    ${lookup plc table row}/td
    ${result name}    Strip String    ${result name}    mode=left
    Should Be Equal    ${get name}    ${result name}

Fuzzy matching
    [Arguments]    ${get name}
    ${nlength}    Get Length    ${get name}
    ${end}    Evaluate    random.randint(-${nlength-1},${nlength-1})    random
    ${part name}    Get Substring    ${get name}    \    ${end}
    Input Text    ${lookup plc table filter}    ${part name}
    @{paginates}    Get Webelements    ${lookup plc table paginate}
    ${p}    Get Length    ${paginates}
    ${pages}    Get Text    ${lookup plc table paginate}[${p}]
    ${pages}    Convert To Integer    ${pages}
    @{result}    Create List    ${EMPTY}
    : FOR    ${t}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup plc table row}
    \    ${amounts}    Get Length    ${rows}
    \    @{result}    Collect policy name    ${amounts}    @{result}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup plc next btn}
    Should Contain Match    ${result}    *${part name}*

Unselect policies
    [Arguments]    ${count}
    ${total selected}    Get Text    ${plc selected count}
    ${total}    Get Substring    ${total selected}    25
    ${total}    Convert To Integer    ${total}
    : FOR    ${i}    IN RANGE    ${count}
    \    ${status}    Get Element Attribute    ${lookup plc table row}[${i+1}]/td/input@checked
    \    Run Keyword Unless    '${status}'=='true'    Continue For Loop
    \    Unselect Checkbox    ${lookup plc table row}[${i+1}]/td/input
    \    ${total}    Evaluate    ${total}-1
    \    Element Text Should Be    ${plc selected count}    Total selected policies :${total}

Check column name and get index
    [Arguments]    ${column name}
    @{heads}    Get Webelements    ${data table head}
    ${count}    Get Length    ${heads}
    ${found}    Set Variable    false
    : FOR    ${i}    IN RANGE    ${count}
    \    ${name}    Get Text    ${data table head}[${i+1}]
    \    Run Keyword Unless    '${name}'=='${column name}'    Continue For Loop
    \    ${found}    Set Variable    true
    \    Exit For Loop
    Run Keyword Unless    '${found}'    Fail    The data table does not contain column '${column name}'.
    Return From Keyword    ${i+1}

Match one policy
    [Arguments]    ${index}    ${policy name}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${plc full name}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    Run Keyword If    '${plc full name}'=='${policy name}'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected policy name.

Match policies
    [Arguments]    ${index}    @{selected policies}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${plc full name}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    ${result}    ${info}    Run Keyword And Ignore Error    List Should Contain Value    ${selected policies}    ${plc full name}
    \    Run Keyword If    '${result}'=='PASS'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected policy name.
