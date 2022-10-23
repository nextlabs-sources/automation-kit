*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Default Tags      vincent
Library           Selenium2Library
Library           String
Library           OperatingSystem
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${target 33 table}    //*[@id="table_target_33"]/tbody/tr
${target 32 table}    //*[@id="table_target_32"]/tbody/tr
${error message}    Error Loading content!!
${Top 10 Deny Policies in Last 30 Days}    //*[@id="target_12"]
${Top 10 Denied Users in Last 30 Days}    //*[@id="target_11"]
${Top 5 Denied Resource in Last 7 Days}    //*[@id="target_21"]
${Top 5 Allow Resource in Last 7 Days}    //*[@id="target_22"]
${Trend of Deny Policies in Last 30 Days}    //*[@id="target_31"]
${Last 10 Allow Enforcement in Last 7 Days}    //*[@id="target_32"]
${Last 10 Deny Enforcement in Last 7 Days}    //*[@id="target_33"]
${Today's Alerts: Group by Tags}    //*[@id="target_42"]
${Today's Alerts: Details}    //*[@id="target_43"]

*** Test Cases ***
Check Reporter Dashboard
    [Tags]
    Go To    ${home}/${reporter_dashboard}
    wait until page contains    Logged in as:
    Page Should Contain Element    ${Top 10 Deny Policies in Last 30 Days}
    Element Should Not Contain    ${Top 10 Deny Policies in Last 30 Days}    ${error message}
    Page Should Contain Element    ${Top 10 Denied Users in Last 30 Days}
    Element Should Not Contain    ${Top 10 Denied Users in Last 30 Days}    ${error message}
    Page Should Contain Element    ${Top 5 Denied Resource in Last 7 Days}
    Element Should Not Contain    ${Top 5 Denied Resource in Last 7 Days}    ${error message}
    Page Should Contain Element    ${Top 5 Allow Resource in Last 7 Days}
    Element Should Not Contain    ${Top 5 Allow Resource in Last 7 Days}    ${error message}
    Page Should Contain Element    ${Trend of Deny Policies in Last 30 Days}
    Element Should Not Contain    ${Trend of Deny Policies in Last 30 Days}    ${error message}
    Page Should Contain Element    ${Last 10 Allow Enforcement in Last 7 Days}
    Element Should Not Contain    ${Last 10 Allow Enforcement in Last 7 Days}    ${error message}
    Check table length    ${Last 10 Allow Enforcement in Last 7 Days}    ${target 32 table}
    Page Should Contain Element    ${Last 10 Deny Enforcement in Last 7 Days}
    Element Should Not Contain    ${Last 10 Deny Enforcement in Last 7 Days}    ${error message}
    Check table length    ${Last 10 Deny Enforcement in Last 7 Days}    ${target 33 table}
    Page Should Contain Element    ${Today's Alerts: Group by Tags}
    Element Should Not Contain    ${Today's Alerts: Group by Tags}    ${error message}
    Page Should Contain Element    ${Today's Alerts: Details}
    Element Should Not Contain    ${Today's Alerts: Details}    ${error message}

*** Keywords ***
Check table length
    [Arguments]    ${target}    ${target table}
    ${result}    ${info}    Run Keyword And Ignore Error    Element Should Not Contain    ${target}    No results for the given criteria.
    Run Keyword If    '${result}'=='FAIL'    Log    No results for the given criteria.
    ...    ELSE    Check rows amount    ${target table}

Check rows amount
    [Arguments]    ${element}
    @{rows}    Get Webelements    ${element}
    ${amounts}    Get Length    ${rows}
    ${amounts}    Convert To String    ${amounts}
    Should Match Regexp    ${amounts}    ^([1-9]|10)$
