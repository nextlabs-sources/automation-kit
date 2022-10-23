*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           Collections
Library           String

*** Variables ***
${run btn}        //*[@id="run_button"]
${data table row}    //*[@id="dataTableReport"]/tbody/tr
${data table}     //*[@id="dataTableViewer"]
${detail content}    //*[@id="report_detail"]
${event detail content}    //*[@id="event_detail_content"]/tbody/tr
${close detail btn}    //*[@id="appBdy"]/div[7]/div[3]/div/button
${data table column head}    //*[@id="dataTableReport_wrapper"]/div/div[3]/div[1]/div/table/thead/tr/th
${display column button}    //*[@id="selectDisplay"]
${add all btn}    //*[@id="column-form"]/div[1]/div/div[2]/p[2]
${select column ok btn}    //*[@id="ok"]
${skip column}    POLICY_FULLNAME
${custom attr content}    //*[@id="cus_attr_section"]/tbody/tr

*** Test Cases ***
Report detail page
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    Click Button    ${display column button}
    Click Element    ${add all btn}
    Click Button    ${select column ok btn}
    Click Button    ${run btn}
    Sleep    2
    ${has data}    ${res}    Run Keyword And Ignore Error    Element Should Be Visible    ${data table}
    Run Keyword If    '${has data}'=='FAIL'    Fail    No Data Available.
    @{column}    Get Webelements    ${data table column head}
    ${heads}    Get Length    ${column}
    : FOR    ${n}    IN RANGE    ${heads}
    \    ${title}    Get Text    ${data table column head}[${n+1}]
    \    Exit For Loop If    '${title}'=='${skip column}'
    @{data}    Get Webelements    ${data table row}
    ${rows}    Get Length    ${data}
    ${index}    Evaluate    random.randint(1,${rows})    random
    @{pick one}    Create List    ${EMPTY}
    : FOR    ${i}    IN RANGE    ${heads}
    \    ${value}    Get Text    ${data table row}[${index}]/td[${i+1}]
    \    Run Keyword If    ${i}==${n}    Continue For Loop
    \    ...    ELSE IF    '${value}'=='Denied'    Append To List    ${pick one}    Deny
    \    ...    ELSE IF    '${value}'=='Allowed'    Append To List    ${pick one}    Allow
    \    ...    ELSE IF    '${value}'=='User Events'    Append To List    ${pick one}    Event Level 3
    \    ...    ELSE    Append To List    ${pick one}    ${value}
    Remove Values From List    ${pick one}    ${EMPTY}
    Log List    ${pick one}
    Click Element    ${data table row}[${index}]/td[1]
    Element Should Be Visible    ${detail content}
    @{details content}    Create List    ${EMPTY}
    @{event detail}    Get Webelements    ${event detail content}
    ${contents}    Get Length    ${event detail}
    : FOR    ${j}    IN RANGE    ${contents}
    \    ${value}    Get Text    ${event detail content}[${j+1}]/td[2]/p
    \    Append To List    ${details content}    ${value}
    @{custom attribute}    Get Webelements    ${custom attr content}
    ${contents}    Get Length    ${custom attribute}
    : FOR    ${k}    IN RANGE    ${contents}
    \    ${value}    Get Text    ${custom attr content}[${k+1}]/td[2]/p
    \    Append To List    ${details content}    ${value}
    Log List    ${details content}
    List Should Contain Sub List    ${details content}    ${pick one}

*** Keywords ***
