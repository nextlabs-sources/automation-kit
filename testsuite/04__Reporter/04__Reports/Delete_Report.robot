*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${option button}    //*[@id="option_button"]
${delete button}    //*[@id="delete_button"]
${save button}    //*[@id="save_button"]
${popup dialog}    //*[@id="appBdy"]/div[7]
${report name field}    //*[@id="report_name"]
${report save button}    //*[@id="report_save"]
${search for report}    //*[@id="myReportsTable_filter"]/label/input
#${report name}    ${EMPTY}
${search result}    //*[@id="myReportsTable"]/tbody/tr/td    # search result of created report
${yes button}     //*[@id="appBdy"]/div[7]/div[3]/div/button[1]

*** Test Cases ***
Delete Report From List
    ${report name}    Create Report
    Reload Page
    Wait Until Page Contains    Report Query
    # Select created report
    Input Text    ${search for report}    ${report name}
    Sleep    2
    Click Element    ${search result}
    Page Should Contain    Report Query: ${report name}
    # Do delete
    Click Element    ${option button}
    Click Element    ${delete button}
    Wait Until Element Is Visible    ${popup dialog}
    Click Element    ${yes button}

*** Keywords ***
Create Report
    Go To    ${home}/${reporter_reports}
    Wait Until Page Contains    Report Query
    Click Element    ${option button}
    Click Element    ${save button}
    Wait Until Element Is Visible    ${popup dialog}
    ${report name}    Generate Random string    10
    Input Text    ${report name field}    ${report name}
    Click Element    ${report save button}
    Return From Keyword    ${report name}
