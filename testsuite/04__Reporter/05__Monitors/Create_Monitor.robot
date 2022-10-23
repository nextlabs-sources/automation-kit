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
${add monitor button}    //*[@id="addMonitor"]
${name field}     //*[@id="name"]
${description field}    //*[@id="description"]
${name max length}    255
${description max length}    2000
${save button}    //*[@id="save"]
${create monitor dialog}    //*[@id="appBdy"]/div[5]
${error alert}    //*[@id="generalFormErrorAlert"]
${aggregator}     //*[@id="aggregator"]
${aggregate value}    //*[@id="aggregate_value"]
${add aggregator button}    //*[@id="addAggregate"]
${test number}    4
${filters tab}    //*[@id="link-2"]
${tags tab}       //*[@id="link-3"]
${add user filter}    //*[@id="user_addFilter"]
${add resource filter}    //*[@id="resource_addFilter"]
${add policy filter}    //*[@id="policy_addFilter"]
${add others filter}    //*[@id="others_addFilter"]
${filter alert}    //*[@id="filterFormErrorAlert"]
${close filter alert}    //*[@id="filterFormErrorAlert"]/a
${add tag}        //*[@id="addTag"]
${tag alert}      //*[@id="tagFormErrorAlert"]
${close tag alert}    //*[@id="tagFormErrorAlert"]/a
${tag name field}    //*[@id="tag_name"]
${tag value field}    //*[@id="tag_value"]

*** Test Cases ***
Create monitor without name
    Go To    ${home}/${reporter_monitoring_monitors}
    Click Element    ${add monitor button}
    Wait Until Element Is Visible    ${create monitor dialog}
    Click Element    ${save button}
    Element Should Be Visible    ${error alert}
    Element Should Contain    ${error alert}    Monitor name is required

Create monitor with specific character in name
    Go To    ${home}/${reporter_monitoring_monitors}
    Click Element    ${add monitor button}
    Wait Until Element Is Visible    ${create monitor dialog}
    @{spec}    Create List    ^    &    *    {    }
    : FOR    ${character}    IN    @{spec}
    \    Input Text    ${name field}    ${character}
    \    Click Element    ${save button}
    \    Element Should Be Visible    ${error alert}
    \    Element Should Contain    ${error alert}    Characters ^&*{} are not allowed in Monitor name

Create monitor without aggregator
    Go To    ${home}/${reporter_monitoring_monitors}
    Click Element    ${add monitor button}
    Wait Until Element Is Visible    ${create monitor dialog}
    ${random string}    Generate Random String    10
    Input Text    ${name field}    ${random string}
    Click Element    ${save button}
    Element Should Be Visible    ${error alert}
    Element Should Contain    ${error alert}    There must be at least one aggregator defined

Create a simple monitor
    Go To    ${home}/${reporter_monitoring_monitors}
    Click Element    ${add monitor button}
    Wait Until Element Is Visible    ${create monitor dialog}
    ${random string}    Generate Random String    10
    Input Text    ${name field}    ${random string}
    Select From List    ${aggregator}    number_records
    Input Text    ${aggregate value}    1
    Click Element    ${add aggregator button}
    Click Element    ${save button}
    Sleep    2
    Page Should Contain    ${random string}

Create monitor with name of different length
    Go To    ${home}/${reporter_monitoring_monitors}
    @{name length}=    Generate ${test number} Random Numbers Within 1 And ${name max length}
    Append To List    ${name length}    ${name max length}    # Ensure contain the maximum length
    # Length of name is 1~255
    : FOR    ${length}    IN    @{name length}
    \    Click Element    ${add monitor button}
    \    Wait Until Element Is Visible    ${create monitor dialog}
    \    ${random string}    Generate Random String    ${length}
    \    Input Text    ${name field}    ${random string}
    \    Select From List    ${aggregator}    number_records
    \    Input Text    ${aggregate value}    1
    \    Click Element    ${add aggregator button}
    \    Click Element    ${save button}
    \    Sleep    2

