*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           Selenium2Library
Library           Collections

*** Variables ***
${previous button}    //*[@id="myReportsTable_previous"]
${next button}    //*[@id="myReportsTable_next"]
${report element}    //*[@id="myReportsTable"]/tbody/tr    # locator of saved reports in table

*** Test Cases ***
Test The Previous Next Button
    Go To    ${home}/${reporter_reports}
    Wait Until Page Contains    Saved Reports
    ${previous state}    Get Element Attribute    ${previous button}@class
    ${state}    ui state disabled    ${previous state}
    Run Keyword Unless    ${state}    Fail    # If previous button is available then test fail
    # Turn page forward
    : FOR    ${i}    IN RANGE    10
    \    check list size    # Check the record number is 0~25
    \    ${next state}    Get Element Attribute    ${next button}@class
    \    ${no more}    ui state disabled    ${next state}
    \    Exit For Loop If    ${no more}==True    # If next button is disabled it means no more page
    \    Run Keyword Unless    ${no more}    Click Element    ${next button}
    \    ${previous state}    Get Element Attribute    ${previous button}@class
    \    ${state}    ui state disabled    ${previous state}
    \    Run Keyword If    ${state}    Fail    # Turned page, previous button should be avaiable
    # Turn page backward
    : FOR    ${j}    IN RANGE    10
    \    ${previous state}    Get Element Attribute    ${previous button}@class
    \    ${no more}    ui state disabled    ${previous state}
    \    Exit For Loop If    ${no more}==True    # If previous button is disabled it means no more page
    \    Run Keyword Unless    ${no more}    Click Element    ${previous button}
    \    ${next state}    Get Element Attribute    ${next button}@class
    \    ${state}    ui state disabled    ${next state}
    \    Run Keyword If    ${state}    Fail    # Turned page, previous button should be avaiable

*** Keywords ***
ui state disabled
    [Arguments]    ${button class}
    [Documentation]    Check the button state, return TRUE if it is disabled, and FALSE if not.
    @{class value}    Split String    ${button class}
    ${state}    Run Keyword And Return Status    List Should Contain Value    ${class value}    ui-state-disabled
    Return From Keyword    ${state}

check list size
    [Documentation]    The list size of Saved Report panel should be 25. Check if the list size is greater than 25.
    ${report list}    Get Webelements    ${report element}
    ${counts}    Get Length    ${report list}
    ${counts}    Convert To String    ${counts}
    Should Match Regexp    ${counts}    ^([0-9]|1[0-9]|2[0-5])$
