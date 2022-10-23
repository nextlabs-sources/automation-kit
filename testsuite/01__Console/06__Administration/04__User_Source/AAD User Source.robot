*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        AADUserSource
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
${worksheet}      AAD User Source
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Users_Groups_UserSource

*** Test Cases ***
Configure AAD User Source With Empty Value
    ${xpath worksheet}=    Evaluate    'Users_Groups_UserSource'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    4    11
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${name}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${authorityURL}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${extendedattributeURI}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${tenantID}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${applicationID}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${applicationpwd}=    Read Cell Data By Name    ${worksheet}    H${i}
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    L${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    K${i}
    \    Log    ${remark}
    \    Go To    ${Home}/${user source creation page}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['User Source Type Dropdown Textbox']}
    \    Click Element    ${dict['User Source Type Dropdown Textbox']}
    \    Click Element    ${dict['User Source Type Azure']}
    \    Input Text    ${dict['Azure Name Editable Textbox']}    ${name}
    \    Input Text    ${dict['Authority URI Editable Textbox']}    ${authorityURL}
    \    Input Text    ${dict['Extended Attribute URI Editable Textbox']}    ${extendedattributeURI}
    \    Input Text    ${dict['Tenant ID Editable Textbox']}    ${tenantID}
    \    Input Text    ${dict['Application ID Editable Textbox']}    ${applicationID}
    \    Input Password    ${dict['Application Password Editable Textbox']}    ${applicationpwd}
    Run Keyword If    '${result}'=='Fail'    Adding user source Should Fail
    Run Keyword If    '${result}'=='Pass'    Adding user source Should Succeed

Configure AAD User Source With Incorrect Data
    ${xpath worksheet}=    Evaluate    'Users_Groups_UserSource'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    11    14
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${name}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${authorityURL}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${extendedattributeURI}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${tenantID}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${applicationID}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${applicationpwd}=    Read Cell Data By Name    ${worksheet}    H${i}
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    L${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    K${i}
    \    Log    ${remark}
    \    Go To    ${Home}/${user source creation page}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['User Source Type Dropdown Textbox']}
    \    Click Element    ${dict['User Source Type Dropdown Textbox']}
    \    Click Element    ${dict['User Source Type Azure']}
    \    Input Text    ${dict['Azure Name Editable Textbox']}    ${name}
    \    Input Text    ${dict['Authority URI Editable Textbox']}    ${authorityURL}
    \    Input Text    ${dict['Extended Attribute URI Editable Textbox']}    ${extendedattributeURI}
    \    Input Text    ${dict['Tenant ID Editable Textbox']}    ${tenantID}
    \    Input Text    ${dict['Application ID Editable Textbox']}    ${applicationID}
    \    Input Password    ${dict['Application Password Editable Textbox']}    ${applicationpwd}
    Run Keyword If    '${result}'=='Fail'    Adding user source Should Fail
    Run Keyword If    '${result}'=='Pass'    Adding user source Should Succeed

Adding AAD User Source
    ${xpath worksheet}=    Evaluate    'Users_Groups_UserSource'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    3    4
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${name}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${authorityURL}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${extendedattributeURI}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${tenantID}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${applicationID}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${applicationpwd}=    Read Cell Data By Name    ${worksheet}    H${i}
    \    ${remark}=    Read Cell Data By Name    ${worksheet}    L${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    K${i}
    \    Log    ${remark}
    \    Go To    ${Home}/${user source creation page}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['User Source Type Dropdown Textbox']}
    \    Click Element    ${dict['User Source Type Dropdown Textbox']}
    \    Click Element    ${dict['User Source Type Azure']}
    \    Input Text    ${dict['Azure Name Editable Textbox']}    ${name}
    \    Input Text    ${dict['Authority URI Editable Textbox']}    ${authorityURL}
    \    Input Text    ${dict['Extended Attribute URI Editable Textbox']}    ${extendedattributeURI}
    \    Input Text    ${dict['Tenant ID Editable Textbox']}    ${tenantID}
    \    Input Text    ${dict['Application ID Editable Textbox']}    ${applicationID}
    \    Input Password    ${dict['Application Password Editable Textbox']}    ${applicationpwd}
    Run Keyword If    '${result}'=='Fail'    Adding user source Should Fail
    Run Keyword If    '${result}'=='Pass'    Adding user source Should Succeed

*** Keywords ***
Adding user source Should Fail
    Page Should Contain    mandatory

Adding user source Should Succeed
    ${xpath worksheet}=    Evaluate    'Users_Groups_UserSource'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Open Excel    ${DATA_DIR}/${xpath workbook}
    set selenium implicit wait    15 seconds
    Click element    ${dict['Verify Button']}
    sleep    2
    Element Should be visible    ${dict['sucess message']}
    wait until page contains element    ${dict['Add New Attribute Button']}
    Click element    ${dict['Add New Attribute Button']}
    wait until page contains element    ${dict['Attribute Name Textbox']}/tr[1]/td[1]/div/input
    Click Element    ${dict['Attribute Name Textbox']}/tr[1]/td[1]/div/input
    Click element    //*[@title="userPrincipalName" and text()="userPrincipalName"]
    Input Text    ${dict['Map To Textbox']}/tr[1]/td[2]/div/input    username
    Click element    ${dict['Add To Table Button']}/tr[1]/td[3]/i[1]
    Click element    ${dict['Add New Attribute Button']}
    wait until page contains element    ${dict['Attribute Name Textbox']}/tr[2]/td[1]/div/input
    Click Element    ${dict['Attribute Name Textbox']}/tr[2]/td[1]/div/input
    Click element    //*[@title="givenName" and text()="givenName"]
    Input Text    ${dict['Map To Textbox']}/tr[2]/td[2]/div/input    firstName
    Click element    ${dict['Add To Table Button']}/tr[2]/td[3]/i[1]
    Click element    ${dict['Add New Attribute Button']}
    wait until page contains element    ${dict['Attribute Name Textbox']}/tr[3]/td[1]/div/input
    Click Element    ${dict['Attribute Name Textbox']}/tr[3]/td[1]/div/input
    Click element    //*[@title="surname" and text()="surname"]
    Input Text    ${dict['Map To Textbox']}/tr[3]/td[2]/div/input    lastName
    Click element    ${dict['Add To Table Button']}/tr[3]/td[3]/i[1]
    Click element    ${dict['Add New Attribute Button']}
    wait until page contains element    ${dict['Attribute Name Textbox']}/tr[4]/td[1]/div/input
    Click Element    ${dict['Attribute Name Textbox']}/tr[4]/td[1]/div/input
    Click element    //*[@title="mail" and text()="mail"]
    Input Text    ${dict['Map To Textbox']}/tr[4]/td[2]/div/input    email
    Click element    ${dict['Add To Table Button']}/tr[4]/td[3]/i[1]
    Click element    ${dict['Add New Attribute Button']}
    wait until page contains element    ${dict['Attribute Name Textbox']}/tr[5]/td[1]/div/input
    Click Element    ${dict['Attribute Name Textbox']}/tr[5]/td[1]/div/input
    Input Text    ${dict['Attribute Name Textbox']}/tr[5]/td[1]/div/input    department
    Input Text    ${dict['Map To Textbox']}/tr[5]/td[2]/div/input    department
    Click element    ${dict['Add To Table Button']}/tr[5]/td[3]/i[1]
    Click Element    ${dict['User Source Save Button']}
    sleep    2
    Wait Until Element Contains    ${dict['sucess message']}    The User Source has been saved.
