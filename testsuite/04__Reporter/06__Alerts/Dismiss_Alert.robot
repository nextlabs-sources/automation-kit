*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter_with_data
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           Collections

*** Variables ***
${alerts overview div}    //*[@id='tabs-1']
${go button}      //*[@id='alerts_details']
${alter name}     //*[@id='alertsList']/tbody/tr[1]/td[2]
${no data message}    No data available in table
${raised at}      //*[@id='alertsList']/tbody/tr[1]/td[4]
${dismiss action}    //*[@id='alertsList']/tbody/tr[1]/td[5]/span[1]
${search field}    //*[@id='alertsList_filter']/label/input
${show dismissed checkbox}    //*[@id='show_auto_dismiss']
${dismiss dialog}    //*[@id='appBdy']/div[7]
${ok button}      //*[@id='appBdy']/div[7]/div[3]/div/button[1]
${alert list paginate}    //*[@id='alertsList_paginate']/span/a
${alert xpath}    //*[@id='alertsList']/tbody/tr
${next button}    //*[@id='alertsList_next']

*** Test Cases ***
Dismiss alert
    Go To    ${home}/${reporter_monitoring_alerts}
    Wait Until Page Contains Element    ${alerts overview div}
    ${result}    ${info}    Run Keyword And Ignore Error    Page Should Not Contain    ${no data message}
    Run Keyword If    '${result}'=="FAIL"    Fail    ${no data message}
    sleep    5
    ${name}    Get Text    ${alter name}
    ${time}    Get Text    ${raised at}
    Click Element    ${dismiss action}
    Element Should Be Visible    ${dismiss dialog}
    Click Element    ${ok button}
    Sleep    2
    Dismissed visibility    ${name}    ${time}
    Select Checkbox    ${show dismissed checkbox}
    Click Element    ${go button}
    Sleep    2
    Dismissed visibility    ${name}    ${time}

*** Keywords ***
Dismissed visibility
    [Arguments]    ${name}    ${time}
    Input Text    ${search field}    ${name}
    ${tick}    ${res}    Run Keyword And Ignore Error    Checkbox Should Not Be Selected    ${show dismissed checkbox}
    Run Keyword If    '${tick}'=='PASS'    Hide dismissed    ${time}
    ...    ELSE    Show dismissed    ${time}

Hide dismissed
    [Arguments]    ${time}
    @{raise time list}    Collect alerts from list
    Log List    ${raise time list}
    List Should Not Contain Value    ${raise time list}    ${time}

Show dismissed
    [Arguments]    ${time}
    @{raise time list}    Collect alerts from list
    Log List    ${raise time list}
    List Should Contain Value    ${raise time list}    ${time}

Get total paginations
    ${list}    Get Webelements    ${alert list paginate}
    ${n}    Get Length    ${list}
    ${last page xpath}    Set Variable    ${alert list paginate}[${n}]
    ${total paginations}    Get Text    ${last page xpath}
    ${total paginations}    Convert To Integer    ${total paginations}
    Return From Keyword    ${total paginations}

Collect alerts from list
    @{alerts}    Create List    ${EMPTY}
    ${pages}    Get total paginations
    : FOR    ${i}    IN RANGE    ${pages}
    \    ${rows}    Get Webelements    ${alert xpath}
    \    ${amounts}    Get Length    ${rows}
    \    @{alerts}    Get raise time    ${amounts}    @{alerts}
    \    Exit For Loop If    ${pages}==1
    \    Click Element    ${next button}
    Return From Keyword    @{alerts}

Get raise time
    [Arguments]    ${count}    @{list}
    : FOR    ${n}    IN RANGE    ${count}
    \    ${raised time}    Get Text    ${alert xpath}[${n+1}]/td[4]
    \    Append To List    ${list}    ${raised time}
    Return From Keyword    @{list}