Create monitor with description of different length
    Go To    ${home}/${reporter_monitoring_monitors}
    @{description length}=    Generate ${test number} Random Numbers Within 1 And ${description max length}
    Append To List    ${description length}    ${description max length}    # Ensure contain the maximum length
    # Length of name is 1~255
    : FOR    ${length}    IN    @{description length}
    \    Click Element    ${add monitor button}
    \    Wait Until Element Is Visible    ${create monitor dialog}
    \    ${name string}    Generate Random String    5
    \    Input Text    ${name field}    ${name string}
    \    ${description string}    Generate Random String    ${length}
    \    Input Text    ${description field}    ${description string}
    \    Select From List    ${aggregator}    number_records
    \    Input Text    ${aggregate value}    1
    \    Click Element    ${add aggregator button}
    \    Click Element    ${save button}
    \    Sleep    2

Create monitor with existing name
    Go To    ${home}/${reporter_monitoring_monitors}
    # Firstly create a monitor
    Click Element    ${add monitor button}
    Wait Until Element Is Visible    ${create monitor dialog}
    ${name string}    Generate Random String    10
    Input Text    ${name field}    ${name string}
    Select From List    ${aggregator}    number_records
    Input Text    ${aggregate value}    1
    Click Element    ${add aggregator button}
    Click Element    ${save button}
    Sleep    2
    # Create monitor with existing name
    Page Should Contain    ${name string}
    Click Element    ${add monitor button}
    Wait Until Element Is Visible    ${create monitor dialog}
    Input Text    ${name field}    ${name string}
    Select From List    ${aggregator}    number_records
    Input Text    ${aggregate value}    1
    Click Element    ${add aggregator button}
    Click Element    ${save button}
    Element Should Be Visible    ${error alert}
    Element Should Contain    ${error alert}    Monitor with the same name already exists

Add filters and tag with empty value
    Go To    ${home}/${reporter_monitoring_monitors}
    Click Element    ${add monitor button}
    Wait Until Element Is Visible    ${create monitor dialog}
    ${random string}    Generate Random String    10
    Input Text    ${name field}    ${random string}
    Select From List    ${aggregator}    number_records
    Input Text    ${aggregate value}    1
    Click Element    ${add aggregator button}
    Click Element    ${filters tab}
    # Add empty user criteria
    Click Element    ${add user filter}
    Element Should Be Visible    ${filter alert}
    Element Should Contain    ${filter alert}    Please enter a non-empty valid String. characters ^&*{} are not allowed.
    Click Element    ${close filter alert}
    # Add empty resource criteria
    Click Element    ${add resource filter}
    Element Should Be Visible    ${filter alert}
    Element Should Contain    ${filter alert}    Please enter a non-empty valid String. characters ^&*{} are not allowed.
    Click Element    ${close filter alert}
    # Add empty policy criteria
    Click Element    ${add policy filter}
    Element Should Be Visible    ${filter alert}
    Element Should Contain    ${filter alert}    Please enter a non-empty valid String. characters ^&*{} are not allowed.
    Click Element    ${close filter alert}
    # Add empty other criteria
    Click Element    ${add others filter}
    Element Should Be Visible    ${filter alert}
    Element Should Contain    ${filter alert}    Please enter a non-empty valid String. characters ^&*{} are not allowed.
    Click Element    ${close filter alert}
    # Add empty tag
    Click Element    ${tags tab}
    Click Element    ${add tag}
    Element Should Be Visible    ${tag alert}
    Element Should Contain    ${tag alert}    Please enter a non-empty valid String. characters ^&*{} are not allowed.
    Click Element    ${close tag alert}
    # Add valid tag name and empty value
    ${tag name}    Generate Random String    5
    Input Text    ${tag name field}    ${tag name}
    Click Element    ${add tag}
    Element Should Be Visible    ${tag alert}
    Element Should Contain    ${tag alert}    Please enter a non-empty valid String. characters ^&*{} are not allowed.
    Click Element    ${close tag alert}
    # Add empty tag name and valid value
    ${tag value}    Generate Random String    5
    Input Text    ${tag value field}    ${tag value}
    Click Element    ${add tag}
    Element Should Be Visible    ${tag alert}
    Element Should Contain    ${tag alert}    Please enter a non-empty valid String. characters ^&*{} are not allowed.
