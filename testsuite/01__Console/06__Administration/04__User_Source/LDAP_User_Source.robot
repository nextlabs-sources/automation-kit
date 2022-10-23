*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        LDAPUserSource
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary
Library           Collections
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       Login_UserSource_Users_Delegation.xls    # \ ..\automation-kit\testdata\Control Center\Console.WebUI.xls
${worksheet}      LDAP User Source
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Users_Groups_UserSource

*** Test Cases ***
Adding LDAP User Source
    ${xpath worksheet}=    Evaluate    'Users_Groups_UserSource'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    set selenium implicit wait    10 seconds
    : FOR    ${i}    IN RANGE    10    11
    \    ${worksheet}=    Evaluate    'LDAP User Source'
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${name}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${ldap URL}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    ${LDAP Domain}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${LDAP Root DN}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${LDAP User Filter}=    Read Cell Data By Name    ${worksheet}    H${i}
    \    ${LDAP Search Base}=    Read Cell Data By Name    ${worksheet}    I${i}
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    L${i}
    \    Log    ${remark}
    \    Go To    ${Home}/${user source creation page}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['LDAP Name Editable Textbox']}    #name
    \    Input Text    ${dict['LDAP Name Editable Textbox']}    ${name}
    \    Input Text    ${dict['LDAP URL Editable Textbox']}    ${ldap URL}
    \    Input Text    ${dict['LDAP Domain Editable Textbox']}    ${LDAP Domain}
    \    Input Text    ${dict['LDAP Root DN Editable Textbox']}    ${LDAP Root DN}
    \    Input Text    ${dict['LDAP Username Editable Textbox']}    ${username}
    \    Input Password    ${dict['LDAP Password Editable Textbox']}    ${password}
    \    Input Text    ${dict['LDAP User Filter Editable Textbox']}    ${LDAP User Filter}
    \    Input Text    ${dict['User Search Base Editable Textbox']}    ${LDAP Search Base}
    \    Run Keyword If    '${result}'=='Fail'    Adding user source Should Fail
    \    Run Keyword If    '${result}'=='Pass'    Adding user source Should Succeed

*** Keywords ***
Adding user source Should Fail
    ${IsElementVisible1}=    Run Keyword And Return Status    Page Should Contain    mandatory
    ${IsElementVisible}=    Run Keyword And Return Status    Page Should Contain Element    //*[@class="cloudaz-signup-button" and text()="LDAP Connection Failed"]
    ${not successful}=    Evaluate    ${IsElementVisible1} or ${IsElementVisible}
    Should Be True    ${not successful}
    Run Keyword If    ${IsElementVisible}    Click Element    //*[@id="btn-notify-ok"]
    Reload Page

Adding user source Should Succeed
    ${xpath worksheet}=    Evaluate    'Users_Groups_UserSource'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Click element    ${dict['Connect Button']}
    sleep    2
    Element Should be visible    ${dict['sucess message']}
    Sleep    3
    wait until page contains element    ${dict['Add New Attribute Button']}
    Click element    ${dict['Add New Attribute Button']}
    Click Element    ${dict['Attribute Name Textbox']}/tr[1]/td[1]/div/select
    sleep    2
    Click element    //*[@label="sAMAccountName" and text()="sAMAccountName"]
    Input Text    ${dict['Map To Textbox']}/tr[1]/td[2]/div/input    username
    Click element    ${dict['Add To Table Button']}/tr[1]/td[3]/i[1]
    sleep    2
    Click element    ${dict['Add New Attribute Button']}
    wait until page contains element    ${dict['Attribute Name Textbox']}/tr[2]/td[1]/div/select
    Click Element    ${dict['Attribute Name Textbox']}/tr[2]/td[1]/div/select
    sleep    3
    ${IsElementVisible}=    Run Keyword And Return Status    Page Should Contain Element    //*[@label="givenName" and text()="givenName"]
    Run Keyword If    ${IsElementVisible}    Click Element    //*[@label="givenName" and text()="givenName"]
    Run Keyword If    not ${IsElementVisible}   Click element    //*[@label="name" and text()="name"]
    Input Text    ${dict['Map To Textbox']}/tr[2]/td[2]/div/input    firstName
    Click element    ${dict['Add To Table Button']}/tr[2]/td[3]/i[1]
    sleep    2
    Click Element    ${dict['User Source Save Button']}
    sleep    2
    Wait Until Element Contains    ${dict['sucess message']}    The User Source has been saved.
