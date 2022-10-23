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
${Delete Button}    //*[@id="agentConfigDefinitionSubview:contentSubview:prfAddDelFrm:prfDelBtn"]
${Save Button}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:cfgSavBtn"]
${Delete Confirm}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:delConfDelBtn"]

*** Test Cases ***
Delete File Server Policy
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    click link    File Server Enforcer
    ${row}    get webelements    ${Exist Policy List}
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random policy}    set variable    ${Random}:${randomnumber}:slcrdPrfLnk"]
    click element    ${Random Policy}    #click the random policy
    click element    ${Delete Button}    #delete the selected policy
    Sleep    3
    click element    ${Delete Confirm}
    click link    File Server Enforcer    #after confirm delete the policy, the page will direct to the default page, so need redirect to the file server page
    ${deleterow}    get webelements    ${Exist Policy List}
    ${deleterowcount}    get length    ${deleterow}
    ${resultcount}    evaluate    ${rowcount}-1
    should be equal    ${deleterowcount}    ${resultcount}

Delete Portal Policy
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    click link    Portal Enforcer
    ${row}    get webelements    ${Exist Policy List}
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(0,${rowcount}-1)    random
    ${Random policy}    set variable    ${Random}:${randomnumber}:slcrdPrfLnk"]
    click element    ${Random Policy}    #click the random policy
    click element    ${Delete Button}    #delete the selected policy
    click element    ${Delete Confirm}
    click link    Portal Enforcer
    ${deleterow}    get webelements    ${Exist Policy List}
    ${deleterowcount}    get length    ${deleterow}
    ${resultcount}    evaluate    ${rowcount}-1
    should be equal    ${deleterowcount}    ${resultcount}

Delete Desktop Policy
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    ${row}    get webelements    ${Exist Policy List}
    ${rowcount}    get length    ${row}
    ${randomnumber}    evaluate    random.randint(1,${rowcount}-1)    random
    ${Random policy}    set variable    ${Random}:${randomnumber}:slcrdPrfLnk"]
    click element    ${Random Policy}    #click the random policy
    click element    ${Delete Button}    #delete the selected policy
    click element    ${Delete Confirm}
    ${deleterow}    get webelements    ${Exist Policy List}
    ${deleterowcount}    get length    ${deleterow}
    ${resultcount}    evaluate    ${rowcount}-1
    should be equal    ${deleterowcount}    ${resultcount}
