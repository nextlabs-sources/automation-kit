*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           Collections

*** Variables ***
${monitor element}    //*[@id="monitorsList"]/tbody/tr
${first button}    //*[@id='monitorsList_first']
${previous button}    //*[@id='monitorsList_previous']
${next button}    //*[@id='monitorsList_next']
${last button}    //*[@id='monitorsList_last']
${list length select}    //*[@id='monitorsList_length']/label/select
${monitor list}    //*[@id='monitorsList_wrapper']
${monitor paginate}    //*[@id='monitorsList_paginate']/span/a

*** Test Cases ***
Length and page turning
    Go To    ${home}/${reporter_monitoring_monitors}
    Wait Until Page Contains Element    ${monitor list}
    ${result}    ${message}    Run Keyword and Ignore Error    Page Should Not Contain    No data available in table
    Run Keyword Unless    '${result}'=='PASS'    Fail    No data available in table
    @{list length}    Get List Items    ${list length select}
    : FOR    ${set length}    IN    @{list length}
    \    Reload Page
    \    Select From List By Value    ${list length select}    ${set length}
    \    page turning    ${set length}

Length check
    Go To    ${home}/${reporter_monitoring_monitors}
    Wait Until Page Contains Element    ${monitor list}
    ${result}    ${message}    Run Keyword and Ignore Error    Page Should Not Contain    No data available in table
    Run Keyword Unless    '${result}'=='PASS'    Fail    No data available in table
    @{list length}    Get List Items    ${list length select}
    : FOR    ${set length}    IN    @{list length}
    \    Reload Page
    \    Select From List By Value    ${list length select}    ${set length}
    \    check list length    ${set length}
    \    ${next btn state}    get button state    ${next button}
    \    Run Keyword If    '${next btn state}'=='available'    Click Element    ${next button}
    \    Run Keyword If    '${next btn state}'=='available'    check list length    ${set length}    # Check the first two page

Page turning
    Go To    ${home}/${reporter_monitoring_monitors}
    Wait Until Page Contains Element    ${monitor list}
    ${result}    ${message}    Run Keyword and Ignore Error    Page Should Not Contain    No data available in table
    Run Keyword Unless    '${result}'=='PASS'    Fail    No data available in table
    ${paginations}    get total paginations
    # Turn page forward
    : FOR    ${i}    IN RANGE    ${paginations}
    \    ${first btn state}    get button state    ${first button}
    \    ${previous btn state}    get button state    ${previous button}
    \    ${next btn state}    get button state    ${next button}
    \    ${last btn state}    get button state    ${last button}
    \    Run Keyword If    ${i}==0    in first page    ${first btn state}    ${previous btn state}
    \    ...    ELSE IF    ${i}==${paginations-1}    in last page    ${next btn state}    ${last btn state}
    \    ...    ELSE    in medium page    ${previous btn state}    ${next btn state}
    \    Exit For Loop If    ${paginations}==1
    \    Click Element    ${next button}
    # Turn page backward
    : FOR    ${i}    IN RANGE    ${paginations}
    \    ${first btn state}    get button state    ${first button}
    \    ${previous btn state}    get button state    ${previous button}
    \    ${next btn state}    get button state    ${next button}
    \    ${last btn state}    get button state    ${last button}
    \    Run Keyword If    ${i}==0    in last page    ${next btn state}    ${last btn state}
    \    ...    ELSE IF    ${i}==${paginations-1}    in first page    ${first btn state}    ${previous btn state}
    \    ...    ELSE    in medium page    ${previous btn state}    ${next btn state}
    \    Exit For Loop If    ${paginations}==1
    \    Click Element    ${previous button}
    Run Keyword Unless    ${paginations}==1    go to last page
    Run Keyword Unless    ${paginations}==1    go to first page

