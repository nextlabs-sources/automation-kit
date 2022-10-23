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
${alerts overview div}    //*[@id='tabs-1']
${monitor selector}    //*[@id='monitor_alerts']
${go button}      //*[@id='alerts_details']
${first alter in list}    //*[@id='alertsList']/tbody/tr[1]/td[2]
${no data message}    No data available in table
${monitor list div}    //*[@id='monitorsList_wrapper']
${monitor paginate}    //*[@id='monitorsList_paginate']/span/a
${monitor element}    //*[@id="monitorsList"]/tbody/tr
${next button}    //*[@id='monitorsList_next']

*** Test Cases ***
Monitor selector should contain all
    Go To    ${home}/${reporter_monitoring_alerts}
    Wait Until Page Contains Element    ${alerts overview div}
    @{alert monitor list}    Get List Items    ${monitor selector}
    ${alert monitor list length}    Get Length    ${alert monitor list}
    Go To    ${home}/${reporter_monitoring_monitors}
    Wait Until Page Contains Element    ${monitor list div}
    ${result}    ${message}    Run Keyword And Ignore Error    Page Should Not Contain    ${no data message}
    Run Keyword If    '${result}'=="FAIL"    Should Be Equal    ${alert monitor list length}    1
    ...    ELSE    Compare list values    ${alert monitor list length}    @{alert monitor list}

Filter alert for monitor
    Go To    ${home}/${reporter_monitoring_alerts}
    Wait Until Page Contains Element    ${alerts overview div}
    @{alert monitor list}    Get List Items    ${monitor selector}
    ${alert monitor list length}    Get Length    ${alert monitor list}
    ${loop}    Evaluate    random.randint(1,5)    random
    : FOR    ${n}    IN RANGE    ${loop}
    \    ${index}    Evaluate    random.randint(1, ${alert monitor list length}-1)    random
    \    ${index}    Convert To String    ${index}
    \    Select From List By Index    ${monitor selector}    ${index}    # Select a monitor randomly
    \    ${selected monitor}    Get Selected List Label    ${monitor selector}
    \    Click Element    ${go button}
    \    Sleep    2
    \    ${result}    ${info}    Run Keyword And Ignore Error    Page Should Not Contain    ${no data message}
    \    Run Keyword If    '${result}'=="FAIL"    Log    ${no data message}
    \    ...    ELSE    Validate go result    ${selected monitor}

*** Keywords ***
Compare list values
    [Arguments]    ${monitor selector list length}    @{monitor selector list}
    ${monitor paginations}    Get total paginations
    @{monitor list}    Create List    All
    : FOR    ${i}    IN RANGE    ${monitor paginations}    # Retrieve from every page
    \    ${monitor list}    Get monitor names    @{monitor list}
    \    Exit For Loop If    ${monitor paginations}==1
    \    Click Element    ${next button}
    Log    ${monitor list}
    ${monitor list length}    Get Length    ${monitor list}
    Should Be Equal    ${monitor selector list length}    ${monitor list length}    # Amounts should be the same
    : FOR    ${j}    IN RANGE    1    ${monitor list length}
    \    ${name}    Get From List    ${monitor list}    ${j}
    \    Should Contain Match    ${monitor selector list}    ${name}*    case_insensitive=False    # Monitor name should be in selector list

Get total paginations
    ${list}    Get Webelements    ${monitor paginate}
    ${n}    Get Length    ${list}
    ${last page xpath}    Set Variable    ${monitor paginate}[${n}]
    ${total paginations}    Get Text    ${last page xpath}
    ${total paginations}    Convert To Integer    ${total paginations}
    Return From Keyword    ${total paginations}

Get monitor names
    [Arguments]    @{monitor list}
    @{monitors}    Get Webelements    ${monitor element}
    ${count}    Get Length    ${monitors}
    : FOR    ${n}    IN RANGE    ${count}    # Retrieve all rows in one page
    \    ${name}    Get Text    ${monitor element}[${n+1}]/td[1]
    \    ${name}    Remove String    ${name}    .
    \    Append To List    ${monitor list}    ${name}
    Return From Keyword    ${monitor list}

Validate go result
    [Arguments]    ${selected monitor}
    ${displayed name}    Get Text    ${first alter in list}
    ${displayed name}    Remove String    ${displayed name}    .
    Should Match    ${selected monitor}    ${displayed name}*
