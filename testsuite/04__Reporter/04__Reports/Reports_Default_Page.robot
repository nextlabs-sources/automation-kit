*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Test Cases ***
Reports Tab Default
    Maximize Browser Window
    Go To    ${home}/${reporter_reports}
    # Check inbuilt saved reports
    Page Should Contain    Allow Enforcement in Last 7 Days (S)
    Page Should Contain    Allow Resource in Last 7 Days (S)
    Page Should Contain    Denied Resource in Last 7 Days (S)
    Page Should Contain    Denied Users in Last 30 Days (S)
    Page Should Contain    Deny Enforcement in Last 7 Days (S)
    Page Should Contain    Deny Policies in Last 30 Days (S)
    # Check New button
    Page Should Contain Element    //*[@id="cntNvLstBtnDv"]/a/input
    # Check default Report Query
    # Check Time Duration
    ${FromDate}=    Get Value    //*[@id="beginDate"]
    ${YYYYMMDD1}=    Get Substring    ${FromDate}    \    10
    ${HHMMSS1}=    Get Substring    ${FromDate}    -8
    ${systemDate}=    Get Time
    ${systemDate}=    Get Substring    ${systemDate}    \    10
    Should be Equal    ${YYYYMMDD1}    ${systemDate}
    Should be Equal    ${HHMMSS1}    00:00:00
    ${FromDate}=    Get Value    //*[@id="endDate"]
    ${YYYYMMDD2}=    Get Substring    ${FromDate}    \    10
    ${HHMMSS2}=    Get Substring    ${FromDate}    -8
    Should Be Equal    ${YYYYMMDD2}    ${systemDate}
    Should Be Equal    ${HHMMSS2}    23:59:59
    # Check Event Level
    ${level}=    Get Selected List Value    //*[@id="eventlevel"]
    Should Be Equal    ${level}    3
    # Check Policy Decision
    ${decision}=    Get Selected List Value    //*[@id="decision"]
    Should Be Equal    ${decision}    B
    # Check Resource Type
    Select From List By Value    //*[@id="resourceTypeTblInPlcySelLstBx"]    Legacy actions
    # Check Action
    Select From List By Value    //*[@id="actTblInPlcySelLstBx"]    Op
    # Check User textfield
    ${readonly}=    Get Element Attribute    //*[@id="rptDefCntInUsrTxt"]@readonly
    Should Be Equal    ${readonly}    true
    # Check Policy Full Name
    ${readonly}=    Get Element Attribute    //*[@id="rptDefCntInPlcTxt"]@readonly
    Should Be Equal    ${readonly}    true
    # Check Report Type
    ${repType}=    Get Selected List Value    //*[@id="reportType"]
    Should Be Equal    ${repType}    TABULAR
    ${groupBy}=    Get Element Attribute    //*[@id="groupingMode"]@disabled
    Should Be Equal    ${groupBy}    true