*** Keywords ***
page turning
    [Arguments]    ${list length}    # For length check
    ${paginations}    get total paginations
    # Turn page forward
    : FOR    ${i}    IN RANGE    ${paginations}
    \    check list length    ${list length}
    \    ${first btn state}    get button state    ${first button}
    \    ${previous btn state}    get button state    ${previous button}
    \    ${next btn state}    get button state    ${next button}
    \    ${last btn state}    get button state    ${last button}
    \    Run Keyword If    ${i}==0    in first page    ${first btn state}    ${previous btn state}
    \    ...    ELSE IF    ${i}==${paginations-1}    in last page    ${next btn state}    ${last btn state}
    \    ...    ELSE    in medium page    ${previous btn state}    ${next btn state}
    \    Exit For Loop If    ${paginations}==1
    \    Click Element    ${next button}
    # Turn page backward
    : FOR    ${i}    IN RANGE    ${paginations}
    \    check list length    ${list length}
    \    ${first btn state}    get button state    ${first button}
    \    ${previous btn state}    get button state    ${previous button}
    \    ${next btn state}    get button state    ${next button}
    \    ${last btn state}    get button state    ${last button}
    \    Run Keyword If    ${i}==0    in last page    ${next btn state}    ${last btn state}
    \    ...    ELSE IF    ${i}==${paginations-1}    in first page    ${first btn state}    ${previous btn state}
    \    ...    ELSE    in medium page    ${previous btn state}    ${next btn state}
    \    Exit For Loop If    ${paginations}==1
    \    Click Element    ${previous button}
    Run Keyword Unless    ${paginations}==1    go to last page
    Run Keyword Unless    ${paginations}==1    go to first page

get total paginations
    ${list}    Get Webelements    ${monitor paginate}
    ${n}    Get Length    ${list}
    ${last page xpath}    Set Variable    ${monitor paginate}[${n}]
    ${total paginations}    Get Text    ${last page xpath}
    ${total paginations}    Convert To Integer    ${total paginations}
    Return From Keyword    ${total paginations}

get button state
    [Arguments]    ${button}
    [Documentation]    Check button state, return TRUE if it is disabled, and FALSE if not.
    ${btn class}    Get Element Attribute    ${button}@class
    @{class value}    Split String    ${btn class}
    ${state}    Run Keyword And Return Status    List Should Contain Value    ${class value}    ui-state-disabled
    Run Keyword If    ${state}    Return From Keyword    disabled
    ...    ELSE    Return From Keyword    available

in first page
    [Arguments]    ${first}    ${previous}
    Should Be Equal    ${first}    disabled
    Should Be Equal    ${previous}    disabled

in last page
    [Arguments]    ${next}    ${last}
    Should Be Equal    ${next}    disabled
    Should Be Equal    ${last}    disabled

in medium page
    [Arguments]    ${previous}    ${next}
    Should Be Equal    ${previous}    available
    Should Be Equal    ${next}    available

check list length
    [Arguments]    ${list length}
    ${monitors}    Get Webelements    ${monitor element}
    ${rows}    Get Length    ${monitors}
    ${rows}    Convert To String    ${rows}
    Run Keyword If    ${list length}==10    Should Match Regexp    ${rows}    ^([1-9]|10)$
    ...    ELSE IF    ${list length}==25    Should Match Regexp    ${rows}    ^([1-9]|1[0-9]|2[0-5])$
    ...    ELSE IF    ${list length}==50    Should Match Regexp    ${rows}    ^([1-9]|[1-4][0-9]|50)$
    ...    ELSE    Should Match Regexp    ${rows}    ^([1-9]|[1-9][0-9]|100)$    # length is equal to 100

go to last page
    Click Element    ${last button}
    ${next btn state}    get button state    ${next button}
    ${last btn state}    get button state    ${last button}
    in last page    ${next btn state}    ${last btn state}

go to first page
    Click Element    ${first button}
    ${first btn state}    get button state    ${first button}
    ${previous btn state}    get button state    ${previous button}
    in first page    ${first btn state}    ${previous btn state}
