*** Settings ***
Documentation     Need to generate activity logs first.
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter_with_data
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           Collections

*** Variables ***
${policy decision}    //*[@id="decision"]
${display column button}    //*[@id="selectDisplay"]
${add column btn}    //*[@id="column-form"]/div[1]/div/div[2]/p[1]
${select column ok btn}    //*[@id="ok"]
${data table row}    //*[@id="dataTableReport"]/tbody/tr
${run btn}        //*[@id="run_button"]
${data table head}    //*[@id="dataTableReport_wrapper"]/div/div[3]/div[1]/div/table/thead/tr/th    # data table column name
${data table next btn}    //*[@id="pagination"]/li[3]
${resource type selector}    //*[@id="resourceTypeTblInPlcySelLstBx"]
${action selector}    //*[@id="actTblInPlcySelLstBx"]
${available column list}    //*[@id="columnDispSelectms2side__sx"]
${selected column list}    //*[@id="columnDispSelectms2side__dx"]
${data table}     //*[@id="dataTableViewer"]
${Column POLICY_DECISION}    POLICY_DECISION
${action1}        Edit
${action2}        View
${resource type}    Support Tickets
${other criteria selector}    //*[@id="oth_criteria"]
${other criteria operator}    //*[@id="oth_criteria_operator"]
${other criteria value}    //*[@id="oth_criteria_value"]
${add oth criteria btn}    //*[@id="addOthCriteria"]
${others_criteria_name}    //*[@id="othersCriteriaTable"]/span/span/span[1]
${others_criteria_operator}    //*[@id="othersCriteriaTable"]/span/span/span[3]
${others_criteria_value}    //*[@id="othersCriteriaTable"]/span/span/span[5]
${application1}    MSExcel
${application2}    ms
${application3}    Postman
${Column ACTION}    ACTION
${Column APPLICATION_NAME}    APPLICATION_NAME

*** Test Cases ***
Policy decision
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    ${decision}    Get Selected List Label    ${policy decision}
    Should Be Equal    ${decision}    Both
    # Decision is Both
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    ${index}    Check column name and get index    ${Column POLICY_DECISION}
    : FOR    ${i}    IN RANGE    10
    \    Decision is Both    ${index}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    # Decision is Allow
    Select From List By Label    ${policy decision}    Allow
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    : FOR    ${i}    IN RANGE    10
    \    Decision is Allow    ${index}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    # Decision is Deny
    Select From List By Label    ${policy decision}    Deny
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    : FOR    ${i}    IN RANGE    10
    \    Decision is Deny    ${index}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop

Action filter
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    Comment    Search for one action
    Select From List By Value    ${resource type selector}    ${resource type}
    Select From List By Label    ${action selector}    ${action1}
    Click Button    ${display column button}
    Select From List By Label    ${available column list}    ${Column ACTION}
    Click Element    ${add column btn}
    Click Button    ${select column ok btn}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    ${index}    Check column name and get index    ${Column ACTION}
    : FOR    ${i}    IN RANGE    10
    \    One column value    ${index}    ${action1}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    Comment    Search for two actions
    Select From List By Label    ${action selector}    ${action2}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    @{action list}    Create List    ${action1}    ${action2}
    : FOR    ${i}    IN RANGE    10
    \    Multiple column values    ${index}    @{action list}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop

