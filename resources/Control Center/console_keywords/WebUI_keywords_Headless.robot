*** Settings ***
Library           Selenium2Library
Library           Collections
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml

*** Keywords ***
Sign In To Console
    [Documentation]    Signing into console
    Log To Console    Signing into console
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    Open Browser    ${home}/${Login Page}    ${browser}    desired_capabilities=${dc}
    Input Text    xpath=//*[@id="username"]    ${applicaiton_username}
    Input Password    xpath=//*[@id="password"]    ${application_password}
    Click Element    submit

Generate ${n} Random Numbers Within ${min} And ${max}
    @{numbers}=    Evaluate    random.sample(range(${min}, ${max}), ${n})    random
    [Return]    @{numbers}

Generate A Random Number Within ${min} And ${max}
    ${number}=    Evaluate    random.randint(${min},${max})    random
    [Return]    ${number}

Sign In To Reporter
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    Open Browser    ${home}/${Reporter Login Page}    ${browser}    desired_capabilities=${dc}
    Input Text    xpath=//*[@id="username"]    ${applicaiton_username}
    Input Password    xpath=//*[@id="password"]    ${application_password}
    Click Element    submit

Sign In To Administrator
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    Open Browser    ${home}/${Administrator_Login_Page}    ${browser}    desired_capabilities=${dc}
    maximize browser window
    Input Text    xpath=//*[@id="username"]    ${applicaiton_username}
    Input Password    xpath=//*[@id="password"]    ${application_password}
    click element    //*[@id="fm1"]/div[3]/input

Console Access
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --acceptSslCerts
    Call Method    ${chrome_options}    add_argument    --disable-software-rasterizer
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Set Window Size    ${1800}    ${1200}
    Go To    ${home}/${Login Page}

Reporter Access
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    Open Browser    ${home}/${Reporter Login Page}    ${browser}    desired_capabilities=${dc}

Administrator Access
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    open Browser    ${home}/${Administrator_Login_Page}    ${browser}    desired_capabilities=${dc}
    Comment    Click Element    //*[@id="details-button"]
    Comment    Click Element    //*[@id="proceed-link"]

xpaths
    [Arguments]    ${workbook}    ${worksheet}    ${firstCol}=1    ${firstRow}=2
    [Documentation]    Reading excel file
    &{dict}=    Create Dictionary
    ${row}=    Set Variable    ${firstRow}
    ${key_col}=    Set Variable    ${firstCol}
    ${xpath_col}=    Evaluate    ${key_col}+1
    Set To Dictionary    &{dict}    key1    value2
    Open Excel    ${workbook}
    : FOR    ${i}    IN RANGE    999999
    \    ${key}=    Read Cell Data By Coordinates    ${worksheet}    ${key_col}    ${row}
    \    ${value}=    Read Cell Data By Coordinates    ${worksheet}    ${xpath_col}    ${row}
    \    Exit For Loop If    "${key}" == ''
    \    Comment    Set To Dictionary    &{dict}    ${key}    ${value}
    \    ${row}=    Evaluate    ${row}+1
    [Return]    ${dict}
