*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter_with_data
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           Collections
Library           String

*** Variables ***
${lookup usr btn}    //*[@id="lookupUsrBtn"]
${lookup usr dialog}    //*[@id='lookup_users-popup']
${lookup usr table length}    //*[@id='lookup_usersTable_length']/label/select
${lookup usr table filter}    //*[@id='lookup_usersTable_filter']/label/input
${lookup usr table row}    //*[@id='lookup_usersTable']/tbody/tr
${lookup usr table paginate}    //*[@id='lookup_usersTable_paginate']/span/a
${lookup usr next btn}    //*[@id='lookup_usersTable_next']
${usr selected count}    //*[@id='user_selected_count']
${search times}    4
${user criteria}    //*[@id="rptDefCntInUsrTxt"]
${lookup usr ok btn}    //*[@id="user_selected-form"]/div[2]/button[1]
${exact user name 1}    john tyler
${data table head}    //*[@id="dataTableReport_wrapper"]/div/div[3]/div[1]/div/table/thead/tr/th    # data table column name
${data table}     //*[@id="dataTableViewer"]
${data table next btn}    //*[@id="pagination"]/li[3]
${column title}    USER_NAME
${run btn}        //*[@id="run_button"]
${exact user name 2}    abraham lincoln
${data table row}    //*[@id="dataTableReport"]/tbody/tr

*** Test Cases ***
User lookup table length
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    Click Button    ${lookup usr btn}
    Wait Until Element Is Visible    ${lookup usr dialog}    error=The lookup button does not work.
    ${default}    Get Selected List Value    ${lookup usr table length}
    Should Be Equal    ${default}    50
    Element Should Be Visible    ${lookup usr table row}[1]    There is no enrolled user.
    @{options}    Get List Items    ${lookup usr table length}
    : FOR    ${length}    IN    @{options}
    \    Select From List By Value    ${lookup usr table length}    ${length}
    \    @{paginates}    Get Webelements    ${lookup usr table paginate}
    \    ${p}    Get Length    ${paginates}
    \    ${pages}    Get Text    ${lookup usr table paginate}[${p}]
    \    ${pages}    Convert To Integer    ${pages}
    \    Check page length    ${pages}    ${length}
    \    Click Element    ${lookup usr table paginate}[1]

User lookup search user
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    Click Button    ${lookup usr btn}
    Wait Until Element Is Visible    ${lookup usr dialog}    error=The lookup button does not work.
    Element Should Be Visible    ${lookup usr table row}[1]    There is no enrolled user.
    @{paginates}    Get Webelements    ${lookup usr table paginate}
    ${p}    Get Length    ${paginates}
    ${pages}    Get Text    ${lookup usr table paginate}[${p}]
    ${pages}    Convert To Integer    ${pages}
    @{user name}    Create List    ${EMPTY}
    : FOR    ${n}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup usr table row}
    \    ${amounts}    Get Length    ${rows}
    \    @{user name}    Collect user full name    ${amounts}    @{user name}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup usr next btn}
    Remove Values From List    ${user name}    ${SPACE}    ${EMPTY}
    Log    ${user name}
    ${population}    Get Length    ${user name}
    @{index}    Generate ${search times} Random Numbers Within 0 And ${population-1}
    : FOR    ${m}    IN    @{index}
    \    ${get name}    Get From List    ${user name}    ${m}
    \    Exact matching    ${get name}
    \    Fuzzy matching    ${get name}

User selection
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    ${selection}    Get Value    ${user criteria}
    Should Be Equal    ${selection}    ${EMPTY}
    Click Button    ${lookup usr btn}
    Wait Until Element Is Visible    ${lookup usr dialog}    error=The lookup button does not work.
    Element Should Be Visible    ${lookup usr table row}[1]    There is no enrolled user.
    @{paginates}    Get Webelements    ${lookup usr table paginate}
    ${p}    Get Length    ${paginates}
    ${pages}    Get Text    ${lookup usr table paginate}[${p}]
    ${pages}    Convert To Integer    ${pages}
    #Select users
    @{selected user}    Create List    ${EMPTY}
    : FOR    ${n}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup usr table row}
    \    ${amounts}    Get Length    ${rows}
    \    ${index}    Evaluate    random.randint(1,${amounts})    random
    \    Checkbox Should Not Be Selected    ${lookup usr table row}[${index}]/td/input
    \    Select Checkbox    ${lookup usr table row}[${index}]/td/input
    \    Element Text Should Be    ${usr selected count}    Total selected users :${n+1}
    \    ${usr principal name}    Get Value    ${lookup usr table row}[${index}]/td/input
    \    Append To List    ${selected user}    ${usr principal name}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup usr next btn}
    Click Button    ${lookup usr ok btn}
    Remove Values From List    ${selected user}    ${EMPTY}
    ${selection}    Get Value    ${user criteria}
    @{name list}    Split String    ${selection}    ,
    Remove Values From List    ${name list}    ${EMPTY}
    Log    ${name list}
    Log    ${selected user}
    Lists Should Be Equal    ${selected user}    ${name list}
    # Unselect users
    Click Button    ${lookup usr btn}
    : FOR    ${m}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup usr table row}
    \    ${amounts}    Get Length    ${rows}
    \    Unselect users    ${amounts}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup usr next btn}
    Click Button    ${lookup usr ok btn}
    ${selection}    Get Value    ${user criteria}
    Should Be Equal    ${selection}    ${EMPTY}

