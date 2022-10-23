*** Settings ***
Suite Setup       Sign In To Administrator
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    Administrator
Library           Selenium2Library
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Resource          ${VAR_DIR}/console_variables/WebUI_variables.yaml
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary
Library           OperatingSystem
Library           String

*** Variables ***
${Exist Policy List}    //*[@id="lstTblDv"]/table/tbody/tr[not(@class="datatableseparator")]/td
${Random}         //*[@id="agentConfigDefinitionSubview:contentSubview:lstTblFrm:profilelist
${Frequency}      //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgHBFrqTmUnt"]
${Save Button}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:cfgSavBtn"]
${Reset Button}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:cfgRstBtn"]
${message}        Your changes were saved successfully

*** Test Cases ***
Edit exist Desktop policy
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    ${row}    get webelements    ${Exist Policy List}
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random policy}    set variable    ${Random}:${randomnumber}:slcrdPrfLnk"]
    click element    ${Random Policy}
    select from list by value    ${Frequency}    days    #modify the frequency to minutes
    click element    ${Save Button}    #save the new policy
    page should contain    ${message}

Edit exist File Server policy
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    click link    File Server Enforcer
    ${row}    get webelements    ${Exist Policy List}
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random policy}    set variable    ${Random}:${randomnumber}:slcrdPrfLnk"]
    click element    ${Random Policy}
    select from list by value    ${Frequency}    hours    #modify the frequency to minutes
    click element    ${Save Button}    #save the new policy
    page should contain    ${message}

Edit exist Portal policy
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    click link    Portal Enforcer
    ${row}    get webelements    ${Exist Policy List}
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random policy}    set variable    ${Random}:${randomnumber}:slcrdPrfLnk"]
    click element    ${Random Policy}
    select from list by value    ${Frequency}    hours    #modify the frequency to minutes
    click element    ${Save Button}    #save the new policy
    page should contain    ${message}

cancel edit policy
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    ${row}    get webelements    ${Exist Policy List}
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random policy}    set variable    ${Random}:${randomnumber}:slcrdPrfLnk"]
    click element    ${Random Policy}
    ${beforechange}    get selected list value    ${Frequency}
    select from list by value    ${Frequency}    minutes    #modify the frequency to minutes
    click element    ${Reset Button}    #reset the modify
    ${afterchange}    get selected list value    ${Frequency}
    should be equal    ${beforechange}    ${afterchange}
