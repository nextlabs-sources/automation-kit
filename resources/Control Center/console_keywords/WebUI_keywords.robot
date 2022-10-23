*** Settings ***
Library           Selenium2Library
Library           Collections
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Variables         ${VAR_DIR}/common_variables.yaml
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml

*** Keywords ***
Set Browser Zoom
    [Arguments]    ${level}
    Execute Javascript    document.body.style.zoom="${level}%"

Javascript Xpath
    [Arguments]    ${xpath}    ${action}
    Execute Javascript    document.evaluate('${xpath}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.${action}
    Execute Javascript    document.evaluate('${xpath}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.dispatchEvent(new Event('change'))

Browser check
    Run Keyword If    '${browser}' == 'chrome'    chrome setup
    Run Keyword If    '${browser}' == 'firefox'    firefox setup
    Run Keyword If    '${browser}' == 'edge'    msedge setup

Checkbox Interact
    [Arguments]    ${xpath}    ${value}
    Execute Javascript    document.evaluate('${xpath}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.checked = ${value}
    Execute Javascript    document.evaluate('${xpath}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.dispatchEvent(new Event('change'))

Dropdown Select
    [Arguments]    ${xpath}    ${value}
    Execute Javascript    document.evaluate('${xpath}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.value=document.evaluate('${xpath}/option[@label="${value}"]',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.value
    Execute Javascript    document.evaluate('${xpath}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.dispatchEvent(new Event('change'))

chrome setup old
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    Open Browser    ${home}/${login link}    ${browser}    desired_capabilities=${dc}

chrome setup
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys, selenium.webdriver
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    ${prefs}    Create Dictionary    safebrowsing.enabled   ${True}
    #Set To Dictionary    ${prefs}   profile.default_content_settings.popups   ${0}
    #Set To Dictionary    ${prefs}   download.extensions_to_open   cer
    #Call Method    ${chrome_options}    add_argument    --safebrowsing-disable-download-protection
    #Call Method    ${chrome_options}    add_argument    --safebrowsing-disable-extension-blacklist
    #Call Method    ${chrome_options}    add_argument    --safebrowsing-manual-download-blacklist
    Call Method    ${chrome options}    add_experimental_option    prefs    ${prefs}
    Create WebDriver    ${browser.capitalize()}    desired_capabilities=${dc}    chrome_options=${chrome_options}
    Goto    ${home}/${login link}

firefox setup
    ${firefox_path}=    Evaluate    sys.modules['selenium.webdriver'].firefox.firefox_binary.FirefoxBinary(firefox_path="${firefox_binary}", log_file=None)    sys
    ${dc}=    Evaluate    sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX    sys
    Set To Dictionary    ${dc}    marionette    ${True}
    Create WebDriver    Firefox    firefox_binary=${firefox_path}    capabilities=${dc}
    Go To    ${home}/${login link}

msedge setup
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.EDGE    sys, selenium.webdriver
    Set To Dictionary    ${dc}    acceptSslCerts    ${True}
    Set To Dictionary    ${dc}    acceptInsecureCerts    ${True}
    Open Browser    ${home}/${login link}    ${browser}    desired_capabilities=${dc}

Sign In To Console
    [Documentation]    Signing into console
    Log To Console    Signing into console
    ${login link} =    Set Variable    ${Login Page}
    Set Suite Variable    ${login link}
    Run Keyword    Browser check
    Set Window Size    1920    1080
    Set Browser Zoom    100
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
    ${login link} =    Set Variable    ${Reporter Login Page}
    Set Suite Variable    ${login link}
    Run Keyword    Browser check
    Input Text    xpath=//*[@id="username"]    ${applicaiton_username}
    Input Password    xpath=//*[@id="password"]    ${application_password}
    Click Element    submit

Sign In To Administrator
    ${login link} =    Set Variable    ${Administrator Login Page}
    Set Suite Variable    ${login link}
    Run Keyword    Browser check
    Input Text    xpath=//*[@id="username"]    ${applicaiton_username}
    Input Password    xpath=//*[@id="password"]    ${application_password}
    click element    //*[@id="fm1"]/div[3]/input

Console Access
    Log To Console    Signing into console
    ${login link} =    Set Variable    ${Login Page}
    Set Suite Variable    ${login link}
    Run Keyword    Browser check
    Set Window Size    1920    1080
    Set Browser Zoom    100

Reporter Access
    ${login link} =    Set Variable    ${Reporter Login Page}
    Set Suite Variable    ${login link}
    Run Keyword    Browser check

Administrator Access
    ${login link} =    Set Variable    ${Administrator Login Page}
    Set Suite Variable    ${login link}
    Run Keyword    Browser check
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
    FOR    ${i}    IN RANGE    999999
    ${key}=    Read Cell Data By Coordinates    ${worksheet}    ${key_col}    ${row}
    ${value}=    Read Cell Data By Coordinates    ${worksheet}    ${xpath_col}    ${row}
    Exit For Loop If    "${key}" == ''
    Comment    Set To Dictionary    &{dict}    ${key}    ${value}
    ${row}=    Evaluate    ${row}+1
    [Return]    ${dict}
