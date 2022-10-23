*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Import XACML Policies
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
${worksheet}      XACML_Policy_Management
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    XACML_Policy_Management

*** Test Cases ***
Import XACML Policies
    ${xpath worksheet}=    Evaluate    'XACML_Policy_Management'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Go To    ${Home}/${XACML Policy Management List}
    Maximize browser window
    : FOR    ${i}    IN RANGE    6    7
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${policylocation}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    Wait until page contains Element    ${dict['Import Policy Button']}
    \    Click Element    ${dict['Import Policy Button']}
    \    sleep    2
    \    Choose File    ${dict['Browse Button']}    ${DATA_DIR}\\${policylocation}
    \    sleep    2
    \    Click Element    ${dict['Browse Import Button']}
    \    Run Keyword If    '${result}'=='Fail'    Adding Policy Should Fail
    \    Run Keyword If    '${result}'=='Pass'    Adding Policy Should Succeed
    \    sleep    2

*** Keywords ***
Adding Policy Should Fail
    ${xpath worksheet}=    Evaluate    'XACML_Policy_Management'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Wait until page contains Element    ${dict['Invalid File OK Button']}
    Click Element    ${dict['Invalid File OK Button']}

Adding Policy Should Succeed
    ${xpath worksheet}=    Evaluate    'XACML_Policy_Management'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    Wait until page contains Element    ${dict['Success Message']}
