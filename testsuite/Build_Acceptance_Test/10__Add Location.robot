*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        AddLocation
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
${worksheet}      Location_Manager
${xpath workbook}    Xpaths.xls    # \ ..\automation-kit\testdata\Control Center\Xpaths.xls
${xpath worksheet}    Enrollment

*** Test Cases ***
Add Locations
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Go To    ${Home}/${Enrollment Management List}
    Maximize browser window
    Wait until page contains Element    ${dict['Import Location Manager Menu']}
    Click Element    ${dict['Import Location Manager Menu']}
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${i}    IN RANGE    3    17
        ${locationname}=    Read Cell Data By Name    ${worksheet}    B${i}
        ${iprange}=    Read Cell Data By Name    ${worksheet}    C${i}
        Wait until page contains Element    ${dict['LM Add Location Button']}
        Click Link    ${dict['LM Add Location Button']}
        Wait Until Page contains Element    ${dict['LM Location Name Editable Texbox']}
        Input Text    ${dict['LM Location Name Editable Texbox']}    ${locationname}
        Input Text    ${dict['LM IP Range Editable Textbox']}    ${iprange}
        Click Element    ${dict['LM Add To Table Button']}
        Sleep    2
    END

Import Locations
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    40 seconds
    Go To    ${Home}/${Enrollment Management List}
    Maximize browser window
    Wait until page contains Element    ${dict['Import Location Manager Menu']}
    Click Element    ${dict['Import Location Manager Menu']}
    Click Element    ${dict['LM Import Button']}
    sleep    2
    Choose File    ${dict['LM Browse Button']}    ${DATA_DIR}\\Enrollment\\site enrollment.txt
    sleep    1
    Click Element    ${dict['LM Import Confirm Button']}
    sleep    2
    Click Element    ${dict['LM Import Success OK Button']}
    sleep    2

Adding Locations with Invalid IP Range
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
    Set Test Variable    ${dict}
    set selenium implicit wait    0 seconds
    Go To    ${Home}/${Enrollment Management List}
    Maximize browser window
    Wait until page contains Element    ${dict['Import Location Manager Menu']}
    Click Element    ${dict['Import Location Manager Menu']}
    Open Excel    ${DATA_DIR}/${workbook}
    FOR    ${i}    IN RANGE    31    36
        ${locationname}=    Read Cell Data By Name    ${worksheet}    B${i}
        ${iprange}=    Read Cell Data By Name    ${worksheet}    C${i}
        Wait until page contains Element    ${dict['LM Add Location Button']}
        Click Element    ${dict['LM Add Location Button']}
        Wait until page contains Element    ${dict['LM Location Name Editable Texbox']}
        Input Text    ${dict['LM Location Name Editable Texbox']}    ${locationname}
        Input Text    ${dict['LM IP Range Editable Textbox']}    ${iprange}
        Click Element    ${dict['LM Add To Table Button']}
        ${previous kw}=    Register Keyword To Run On Failure    NOTHING
        ${t1 present}=    Run Keyword And Return Status    Page Should Contain    Please enter valid ip/range
        Register Keyword To Run On Failure    ${previous kw}
        Run Keyword If    not ${t1 present}    Page Should Contain    Value is required
        sleep    2
        Reload Page
    END
