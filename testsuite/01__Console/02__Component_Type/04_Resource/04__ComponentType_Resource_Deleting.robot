*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Force Tags        ComponentTypeResource    Build_Acceptance
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           OperatingSystem
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***
${xpath workbook}    Xpaths.xls
${xpath worksheet}    Policy Model

*** Test Cases ***
Delete First Resource Component Type from list
    [Documentation]    Edit name and set it to empty.
    ...
    ...    Expected Result: should not be allowed to be saved.
    Open Excel    ${DATA_DIR}/${xpath workbook}
    ${dict}=    Read Excel File    ${DATA_DIR}/${xpath workbook}    ${xpath worksheet}
	set selenium implicit wait    10 seconds
    Go To    ${Home}/${List Policy Model Page}
    ${newName}=    Generate Random String    10
    Maximize Browser Window
    Wait Until Page Contains Element    ${dict['Fourth Resource PM From List']}
    Page Should Contain Element    ${dict['Fourth Resource PM From List']}
    Wait Until Page Contains Element    ${dict['Ellipse Button Of Fourth PM In List']}    #ellipse button of 4th policy model in the list
    Click Element    ${dict['Ellipse Button Of Fourth PM In List']}
    Wait Until Page Contains Element    ${dict['Delete Button From Ellipse']}
    Click Element    ${dict['Delete Button From Ellipse']}
    Wait Until Page Contains Element    ${dict['Conformation Of deleting Resource Component Type']}
    Click Element    ${dict['Conformation Of deleting Resource Component Type']}
    Sleep    2
    Page Should Contain Element    ${dict['Dialouge Box Conformation']}
