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
Create Azure Enrollment
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    7    8
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${taskname}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    ${enrollment_type}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${enrollmentname}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${connection_file}=    Read Cell Data By Name    ${worksheet}    H${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    K${i}
    \    ${Eclipse_Button}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    Go To    ${Home}/${Enrollment Management List}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['Enrollment Menu']}
    \    Click Element    ${dict['Enrollment Menu']}
    \    Wait until page contains Element    ${dict['EM Create Task Button']}
    \    Click Element    ${dict['EM Create Task Button']}
    \    Wait until page contains Element    ${dict['EM Task Name Editable textbox']}
    \    Input Text    ${dict['EM Task Name Editable textbox']}    ${taskname}
    \    Input Text    ${dict['EM Description Editable textbox']}    ${description}
    \    Click Element    ${dict['Enrollment Type Dropdown Select Textbox']}
    \    Click element    //*[@label="${enrollment_type}" and text()="${enrollment_type}"]
    \    Input Text    ${dict['EM Enrollment Name Editable textbox']}    ${enrollmentname}
    \    Input Text    ${dict['EM Username Editable textbox']}    ${username}
    \    Input Password    ${dict['EM Password Editable textbox']}    ${password}
    \    Execute JavaScript    window.document.getElementsByClassName('cc-inline btn-group btn-block cc-ps-file-dropdown dropdown')[0].scrollIntoView()
    \    Click Element    ${dict['EM Connection File OPTIONS Label DropDown']}
    \    sleep    2
    \    Choose File    ${Browse_Conn_File_Button}    ${DATA_DIR}\\${connection_file}
    \    Click Element    ${dict['EM Connection File Upload a file Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Definition File OPTIONS Label DropDown']}
    \    sleep    2
    \    Click element    ${dict['EM Definition File Load Default Definition File Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Save And Execute Button']}
    \    Wait until page contains Element    ${dict['EM Done OK Button']}
    \    Click Element    ${dict['EM Done OK Button']}
    \    Sleep    2
    \    Click Element    ${dict['EM Create Task Back Arrow Button']}
    \    Wait until page contains Element    ${Eclipse_Button}
    \    Click Element    ${Eclipse_Button}
    \    Click Element    ${dict['EM Sync Button']}
    \    Wait until page contains Element    ${dict['EM Execute or Delete Button']}
    \    Click Element    ${dict['EM Execute or Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Success OK Button']}
    \    Click Element    ${dict['EM Success OK Button']}

Create LDAP Enrollment
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    6    7
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${taskname}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    ${enrollment_type}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${enrollmentname}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${connection_file}=    Read Cell Data By Name    ${worksheet}    H${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    K${i}
    \    ${Eclipse_Button}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    Go To    ${Home}/${Enrollment Management List}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['Enrollment Menu']}
    \    Click Element    ${dict['Enrollment Menu']}
    \    Wait until page contains Element    ${dict['EM Create Task Button']}
    \    Click Element    ${dict['EM Create Task Button']}
    \    Wait until page contains Element    ${dict['EM Task Name Editable textbox']}
    \    Input Text    ${dict['EM Task Name Editable textbox']}    ${taskname}
    \    Input Text    ${dict['EM Description Editable textbox']}    ${description}
    \    Click Element    ${dict['Enrollment Type Dropdown Select Textbox']}
    \    Click element    //*[@label="${enrollment_type}" and text()="${enrollment_type}"]
    \    Input Text    ${dict['EM Enrollment Name Editable textbox']}    ${enrollmentname}
    \    Input Text    ${dict['EM Username Editable textbox']}    ${username}
    \    Input Password    ${dict['EM Password Editable textbox']}    ${password}
    \    Execute JavaScript    window.document.getElementsByClassName('cc-inline btn-group btn-block cc-ps-file-dropdown dropdown')[0].scrollIntoView()
    \    Click Element    ${dict['EM Connection File OPTIONS Label DropDown']}
    \    sleep    2
    \    Choose File    ${Browse_Conn_File_Button}    ${DATA_DIR}\\${connection_file}
    \    Click Element    ${dict['EM Connection File Upload a file Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Definition File OPTIONS Label DropDown']}
    \    sleep    2
    \    Click element    ${dict['EM Definition File Load Default Definition File Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Save And Execute Button']}
    \    Wait until page contains Element    ${dict['EM Done OK Button']}
    \    Click Element    ${dict['EM Done OK Button']}
    \    Sleep    2
    \    Click Element    ${dict['EM Create Task Back Arrow Button']}
    \    Wait until page contains Element    ${Eclipse_Button}
    \    Click Element    ${Eclipse_Button}
    \    Click Element    ${dict['EM Sync Button']}
    \    Wait until page contains Element    ${dict['EM Execute or Delete Button']}
    \    Click Element    ${dict['EM Execute or Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Success OK Button']}
    \    Click Element    ${dict['EM Success OK Button']}

