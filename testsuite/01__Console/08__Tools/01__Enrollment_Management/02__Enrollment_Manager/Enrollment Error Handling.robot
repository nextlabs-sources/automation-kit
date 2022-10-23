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
${Browse_Button}    //input[@id="input-task-fileUpload-connection-file"]

*** Test Cases ***
Error handling missing Values Enrollment
    ${xpath worksheet}=    Evaluate    'Enrollment'
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    set selenium implicit wait    40 seconds
    Open Excel    ${DATA_DIR}/${xpath workbook}
    : FOR    ${i}    IN RANGE    20    26
    \    Open Excel    ${DATA_DIR}/${workbook}
    \    ${taskname}=    Read Cell Data By Name    ${worksheet}    B${i}
    \    ${description}=    Read Cell Data By Name    ${worksheet}    C${i}
    \    ${enrollmentname}=    Read Cell Data By Name    ${worksheet}    E${i}
    \    ${username}=    Read Cell Data By Name    ${worksheet}    F${i}
    \    ${password}=    Read Cell Data By Name    ${worksheet}    G${i}
    \    ${result}=    Read Cell Data By Name    ${worksheet}    H${i}
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
    \    Click element    //*[@label="Azure" and text()="Azure"]
    \    Input Text    ${dict['EM Enrollment Name Editable textbox']}    ${enrollmentname}
    \    Input Text    ${dict['EM Username Editable textbox']}    ${username}
    \    Input Password    ${dict['EM Password Editable textbox']}    ${password}
    \    Execute JavaScript    window.document.getElementsByClassName('cc-inline btn-group btn-block cc-ps-file-dropdown dropdown')[0].scrollIntoView()
    \    Click Element    ${dict['EM Connection File OPTIONS Label DropDown']}
    \    sleep    2
    \    Choose File    ${Browse_Button}    ${DATA_DIR}\\Enrollment\\azure.sample.default.conn
    \    Click Element    ${dict['EM Connection File Upload a file Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Definition File OPTIONS Label DropDown']}
    \    sleep    2
    \    Click element    ${dict['EM Definition File Load Default Definition File Button']}
    \    sleep    2
    \    Click Element    ${dict['EM Save And Execute Button']}
    Run Keyword If    '${result}'=='Fail'    Adding user source Should Fail
    Run Keyword If    '${result}'=='Pass'    Adding user source Should Succeed

*** Keywords ***
Adding user source Should Fail
    Page Should Contain    mandatory