Other criteria filter
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    ${name}    Get Selected List Value    ${other criteria selector}
    Should Be Equal    ${name}    ${Column APPLICATION_NAME}
    ${operator}    Get Selected List Label    ${other criteria operator}
    Should Be Equal    ${operator}    Equals
    Element Text Should Be    ${other criteria value}    ${EMPTY}
    Comment    Validate operator Equals
    Input Text    ${other criteria value}    ${application1}
    Click Button    ${add oth criteria btn}
    Element Should Be Visible    ${others_criteria_name}
    Element Text Should Be    ${others_criteria_name}    ${Column APPLICATION_NAME}
    Element Should Be Visible    ${others_criteria_operator}
    Element Text Should Be    ${others_criteria_operator}    ==
    Element Should Be Visible    ${others_criteria_value}
    Element Text Should Be    ${others_criteria_value}    ${application1}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    ${index}    Check column name and get index    ${Column APPLICATION_NAME}
    : FOR    ${i}    IN RANGE    10
    \    One column value    ${index}    ${application1}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    Comment    Validate case insensitive
    ${lowercase name}    Convert To Lowercase    ${application1}
    Input Text    ${other criteria value}    ${lowercase name}
    Click Button    ${add oth criteria btn}
    Element Text Should Be    ${others_criteria_value}    ${lowercase name}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    : FOR    ${i}    IN RANGE    10
    \    One column value    ${index}    ${application1}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    Comment    Validate operator Like
    Select From List By Label    ${other criteria operator}    Like
    Input Text    ${other criteria value}    ${application2}
    Click Button    ${add oth criteria btn}
    Element Text Should Be    ${others_criteria_operator}    like
    Element Text Should Be    ${others_criteria_value}    ${application2}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    : FOR    ${i}    IN RANGE    10
    \    Fuzzy match column value    ${index}    ${application2}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    Comment    Validate operator In
    Select From List By Label    ${other criteria operator}    In
    Input Text    ${other criteria value}    ${application1},${application3}
    Click Button    ${add oth criteria btn}
    Element Text Should Be    ${others_criteria_operator}    in
    Element Text Should Be    ${others_criteria_value}    ${application1},${application3}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    @{application list}    Create List    ${application1}    ${application3}
    : FOR    ${i}    IN RANGE    10
    \    Multiple column values    ${index}    @{application list}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop
    Comment    Validate operator Not Equals
    Select From List By Label    ${other criteria operator}    Not Equals
    Input Text    ${other criteria value}    ${application1}
    Click Button    ${add oth criteria btn}
    Element Text Should Be    ${others_criteria_operator}    !=
    Element Text Should Be    ${others_criteria_value}    ${application1}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    : FOR    ${i}    IN RANGE    10
    \    Column value exclusion    ${index}    ${application1}
    \    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table next btn}/a
    \    Exit For Loop If    '${result}'=='FAIL'
    \    ${btn status}    Get Element Attribute    ${data table next btn}@class
    \    @{status}    Split String    ${btn status}
    \    ${re}    ${in}    Run Keyword And Ignore Error    List Should Contain Value    ${status}    disabled
    \    Run Keyword If    '${re}'=='FAIL'    Click Element    ${data table next btn}/a
    \    ...    ELSE    Exit For Loop

*** Keywords ***
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

Decision is Both
    [Arguments]    ${index}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${pd}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    Run Keyword If    '${pd}'=='Allowed'    Continue For Loop
    \    ...    ELSE IF    '${pd}'=='Denied'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected policy decision.

Decision is Allow
    [Arguments]    ${index}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${pd}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    Run Keyword If    '${pd}'=='Allowed'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected policy decision.

Decision is Deny
    [Arguments]    ${index}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${pd}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    Run Keyword If    '${pd}'=='Denied'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected policy decision.

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

Fuzzy match column value
    [Arguments]    ${index}    ${value}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${get value}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    ${result}    ${info}    Run Keyword And Ignore Error    Should Match Regexp    ${get value}    (?i)${value}
    \    Run Keyword If    '${result}'=='PASS'    Continue For Loop
    \    ...    ELSE    Fail    Unexpected value name.

Column value exclusion
    [Arguments]    ${index}    ${value}
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    : FOR    ${k}    IN RANGE    ${rows}
    \    ${get value}    Get Text    ${data table row}[${k+1}]/td[${index}]
    \    Run Keyword If    '${get value}'=='${value}'    Fail    Unexpected value name.
    \    ...    ELSE    Continue For Loop