Search with user name
    [Documentation]    Need to generate audit logs for specific users first.
    [Tags]    reporter_with_data
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    ${selection}    Get Value    ${user criteria}
    Should Be Equal    ${selection}    ${EMPTY}
    Comment    Search for one user
    Click Button    ${lookup usr btn}
    Wait Until Element Is Visible    ${lookup usr dialog}    error=The lookup button does not work.
    Element Should Be Visible    ${lookup usr table row}[1]    There is no enrolled user.
    Input Text    ${lookup usr table filter}    ${exact user name 1}
    Checkbox Should Not Be Selected    ${lookup usr table row}[1]/td/input
    Select Checkbox    ${lookup usr table row}[1]/td/input
    Element Text Should Be    ${usr selected count}    Total selected users :1
    ${usr principal name}    Get Value    ${lookup usr table row}[1]/td/input
    Click Button    ${lookup usr ok btn}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    ${index}    Check column name and get index    ${column title}
    : FOR    ${i}    IN RANGE    10
    \    One column value    ${index}    ${usr principal name}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    Comment    Search for users
    Click Button    ${lookup usr btn}
    Input Text    ${lookup usr table filter}    ${exact user name 2}
    Checkbox Should Not Be Selected    ${lookup usr table row}[1]/td/input
    Select Checkbox    ${lookup usr table row}[1]/td/input
    Element Text Should Be    ${usr selected count}    Total selected users :2
    Click Button    ${lookup usr ok btn}
    ${selection}    Get Value    ${user criteria}
    @{name list}    Split String    ${selection}    ,
    Remove Values From List    ${name list}    ${EMPTY}
    Log    ${name list}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    : FOR    ${i}    IN RANGE    10
    \    Multiple column values    ${index}    @{name list}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop

*** Keywords ***
Check page length
    [Arguments]    ${pages}    ${length should be}
    : FOR    ${n}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup usr table row}
    \    ${length actual}    Get Length    ${rows}
    \    ${length actual}    Convert To String    ${length actual}
    \    Run Keyword If    ${length should be}==10    Should Match Regexp    ${length actual}    ^([1-9]|10)$
    \    ...    ELSE IF    ${length should be}==25    Should Match Regexp    ${length actual}    ^([1-9]|1[0-9]|2[0-5])$
    \    ...    ELSE IF    ${length should be}==50    Should Match Regexp    ${length actual}    ^([1-9]|[1-4][0-9]|50)$
    \    ...    ELSE    Should Match Regexp    ${length actual}    ^([1-9]|[1-9][0-9]|100)$
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup usr next btn}

Collect user full name
    [Arguments]    ${count}    @{users}
    : FOR    ${i}    IN RANGE    ${count}
    \    ${name}    Get Text    ${lookup usr table row}[${i+1}]/td
    \    ${name}    Strip String    ${name}    mode=left
    \    Append To List    ${users}    ${name}
    Return From Keyword    @{users}

Exact matching
    [Arguments]    ${get name}
    Input Text    ${lookup usr table filter}    ${get name}
    @{rows}    Get Webelements    ${lookup usr table row}
    ${amounts}    Get Length    ${rows}
    @{result}    Create List    ${EMPTY}
    @{result}    Collect user full name    ${amounts}    @{result}
    List Should Contain Value    ${result}    ${get name}

Fuzzy matching
    [Arguments]    ${get name}
    ${nlength}    Get Length    ${get name}
    #    ${start}    Evaluate    random.randint(1,${nlength-2})    random
    ${end}    Evaluate    random.randint(-${nlength-1},${nlength-1})    random
    ${part name}    Get Substring    ${get name}    \    ${end}
    Input Text    ${lookup usr table filter}    ${part name}
    @{paginates}    Get Webelements    ${lookup usr table paginate}
    ${p}    Get Length    ${paginates}
    ${pages}    Get Text    ${lookup usr table paginate}[${p}]
    ${pages}    Convert To Integer    ${pages}
    @{result}    Create List    ${EMPTY}
    : FOR    ${t}    IN RANGE    ${pages}
    \    @{rows}    Get Webelements    ${lookup usr table row}
    \    ${amounts}    Get Length    ${rows}
    \    @{result}    Collect user full name    ${amounts}    @{result}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${lookup usr next btn}
    Should Contain Match    ${result}    *${part name}*

Unselect users
    [Arguments]    ${count}
    ${total selected}    Get Text    ${usr selected count}
    ${total}    Get Substring    ${total selected}    22
    ${total}    Convert To Integer    ${total}
    : FOR    ${i}    IN RANGE    ${count}
    \    ${status}    Get Element Attribute    ${lookup usr table row}[${i+1}]/td/input@checked
    \    Run Keyword Unless    '${status}'=='true'    Continue For Loop
    \    Unselect Checkbox    ${lookup usr table row}[${i+1}]/td/input
    \    ${total}    Evaluate    ${total}-1
    \    Element Text Should Be    ${usr selected count}    Total selected users :${total}

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

One column value
    [Arguments]    ${index}    ${value}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${get value}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    Run Keyword If    '${get value}'=='${value}'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected value name.

Multiple column values
    [Arguments]    ${index}    @{value list}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${get value}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    ${result}    ${info}    Run Keyword And Ignore Error    List Should Contain Value    ${value list}    ${get value}
    \    Run Keyword If    '${result}'=='PASS'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected value name.
