*** Settings ***
Suite Setup       Sign In To Console
Suite Teardown    Close Browser
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           Collections
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***

*** Test Cases ***
Cert Export
    Click Element    //a[@id='menu-certificate']/div[2]
    Sleep    2
    Click Element    //div[@id='certificateManager']/div
    Sleep    2
    Click Element    //i[@id='export-agent-truststore-agent']
    Sleep    5
