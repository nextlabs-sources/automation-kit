*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        GenerateEncryptedPassword
Library           Selenium2Library
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary
Library           Collections
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${workbook}       Configuration_Tools.xls    # \ ..\automation-kit\testdata\Control Center\Configuration_Tools.xls
${worksheet}      Generate_Encrypted_Password
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Enrollment

*** Test Cases ***
Generate Encrypted Password
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Go To    ${Home}/${Enrollment Management List}
    Maximize browser window
    : FOR    ${i}    IN RANGE    3    16
    \    Wait until page contains Element    ${dict['Generate Encrypted Password Menu']}
    \    Click Element    ${dict['Generate Encrypted Password Menu']}
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${Password}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    Wait until page contains Element    ${dict['GEP Password Editable Textbox']}
    \    Input Password    ${dict['GEP Password Editable Textbox']}    ${Password}
    \    Click Element    ${dict['GEP Encrypt Button']}
    \    Run Keyword If    '${result}'=='Fail'    Generate encrypted password Should Fail
    \    Run Keyword If    '${result}'=='Pass'    Generate encrypted password Should Succeed    ${i}
    \    Reload Page

Verify the Password Eye Icon
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Go To    ${Home}/${Enrollment Management List}
    Maximize browser window
    Wait until page contains Element    ${dict['Generate Encrypted Password Menu']}
    Click Element    ${dict['Generate Encrypted Password Menu']}
    Input Password    ${dict['GEP Password Editable Textbox']}    12345Blue!
    Click Element    ${dict['GEP Password Eye Icon encrypted format']}    # Clicking the eye icon to view the password in text format
    Click Element    ${dict['GEP Password Editable Textbox']}
    ${eye icon clicked}=    Run Keyword And Return Status    Page Should Contain Element    //input[type="text"]
    ${text_visible}=    Evaluate    ${eye icon clicked}
    Should Be True    ${text_visible}
    Click Element    ${dict['GEP Password Eye Icon text format']}    # Clicking the eye icon to view the password in encrypted format
    Click Element    ${dict['GEP Password Editable Textbox']}
    ${eye icon clicked}=    Run Keyword And Return Status    Page Should Contain Element    //input[type="password"]
    ${text_visible}=    Evaluate    ${eye icon clicked}
    Should Be True    ${text_visible}

*** Keywords ***
Generate encrypted password Should Fail
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    5 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${mandatory field missing}=    Run Keyword And Return Status    Page Should Contain    mandatory
    ${password wrong}=    Run Keyword And Return Status    Page Should Contain Element    ${dict['Error Message']}
    ${not successful}=    Evaluate    ${mandatory field missing} or ${password wrong}
    Should Be True    ${not successful}

Generate encrypted password Should Succeed
    [Arguments]    ${i}
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Open Excel    ${DATA_DIR}/${workbook}
    ${encrypted_password}=    Read Cell Data By Name    ${worksheet}    C${i}
    ${Field_Disabled}=    Run Keyword And Return Status    Element Should Be Disabled    ${dict['GEP Encrypted Password Textbox']}
    Should Be True    ${Field_Disabled}
    #Textfield Should Contain    ${dict['GEP Encrypted Password Textbox']}    ${encrypted_password}
    Page Should Contain Element    //*[@class="cc-ps-create-page-editor-input-placeholder cc-create-page-editor-data-right cc-create-page-common-input ng-pristine ng-untouched ng-valid ng-isolate-scope ng-not-empty"]
