*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        WebUI    priority/2    severity/mild    type/smoke    mode/full
Library           Selenium2Library
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${search button}    //*[@id="cc-ps-main-content"]/div/div/div[1]/div[4]/button
${policymodel list}    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul/*
${Click on policy model type}    //*[@id="resourceSearchForm"]/div/div[1]/button
${subject checkbox}    //*[@id="resourceSearchForm"]/div/div[1]/div/ul/li[2]/label/span/span
${search apply button}    //*[@id="resourceSearchForm"]/p[2]/button[3]
${subject label}    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul/li/div/div/div/div/div[2]/div[2]/div[2]/span    # to read the subject label from the \ list
${sort by}        //*[@id="cc-sort-by-select"]/button
${get first name of first policy model}    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul/li[4]/div/div/div/div/div[2]/div[2]/div[1]/p[1]/span
${ellipse button}    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul/li[4]/div/div/div/div/div[2]/div[2]/div[4]/p/button
${Clone Button}    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul/li[4]/div/div/div/div/div[2]/div[2]/div[4]/div/div/button[3]
${Confirm Button}    //body/div[1]/div/div/div[2]/button
${last update from the drop down list}    //*[@id="cc-sort-by-select"]/ul/li[1]
${Policy Model Page}    //*[@id="cc-ps-main-content"]/div/div/div[2]
${xpath workbook}    Xpaths.xls
${xpath worksheet}    Policy Model

*** Test Cases ***
Getting Count Of Number of Component Types From List
    [Documentation]    Getting Count Of Number of Component Types From List
    ...
    ...    including users and resource
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Go To    ${Home}/${List Policy Model Page}
    Wait Until Page Contains Element    ${dict['Search icon']}    #search policy model button
    Display All Policy Models
    ${policy models displayed}=    Get Matching Xpath Count    ${dict['PM Complete List']}    #lists of policy models

Clone Resource Policy Model
    [Tags]
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Go To    ${Home}/${List Policy Model Page}
    Maximize Browser Window
    Wait Until Page Contains Element    ${dict['Search icon']}    #search policy model button
    FOR    ${in}    IN RANGE    3
        Wait Until Page Contains Element    ${dict['First Resource Component Type Name From List']}    #store name of policy model
        ${name}=    Get Text    ${dict['First Resource Component Type Name From List']}    #store name of policy model
        sleep    4
        Click Element    ${dict['Resource elipsis button']}    #ellipse button
        Sleep    3
        Wait until page contains Element    ${dict['Resource clone Button']}    #//*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul/li[4]/div/div/div/div/div[2]/div[2]/div[4]/div
        Sleep    3
        Click Element    ${dict['Resource clone Button']}    #clone button
        Wait Until Page Contains Element    ${dict['OK Button After Cloning Component Type']}    #confirm button
        Click Element    ${dict['OK Button After Cloning Component Type']}    #confirm button
        Sleep    3
    END

Search for Subject resource type policy model
    [Tags]
    Go To    ${Home}/${List Policy Model Page}
    Wait Until Page Contains Element    ${search button}    #search policy model button
    Click Element    ${search button}
    Click Element    ${Click on policy model type}    #selecting the type in the policy model
    Sleep    0.2
    Click Element    ${subject checkbox}    #select Subject from the drop down list
    Click Element    ${search apply button}    #apply in the search
    Wait Until Page Contains Element    ${subject label}    #page containg only subject resource type

List Policy Model By Last Updated
    [Tags]    testtt
    Go To    ${Home}/${List Policy Model Page}
    Maximize Browser Window
    Wait Until Page Contains Element    ${search button}    #search policy model button
    Display All Policy Models
    Click element    ${sort by}    #sort by field drop down list
    Wait Until Page Contains Element    ${last update from the drop down list}    #last Updated
    Click element    ${last update from the drop down list}

*** Keywords ***
Display All Policy Models
    [Documentation]    Initially load more displays only 20 component types, unless the user clicks on the LOAD MORE.
    ...
    ...    Making all the \ policy models visible using load more button at the bottom of the page
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    FOR    ${i}    IN RANGE    9999
        ${has more}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${dict['LOAD MORE Button']}    timeout=2
        Exit For Loop If    '${has more}'=='False'
        Run Keyword And Ignore Error    Click Element    ${dict['LOAD MORE Button']}
    END

Get Cloned Name
    [Arguments]    ${name}
    [Documentation]    Input: name of a policy model to be cloned
    ...    Output: cloned name of the policy model
    ...    e.g.
    ...    input: abc check all existing name with the format abc - (XXX)
    ...    output: abc - (XXX+1)
    ...
    ...    input: abc - (3) check all existing name with the format abc - (XXX)
    ...    if abc - (1), abc - (2), abc - (3) found
    ...    output abc - (4)
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    ${match object}=    Evaluate    re.match('^([a-zA-Z0-9]+)(.-.\\([0-9]{1,}\\))$', '${name}')    modules=re
    ${new name}=    Run Keyword If    '${match object}'!='None'    Evaluate    re.match('^([a-zA-Z0-9]+)(.-.\\([0-9]{1,}\\))$', '${name}').group(1)    modules=re
    Log    ${new name}
    ${name}=    Set Variable If    '${new name}'!='None'    ${new name}    ${name}
    log    ${name}
    ${number of clone}=    Get Length    ${cloned names}
    #    Log    ${number of clone}
    FOR    ${i}    IN RANGE    ${number of clone}
        log    @{cloned names}[${i}][0]
        ${latest cloned name}=    Evaluate    @{cloned names}[0][0]
        ${cloned name}=    Run Keyword If    '${number of clone}'=='1'    Evaluate    '${name}'+' - (1)'
        ${latest cloned name number}=    Run Keyword If    '${number of clone}'!='1'    Evaluate    re.match('^([a-zA-Z0-9]+)(.-.\\()([0-9]{1,})(\\))$', '${latest cloned name}').group(3)    modules=re
        ${old index}=    Run Keyword If    '${number of clone}'!='1'    Convert To Integer    ${latest cloned name number}
        ${new index}=    Set Variable If    '${number of clone}'!='1'    ${old index+1}
        Log    ${new index}
        ${temp}=    Evaluate    '${name}'+' - (${new index})'
    END
    ${new index}=    Set Variable    ${number of clone}
    ${cloned name}=    Evaluate    '${name}'+' - (${new index})'
    [Return]    ${cloned name}

Policy Model \ Displayed Should Match Criteria
    Sleep    1
    ${matching number}=    Get Matching Xpath Count    ${action xpath}/*
    Log    ${matching number}
    Run Keyword If    ${matching number}==0    Page Should Contain    No components match the specified criteria.
    FOR    ${i}    IN RANGE    ${matching number}
        Log    ${i}
        ${index}=    Evaluate    ${i}+1
        Element Should Contain    ${action xpath}/li[${index}]    ${search criteria}
    END
