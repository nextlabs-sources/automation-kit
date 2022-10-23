*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        Enrollment
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
${worksheet}      Enrollment_Manager
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Enrollment
${Browse_Conn_File_Button}    //input[@id="input-task-fileUpload-connection-file"]
${Browse_Def_File_Button}    //input[@id="input-task-fileUpload-definition-file"]
${Browse_LDIF_File_Button}    //input[@id="input-task-ldif-fileUploadExtra"]

*** Test Cases ***
delete Azure Enrollment
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    7    8
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${Eclipse_Button}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    Go To    ${Home}/${Enrollment Management List}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['Enrollment Menu']}
    \    Click Element    ${dict['Enrollment Menu']}
    \    Wait until page contains Element    ${Eclipse_Button}
    \    Click Element    ${Eclipse_Button}
    \    Wait until page contains Element    ${dict['EM Delete Button']}
    \    Click Element    ${dict['EM Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Execute or Delete Button']}
    \    Click Element    ${dict['EM Execute or Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Success OK Button']}
    \    Click Element    ${dict['EM Success OK Button']}

Delete LDIF Enrollment
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    4    6
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${Eclipse_Button}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    ${EM_Delete_Button}=    Read Cell Data By Name    ${worksheet}    N${i}
    \    Go To    ${Home}/${Enrollment Management List}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['Enrollment Menu']}
    \    Click Element    ${dict['Enrollment Menu']}
    \    Wait until page contains Element    ${Eclipse_Button}
    \    Click Element    ${Eclipse_Button}
    \    Wait until page contains Element    ${EM_Delete_Button}
    \    Click Element    ${EM_Delete_Button}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Execute or Delete Button']}
    \    Click Element    ${dict['EM Execute or Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Success OK Button']}
    \    Click Element    ${dict['EM Success OK Button']}

Delete LDAP Enrollment
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    6    7
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${Eclipse_Button}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    ${EM_Delete_Button}=    Read Cell Data By Name    ${worksheet}    N${i}
    \    Go To    ${Home}/${Enrollment Management List}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['Enrollment Menu']}
    \    Click Element    ${dict['Enrollment Menu']}
    \    Wait until page contains Element    ${Eclipse_Button}
    \    Click Element    ${Eclipse_Button}
    \    Wait until page contains Element    ${EM_Delete_Button}
    \    Click Element    ${EM_Delete_Button}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Execute or Delete Button']}
    \    Click Element    ${dict['EM Execute or Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Success OK Button']}
    \    Click Element    ${dict['EM Success OK Button']}
