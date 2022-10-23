*** Settings ***
Documentation     This is to create users
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI
Library           Selenium2Library
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot

*** Variables ***
${load more button}    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/p/button
${action xpath}    //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul
${modified time}    div/div/div[2]/div[1]/p[2]/friendly-date/span[2]    # //*[@id="cc-ps-main-content"]/div/div/div[2]/div[2]/ul/li[1]/div/div/div[2]/div[1]/p[2]/friendly-date/span[2] \ \

*** Test Cases ***
List users using last update
    Go To    ${Home}/${List User page }
    Wait Until Page Contains Element    //*[@id="cc-ps-main-content"]/div/div/div[1]/a[1]    #add user button
    : FOR    ${i}    IN RANGE    100
    \    Sleep    2
    \    ${has more}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${load more button}
    \    Exit For Loop If    ${has more}==False
    \    Run Keyword If    ${has more}==True    Click Element    ${load more button}
    #    Sleep    1
    Sleep    1
    ${action number}=    Get Matching Xpath Count    ${action xpath}/*
    Log    ${action number}
    Sleep    1
    ${last time}=    Get Text    ${action xpath}/li[1]/${modified time}
    Log    ${last time}
    : FOR    ${index}    IN RANGE    ${action number}
    \    ${new index}=    Evaluate    ${index}+1
    \    Sleep    3
    \    ${last time}=    Get Text    ${action xpath}/li[${new index}]/${modified time}
    \    Log    ${last time}

*** Keywords ***
users display should match criteria
    [Arguments]    ${search criteria}
    Sleep    1
    ${matching number}=    Get Matching Xpath Count    ${action xpath}/*
    Log    ${matching number}
    Run Keyword If    ${matching number}==0    Page Should Contain    No components match the specified criteria.
    : FOR    ${i}    IN RANGE    ${matching number}
    \    Log    ${i}
    \    ${index}=    Evaluate    ${i}+1
    \    Element Should Contain    ${action xpath}/li[${index}]    ${search criteria}
