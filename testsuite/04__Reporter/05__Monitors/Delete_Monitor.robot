*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Library           String
Library           Collections
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${xpath of first monitor}    //*[@id="monitorsList"]/tbody/tr[1]
${first button of monitor}    //*[@id="monitorsList"]/tbody/tr[1]/td[6]/span[1]
${second button of monitor}    //*[@id="monitorsList"]/tbody/tr[1]/td[6]/span[2]
${delete dialog}    //*[@id="appBdy"]/div[5]
${ok delete}      //*[@id='appBdy']/div[5]/div[3]/div/button[1]
${monitors div}    //*[@id="monitors"]
${monitor element}    //*[@id="monitorsList"]/tbody/tr
${search field}    //*[@id="monitorsList_filter"]/label/input
${name field}     //*[@id="name"]
${warning message}    //*[@id='dummy']

*** Test Cases ***
Delete monitor
    Go To    ${home}/${reporter_monitoring_monitors}
    Wait Until Page Contains Element    ${monitors div}
    ${result}    ${message}    Run Keyword and Ignore Error    Page Should Not Contain    No data available in table
    Run Keyword Unless    '${result}'=='PASS'    Fail    No data available in table
    ${action}    Get Text    ${first button of monitor}
    Run Keyword If    '${action}'=='View'    find the first deletable monitor
    ...    ELSE    Click Element    ${second button of monitor}
    Wait Until Element Is Visible    ${delete dialog}
    ${monitor name}    retrieve monitor name
    Click Element    ${ok delete}
    Sleep    2
    Input Text    ${search field}    ${monitor name}
    Page Should Contain    No matching records found

*** Keywords ***
find the first deletable monitor
    ${monitor list}    Get Webelements    ${monitor element}
    ${count}    Get Length    ${monitor list}    # Count monitors in first page
    : FOR    ${i}    IN RANGE    2    ${count+1}
    \    ${j}    Set Variable    ${i-1}
    \    ${i}    Convert To String    ${i}
    \    ${j}    Convert To String    ${j}
    \    ${first button of monitor}    Replace String    ${first button of monitor}    ${j}    ${i}    1
    \    ...    # Locate the next monitor in list
    \    ${second button of monitor}    Replace String    ${second button of monitor}    ${j}    ${i}    1
    \    ${action}    Get Text    ${first button of monitor}
    \    Run Keyword If    '${action}'=='Edit'    Click Element    ${second button of monitor}
    \    Exit For Loop If    '${action}'=='Edit'
    Run Keyword If    '${action}'=='View'    Fail    There is no deletable monitor in first page.

retrieve monitor name
    ${text}    Get Text    ${warning message}
    ${text}    Get Substring    ${text}    33
    ${name}    Get Substring    ${text}    \    -60
    Return From Keyword    ${name}
