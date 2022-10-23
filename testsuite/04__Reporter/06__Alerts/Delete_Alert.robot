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
${alter name}     //*[@id='alertsList']/tbody/tr[1]/td[2]
${no data message}    No data available in table
${raised at}      //*[@id='alertsList']/tbody/tr[1]/td[4]
${delete action}    //*[@id='alertsList']/tbody/tr[1]/td[5]/span[2]
${search field}    //*[@id='alertsList_filter']/label/input
${delete dialog}    //*[@id='appBdy']/div[7]
${ok button}      //*[@id='appBdy']/div[7]/div[3]/div/button[1]
${alert list paginate}    //*[@id='alertsList_paginate']/span/a
${alert xpath}    //*[@id='alertsList']/tbody/tr
${next button}    //*[@id='alertsList_next']

*** Test Cases ***
Delete alert
    Go To    ${home}/${reporter_monitoring_alerts}
    Wait Until Page Contains Element    ${alerts overview div}
    ${result}    ${info}    Run Keyword And Ignore Error    Page Should Not Contain    ${no data message}
    Run Keyword If    '${result}'=="FAIL"    Fail    ${no data message}
    ${name}    Get Text    ${alter name}
    ${time}    Get Text    ${raised at}
    Click Element    ${delete action}
    Element Should Be Visible    ${delete dialog}
    Click Element    ${ok button}
    Sleep    2
    Input Text    ${search field}    ${name}
    @{alerts}    Create List    ${EMPTY}    # List to store alerts` raise time
    ${list}    Get Webelements    ${alert list paginate}
    ${n}    Get Length    ${list}
    ${last page xpath}    Set Variable    ${alert list paginate}[${n}]
    ${total paginations}    Get Text    ${last page xpath}
    ${total paginations}    Convert To Integer    ${total paginations}
    : FOR    ${i}    IN RANGE    ${total paginations}
    \    ${rows}    Get Webelements    ${alert xpath}
    \    ${amounts}    Get Length    ${rows}
    \    @{alerts}    Get raise time    ${amounts}    @{alerts}
    \    Exit For Loop If    ${total paginations}==1
    \    Click Element    ${next button}
    Log List    ${alerts}
    List Should Not Contain Value    ${alerts}    ${time}

*** Keywords ***
Get raise time
    [Arguments]    ${count}    @{list}
    : FOR    ${n}    IN RANGE    ${count}
    \    ${raised time}    Get Text    ${alert xpath}[${n+1}]/td[4]
    \    Append To List    ${list}    ${raised time}
    Return From Keyword    @{list}
