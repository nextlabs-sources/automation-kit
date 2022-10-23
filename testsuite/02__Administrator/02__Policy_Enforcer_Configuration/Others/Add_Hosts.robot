*** Settings ***
Suite Setup       Sign In To Administrator
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    Administrator_With_Data
Library           Selenium2Library
Resource          ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           OperatingSystem
Library           String

*** Variables ***
${Hosts Link}     //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:hstsTbLbl"]
${Add Hosts Button}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigHostsTabBody:caAddHstsBtn"]
${Search Button}    //*[@id="agentConfigBrowseHostsDefinitionSubview:srchFrm:srchBtn"]
${Max result}     //*[@id="agentConfigBrowseHostsDefinitionSubview:maxSearchResultsForm:maxResultsSelect"]
${HostsInAddpage}    //*[@id='agentConfigBrowseHostsDefinitionSubview:srchBktsFrm:selectableItemsTable    # //*[@id="agentConfigBrowseHostsDefinitionSubview:slctdItmLstDv:lstTbl"]
${Add Button}     //*[@id="agentConfigBrowseHostsDefinitionSubview:slctdItmLstDv:addItmsBtn"]
${Hosts Table}    //*[@class='agentconfighosttable']/tbody/tr[2]/td
${Table}          //*[@class='agentconfighosttable']/tbody/tr
${Host List}      xpath=//*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigHostsTabBody:hostTable"]

*** Test Cases ***
Add desktop hosts
    click link    Policy Enforcer Configuration
    Comment    click link    Portal Enforcer
    click element    ${Hosts Link}    #switch to the hosts page
    click element    ${Add Hosts Button}    #click add button to add new hosts
    click element    ${Search Button}    #click search button to display the host
    select from list by value    ${Max result}    500
    ${row}    get webelements    //*[@class='selectableItemTable']/tbody/tr[not(@class="datatableseparator")]/td    #get current hosts count
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random Hosts}    set variable    ${HostsInAddpage}:${randomnumber}:itmNmLnk']
    click element    ${Random Hosts}    #select random hosts to add
    click element    ${Add Button}    #click the add button
    ${test}    get matching xpath count    ${Hosts Table}
    run keyword if    ${test}==1    log    Add hosts failed
    ...    ELSE    list hosts

Add file server hosts
    click link    Policy Enforcer Configuration
    click link    File Server Enforcer
    click element    ${Hosts Link}    #switch to the hosts page
    click element    ${Add Hosts Button}    #click add button to add new hosts
    click element    ${Search Button}    #click search button to display the host
    select from list by value    ${Max result}    500
    ${row}    get webelements    //*[@class='selectableItemTable']/tbody/tr[not(@class="datatableseparator")]/td    #get current hosts count
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random Hosts}    set variable    ${HostsInAddpage}:${randomnumber}:itmNmLnk']
    click element    ${Random Hosts}    #select random hosts to add
    click element    ${Add Button}    #click the add button
    ${test}    get matching xpath count    ${Hosts Table}
    run keyword if    ${test}==1    log    Add hosts failed
    ...    ELSE    list hosts

Add portal hosts
    click link    Policy Enforcer Configuration
    click link    Portal Enforcer
    click element    ${Hosts Link}    #switch to the hosts page
    click element    ${Add Hosts Button}    #click add button to add new hosts
    click element    ${Search Button}    #click search button to display the host
    select from list by value    ${Max result}    500
    ${row}    get webelements    //*[@class='selectableItemTable']/tbody/tr[not(@class="datatableseparator")]/td    #get current hosts count
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random Hosts}    set variable    ${HostsInAddpage}:${randomnumber}:itmNmLnk']
    click element    ${Random Hosts}    #select random hosts to add
    click element    ${Add Button}    #click the add button
    ${test}    get matching xpath count    ${Hosts Table}
    run keyword if    ${test}==1    log    Add hosts failed
    ...    ELSE    list hosts

*** Keywords ***
list hosts
    ${row}    get webelements    ${Table}
    ${rowcount}    get length    ${row}
    : FOR    ${listhosts}    IN RANGE    2    ${rowcount}+1
    \    ${hosts}    get table cell    ${Host List}    ${listhosts}    1
    \    log    ${hosts}
