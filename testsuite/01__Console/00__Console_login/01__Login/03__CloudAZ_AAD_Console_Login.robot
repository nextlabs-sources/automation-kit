*** Settings ***
Suite Teardown    Close Browser
Force Tags        AADLogin
Default Tags
Library           Selenium2Library
Library           String
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           OperatingSystem
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary    #Library    DatabaseLibrary
Library           ${LIB_DIR}/ExcelUtil.py

*** Variables ***

*** Test Cases ***
CloudAZ_AAD_Login
    [Tags]    AAD_Login
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    Open Browser    https://www.cloudaz.com/#/home    chrome    desired_capabilities=${dc}
    Set Selenium Timeout    20 seconds
    Maximize browser window
    Click Element    //*[@class="cloudaz-signup-button" and text()="Login"]    # Login Button
    ${tab1}=    Select Window    NEW    #Navigate to Login page Tab
    Maximize browser window
    Set Selenium Timeout    20 seconds
    ${IsElementVisible}=    Run Keyword And Return Status    Page Should Contain Element    //*[@id="otherTileText"]
    Run Keyword If    ${IsElementVisible}    Click Element    //*[@id="otherTileText"]    #Use another Account Button
    Input Text    //*[@id="i0116"]    qaauto@azure.cloudaz.net    #Username Value
    Click Element    //*[@id="idSIButton9"]    #Next Button
    Input Password    //*[@id="i0118"]    Daku5947    # Password Value
    sleep    2
    Click Element    //*[@id="idSIButton9"]
    ${IsElementVisible}=    Run Keyword And Return Status    Page Should Contain Element    //*[@id="KmsiCheckboxField"]
    Run Keyword If    ${IsElementVisible}    Click Element    //*[@id="KmsiCheckboxField"]    #Don't Show this again "yes" Checkbox
    Click Element    //*[@id="idSIButton9"]    # Yes Button
    sleep    2
    Click Element    //*[@class="fa fa-angle-down"]    #Dropdown Arrow Button for Logout
    Wait until page contains element    //*[@class="form-control btn btn-default cc-logout-btn ng-binding"]    # Logout Button
    Click Element    //*[@class="form-control btn btn-default cc-logout-btn ng-binding"]    #Logout Button