Create LDIF Enrollment
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    3    6
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${taskname}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    ${enrollment_type}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${enrollmentname}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${definition_file}=    Read Cell Data By Name    ${worksheet}    I${i}
    \    ${ldif_file}=    Read Cell Data By Name    ${worksheet}    J${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    K${i}
    \    ${Eclipse_Button}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    Go To    ${Home}/${Enrollment Management List}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['Enrollment Menu']}
    \    Click Element    ${dict['Enrollment Menu']}
    \    Wait until page contains Element    ${dict['EM Create Task Button']}
    \    Click Element    ${dict['EM Create Task Button']}
    \    Wait until page contains Element    ${dict['EM Task Name Editable textbox']}
    \    Input Text    ${dict['EM Task Name Editable textbox']}    ${taskname}
    \    Input Text    ${dict['EM Description Editable textbox']}    ${description}
    \    Click Element    ${dict['Enrollment Type Dropdown Select Textbox']}
    \    Click element    //*[@label="${enrollment_type}" and text()="${enrollment_type}"]
    \    Input Text    ${dict['EM Enrollment Name Editable textbox']}    ${enrollmentname}
    \    Input Text    ${dict['EM Username Editable textbox']}    ${username}
    \    Input Password    ${dict['EM Password Editable textbox']}    ${password}
    \    Execute JavaScript    window.document.getElementsByClassName('cc-inline btn-group btn-block cc-ps-file-dropdown dropdown')[0].scrollIntoView()
    \    Click Element    ${dict['EM Definition File OPTIONS Label DropDown']}
    \    sleep    2
    \    Choose File    ${Browse_Def_File_Button}    ${DATA_DIR}\\${definition_file}
    \    Click Element    ${dict['EM Definition File Upload a file Button']}
    \    sleep    2
    \    Click Element    ${dict['EM LDIF File Options Button']}
    \    sleep    2
    \    Choose File    ${Browse_LDIF_File_Button}    ${DATA_DIR}\\${ldif_file}
    \    Click Element    ${dict['EM LDIF File Upload Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Save And Execute Button']}
    \    Wait until page contains Element    ${dict['EM Done OK Button']}
    \    Click Element    ${dict['EM Done OK Button']}
    \    Sleep    2
    \    Click Element    ${dict['EM Create Task Back Arrow Button']}
    \    Wait until page contains Element    ${Eclipse_Button}
    \    Click Element    ${Eclipse_Button}
    \    Click Element    ${dict['EM Sync Button']}
    \    Wait until page contains Element    ${dict['EM Execute or Delete Button']}
    \    Click Element    ${dict['EM Execute or Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Success OK Button']}
    \    Click Element    ${dict['EM Success OK Button']}

Invalid Enrollment Username Or Password
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    12    18
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${taskname}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    ${enrollment_type}=    Read Cell Data By Name    ${worksheet}    D${i}
    \    ${enrollmentname}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    K${i}
    \    ${Eclipse_Button}=    Read Cell Data By Name    ${worksheet}    M${i}
    \    Go To    ${Home}/${Enrollment Management List}
    \    Maximize browser window
    \    Wait until page contains Element    ${dict['Enrollment Menu']}
    \    Click Element    ${dict['Enrollment Menu']}
    \    Wait until page contains Element    ${dict['EM Create Task Button']}
    \    Click Element    ${dict['EM Create Task Button']}
    \    Wait until page contains Element    ${dict['EM Task Name Editable textbox']}
    \    Input Text    ${dict['EM Task Name Editable textbox']}    ${taskname}
    \    Input Text    ${dict['EM Description Editable textbox']}    ${description}
    \    Click Element    ${dict['Enrollment Type Dropdown Select Textbox']}
    \    Click element    //*[@label="${enrollment_type}" and text()="${enrollment_type}"]
    \    Input Text    ${dict['EM Enrollment Name Editable textbox']}    ${enrollmentname}
    \    Input Text    ${dict['EM Username Editable textbox']}    ${username}
    \    Input Password    ${dict['EM Password Editable textbox']}    ${password}
    \    Execute JavaScript    window.document.getElementsByClassName('cc-inline btn-group btn-block cc-ps-file-dropdown dropdown')[0].scrollIntoView()
    \    Click Element    ${dict['EM Connection File OPTIONS Label DropDown']}
    \    sleep    2
    \    Click Element    ${dict['EM Connection File Load Default Connection File Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Definition File OPTIONS Label DropDown']}
    \    sleep    2
    \    Click element    ${dict['EM Definition File Load Default Definition File Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Save And Execute Button']}
    \    Wait until page contains Element    ${dict['EM Done OK Button']}
    \    Click Element    ${dict['EM Done OK Button']}
    \    Sleep    2
    \    Click Element    ${dict['EM Create Task Back Arrow Button']}
    \    Wait until page contains Element    ${Eclipse_Button}
    \    Click Element    ${Eclipse_Button}
    \    Click Element    ${dict['EM Sync Button']}
    \    Wait until page contains Element    ${dict['EM Execute or Delete Button']}
    \    Click Element    ${dict['EM Execute or Delete Button']}
    \    sleep    5
    \    Wait until page contains Element    ${dict['EM Success OK Button']}
    \    Click Element    ${dict['EM Success OK Button']}
