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
${dashboard_tag}    //*[@class="tabs"]/li[1]/div/a
${reports_tab}    //*[@class="tabs"]/li[2]/div/a
${monitoring_tab}    //*[@class="tabs"]/li[3]/div/a
${monitors_tab}    //*[@id="subnav"]/form/ul/li[2]/div/a

*** Test Cases ***
Check Reporter Tabs
    Wait Until Page Contains    Logged in as:
    Click Element    ${dashboard_tag}
    Location Should Be    ${home}/${reporter_dashboard}
    Click Element    ${reports_tab}
    Location Should Be    ${home}/${reporter_reports}
    Click Element    ${monitoring_tab}
    Location Should Be    ${home}/${reporter_monitoring_alerts}
    Wait Until Element Is Visible    ${monitors_tab}
    Click Element    ${monitors_tab}
    Location Should Be    ${home}/${reporter_monitoring_monitors}
    Capture Page Screenshot
