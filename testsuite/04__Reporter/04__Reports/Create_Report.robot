*** Settings ***
Suite Setup       Sign In To Reporter
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    reporter
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           Collections

*** Variables ***
${name max length}    255
${description max length}    2000
${saveReportFormError}    //*[@id="saveReportFormError"]
${option button}    //*[@id="option_button"]
${save button}    //*[@id="save_button"]
${save report dialog}    //*[@id="appBdy"]/div[7]
${report save button}    //*[@id="report_save"]
${report name field}    //*[@id="report_name"]
${test number}    4    # 4 scenarios for different length of name or description
${new button}     //*[@id="myReportsDefinitionSubview:contentSubview:lstBtnRptBtn"]
${report description field}    //*[@id="report_description"]
${search for report}    //*[@id="myReportsTable_filter"]/label/input
${saved report}    Allow Enforcement in Last 7 Days
${search result for report}    //*[@id="8"]/td
${save as button}    //*[@id="save_as_button"]

*** Test Cases ***
Create Report Without Name
    Go To    ${home}/${reporter_reports}
    Wait Until Page Contains    Report Query
    Click Element    ${option button}
    Click Element    ${save button}
    Wait Until Element Is Visible    ${save report dialog}    # wait for save dialog popup
    Click Element    ${report save button}
    Element Should Be Visible    ${saveReportFormError}

Create Report With Existing Name
    Go To    ${home}/${reporter_reports}
    Wait Until Page Contains    Report Query
    Click Element    ${option button}
    Click Element    ${save button}
    Wait Until Element Is Visible    ${save report dialog}    # wait for save dialog popup
    Input Text    ${report name field}    ${saved report}
    Click Element    ${report save button}
    Element Should Be Visible    ${saveReportFormError}

Create Report With Valid Name
    Go To    ${home}/${reporter_reports}
    Wait Until Page Contains    Report Query
    Click Element    ${option button}
    Click Element    ${save button}
    Wait Until Element Is Visible    ${save report dialog}    # wait for save dialog popup
    ${random string}    Generate Random string    10
    Input Text    ${report name field}    ${random string}
    Click Element    ${report save button}
    Sleep    2
    Page Should Contain    ${random string}

Create Report With Name of Different Length
    Go To    ${home}/${reporter_reports}
    @{name length}=    Generate ${test number} Random Numbers Within 1 And ${name max length}
    Append To List    ${name length}    ${name max length}    # Ensure contain the maximum length
    # Length of name is 1~255
    : FOR    ${length}    IN    @{name length}
    \    Click Element    ${new button}
    \    Wait Until Page Contains    Report Query
    \    Click Element    ${option button}
    \    Click Element    ${save button}
    \    Wait Until Element Is Visible    ${save report dialog}
    \    ${random string}=    Generate Random String    ${length}
    \    Input Text    ${report name field}    ${random string}
    \    Click Element    ${report save button}
    \    Sleep    2
    \    Page Should Contain    ${random string}

Create Report With Description of Different Length
    Go To    ${home}/${reporter_reports}
    @{description length}=    Generate ${test number} Random Numbers Within 1 And ${description max length}
    Append To List    ${description length}    ${description max length}    # Ensure contain the maximum length
    # Length of description is 1~2000
    : FOR    ${length}    IN    @{description length}
    \    Click Element    ${new button}
    \    Wait Until Page Contains    Report Query
    \    Click Element    ${option button}
    \    Click Element    ${save button}
    \    Wait Until Element Is Visible    ${save report dialog}
    \    ${name string}=    Generate Random String    10
    \    Input Text    ${report name field}    ${name string}
    \    ${description string}=    Generate Random String    ${length}
    \    Input Text    ${report description field}    ${description string}
    \    Click Element    ${report save button}
    \    Sleep    2

Create Report by Save As
    Go To    ${home}/${reporter_reports}
    Wait Until Page Contains    Report Query
    Input Text    ${search for report}    ${saved report}
    Sleep    2
    Click Element    ${search result for report}    # Open a builtin saved report
    Page Should Contain    Report Query: ${saved report}
    Click Element    ${option button}
    Click Element    ${save as button}
    Wait Until Element Is Visible    ${save report dialog}
    ${name string}=    Generate Random String    10
    Input Text    ${report name field}    ${name string}
    Click Element    ${report save button}
    Sleep    2
    Page Should Contain    ${name string}
