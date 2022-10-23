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
${name field}     //*[@id="name"]
${save button}    //*[@id="save"]
${edit view dialog}    //*[@id="appBdy"]/div[5]
${monitors div}    //*[@id="monitors"]
${monitor element}    //*[@id="monitorsList"]/tbody/tr
${search field}    //*[@id="monitorsList_filter"]/label/input

*** Test Cases ***
Edit monitor
    Go To    ${home}/${reporter_monitoring_monitors}
    Wait Until Page Contains Element    ${monitors div}
    ${result}    ${message}    Run Keyword and Ignore Error    Page Should Not Contain    No data available in table
    Run Keyword Unless    '${result}'=='PASS'    Fail    No data available in table
    ${action}    Get Text    ${first button of monitor}
    Run Keyword If    '${action}'=='View'    find the first editable monitor
    ...    ELSE    Click Element    ${first button of monitor}
    Wait Until Element Is Visible    ${edit view dialog}
    ${old name}    Get Value    ${name field}
    ${new name}    Generate Random String    10
    Input Text    ${name field}    ${new name}
    Click Element    ${save button}
    Sleep    2
    Input Text    ${search field}    ${old name}
    Page Should Contain    No matching records found
    Input Text    ${search field}    ${new name}
    ${search result}    Get Webelements    ${monitor element}
    ${count}    Get Length    ${search result}
    Should Be Equal    ${count}    ${1}    # Only one matching result

*** Keywords ***
find the first editable monitor
    ${monitor list}    Get Webelements    ${monitor element}
    ${count}    Get Length    ${monitor list}    # Count monitors in first page
    : FOR    ${i}    IN RANGE    2    ${count+1}
    \    ${j}    Set Variable    ${i-1}
    \    ${i}    Convert To String    ${i}
    \    ${j}    Convert To String    ${j}
    \    ${first button of monitor}    Replace String    ${first button of monitor}    ${j}    ${i}    1
    \    ...    # Locate the next monitor in list
    \    ${action}    Get Text    ${first button of monitor}
    \    Run Keyword If    '${action}'=='Edit'    Click Element    ${first button of monitor}
    \    Exit For Loop If    '${action}'=='Edit'
    Run Keyword If    '${action}'=='View'    Fail    There is no editable monitor in first page.
