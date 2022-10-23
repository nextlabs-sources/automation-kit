*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Default Tags      vincent
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${title_link_12}    //*[@id="target_12"]/div/div/span/a
${title_link_11}    //*[@id="target_11"]/div/div/span/a
${title_link_21}    //*[@id="target_21"]/div/div/span/a
${title_link_22}    //*[@id="target_22"]/div/div/span/a
${title_link_31}    //*[@id="target_31"]/div/div/span/a
${title_link_32}    //*[@id="target_32"]/div/div/span/a
${title_link_33}    //*[@id="target_33"]/div/div/span/a
${title_link_42}    //*[@id="target_42"]/div/div/span/a
${title_link_43}    //*[@id="target_43"]/div/div/span/a

*** Test Cases ***
Fetch Reporter Details For Dashboard
    Maximize Browser Window
    # fetch Top 10 Deny Policies in Last 30 Days
    Click Element    ${title_link_12}
    Location Should Be    ${home}/${reporter_reports}
    ${decision}    Get Value    //select[@id="decision"]
    Should Be Equal    D    ${decision}
    ${reportType}    Get Value    //select[@id="reportType"]
    Should Be Equal    PIE_CHART    ${reportType}
    ${groupingMode}    Get Value    //select[@id="groupingMode"]
    Should Be Equal    GROUP_BY_POLICY    ${groupingMode}
    ${maxResults}    Get Value    //input[@id="maxRowsFetchId"]
    Should Be Equal    10    ${maxResults}
    # fetch Top 10 Denied Users in Last 30 Days
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_11}
    Click Element    ${title_link_11}
    Location Should Be    ${home}/${reporter_reports}
    ${decision}    Get Value    //select[@id="decision"]
    Should Be Equal    D    ${decision}
    ${reportType}    Get Value    //select[@id="reportType"]
    Should Be Equal    BAR_CHART    ${reportType}
    ${groupingMode}    Get Value    //select[@id="groupingMode"]
    Should Be Equal    GROUP_BY_USER    ${groupingMode}
    ${maxResults}    Get Value    //input[@id="maxRowsFetchId"]
    Should Be Equal    10    ${maxResults}
    # fetch Top 5 Denied Resource in Last 7 Days
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_21}
    Click Element    ${title_link_21}
    Location Should Be    ${home}/${reporter_reports}
    ${decision}    Get Value    //select[@id="decision"]
    Should Be Equal    D    ${decision}
    ${reportType}    Get Value    //select[@id="reportType"]
    Should Be Equal    HORZ_BAR_CHART    ${reportType}
    ${groupingMode}    Get Value    //select[@id="groupingMode"]
    Should Be Equal    GROUP_BY_RESOURCE    ${groupingMode}
    ${maxResults}    Get Value    //input[@id="maxRowsFetchId"]
    Should Be Equal    5    ${maxResults}
    # fetch Top 5 Allow Resource in Last 7 Days
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_22}
    Click Element    ${title_link_22}
    Location Should Be    ${home}/${reporter_reports}
    ${decision}    Get Value    //select[@id="decision"]
    Should Be Equal    A    ${decision}
    ${reportType}    Get Value    //select[@id="reportType"]
    Should Be Equal    HORZ_BAR_CHART    ${reportType}
    ${groupingMode}    Get Value    //select[@id="groupingMode"]
    Should Be Equal    GROUP_BY_RESOURCE    ${groupingMode}
    ${maxResults}    Get Value    //input[@id="maxRowsFetchId"]
    Should Be Equal    5    ${maxResults}
    # fetch Trend of Deny Policies in Last 30 Days
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_31}
    Click Element    ${title_link_31}
    Location Should Be    ${home}/${reporter_reports}
    ${decision}    Get Value    //select[@id="decision"]
    Should Be Equal    D    ${decision}
    ${reportType}    Get Value    //select[@id="reportType"]
    Should Be Equal    BAR_CHART    ${reportType}
    ${groupingMode}    Get Value    //select[@id="groupingMode"]
    Should Be Equal    GROUP_BY_DAY    ${groupingMode}
    ${maxResults}    Get Value    //input[@id="maxRowsFetchId"]
    Should Be Equal    100    ${maxResults}
    # fetch Last 10 Allow Enforcement in Last 7 Days
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_32}
    Click Element    ${title_link_32}
    Location Should Be    ${home}/${reporter_reports}
    ${decision}    Get Value    //select[@id="decision"]
    Should Be Equal    A    ${decision}
    ${reportType}    Get Value    //select[@id="reportType"]
    Should Be Equal    TABULAR    ${reportType}
    ${groupingMode}    Get Element Attribute    //select[@id="groupingMode"]@disabled
    Should Be Equal    true    ${groupingMode}
    ${maxResults}    Get Value    //input[@id="maxRowsFetchId"]
    Should Be Equal    10    ${maxResults}
    # fetch Last 10 Deny Enforcement in Last 7 Days
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_33}
    Click Element    ${title_link_33}
    Location Should Be    ${home}/${reporter_reports}
    ${decision}    Get Value    //select[@id="decision"]
    Should Be Equal    D    ${decision}
    ${reportType}    Get Value    //select[@id="reportType"]
    Should Be Equal    TABULAR    ${reportType}
    ${groupingMode}    Get Element Attribute    //select[@id="groupingMode"]@disabled
    Should Be Equal    true    ${groupingMode}
    ${maxResults}    Get Value    //input[@id="maxRowsFetchId"]
    Should Be Equal    10    ${maxResults}
    # fetch Today's Alerts: Group by Tags
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_42}
    Click Element    ${title_link_42}
    Location Should Be    ${home}/${reporter_monitoring_alerts}
    ${selected}    Get Element Attribute    //li[@aria-labelledby="tab_by_tags"]@aria-selected
    Should Be Equal    true    ${selected}
    ${dateMode}    Get Value    //select[@id="date_mode_tags"]
    Should Be Equal    Relative    ${dateMode}
    ${dateWindow}    Get Value    //select[@id="date_window_tags"]
    Should Be Equal    today    ${dateWindow}
    # fetch Today's Alerts: Details
    Go To    ${home}/${reporter_dashboard}
    Wait Until Page Contains Element    ${title_link_43}
    Click Element    ${title_link_43}
    Location Should Be    ${home}/${reporter_monitoring_alerts}
    ${selected}    Get Element Attribute    //li[@aria-labelledby="tab_overview"]@aria-selected
    Should Be Equal    true    ${selected}
    ${dateModeAlerts}    Get Value    //select[@id="date_mode_alerts"]
    Should Be Equal    Relative    ${dateModeAlerts}
    ${dateWindowAlerts}    Get Value    //select[@id="date_window_alerts"]
    Should Be Equal    today    ${dateWindowAlerts}
    ${monitorAlerts}    Get Value    //select[@id="monitor_alerts"]
    Should Be Equal    -    ${monitorAlerts}
