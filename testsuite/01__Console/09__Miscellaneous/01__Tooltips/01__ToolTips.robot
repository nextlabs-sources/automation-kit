*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        ToolTips
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary

*** Variables ***
${xpath workbook}    Xpaths.xls

*** Test Cases ***
Policies_Creation_page
    ${xpath worksheet}=    Evaluate    'ToolTip_Policy_Creation'
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${Name_Tooltip}=    Read Cell Data By Name    ${xpath worksheet}    B2
    ${Name_Tooltip_Popup}=    Read Cell Data By Name    ${xpath worksheet}    B3
    ${Name_text}    Read Cell Data By Name    ${xpath worksheet}    C3
    ${Description_Tooltip}=    Read Cell Data By Name    ${xpath worksheet}    B4
    ${Description_Tooltip_Popup}=    Read Cell Data By Name    ${xpath worksheet}    B5
    ${Description_text}    Read Cell Data By Name    ${xpath worksheet}    C5
    Go To    ${Home}/${Create Policy Page}
    Maximize Browser Window
    Click Element    ${Name_Tooltip}
    Wait until page contains Element    ${Name_Tooltip_Popup}
    ${Name}=    Get Text    ${Name_Tooltip_Popup}
    ${Name}=    Convert to string    ${Name}
    ${Name_text_1}=    Convert to string    ${Name_text}
    Should Be Equal    ${Name_text_1}    ${Name_text}
    Click Element    ${Description_Tooltip}
    Wait until page contains Element    ${Description_Tooltip_Popup}
    ${Description}=    Get Text    ${Description_Tooltip_Popup}
    #sleep    6000
    ${Description}=    Convert to string    ${Description}
    ${Description_text_1}=    Convert to string    ${Description_text}
    Should Be Equal    ${Description}    ${Description_text}
