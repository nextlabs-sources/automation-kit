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
Library           yaml

*** Variables ***
${workbook}       PolicyEnforcerConfig.xls
${New}            //*[@id="agentConfigDefinitionSubview:contentSubview:prfAddDelFrm:prfAddBtn"]
${Password Button}    //*[@id="agntCnfFrmDv"]/div/div[2]/table[2]/tbody/tr[1]/td[2]/input
${Heartbeat Input}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgHBFrqIn"]
${Audit Log Input}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgUplFrqIn"]
${Max Log Input}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgLgSzIn"]
${ConfirmPassword Button}    //*[@id="agntCnfFrmDv"]/div/div[2]/table[2]/tbody/tr[2]/td[2]/input
${Save Button}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:cfgSavBtn"]
${Title Input}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgTitleIn"]
${Push Status}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:pushck"]
${Frequency}      //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgHBFrqTmUnt"]
${Exist Policy List}    //*[@id="lstTblDv"]/table/tbody/tr[not(@class="datatableseparator")]/td
${cancel button}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:cfgCnclBtn"]
${Reset Button}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:cfgRstBtn"]
${worksheet desktop}    create desktop enforcer
${worksheet fileserver}    create file server enforcer
${worksheet portal}    create portal enforcer

*** Test Cases ***
Create Desktop Enforcer
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    open excel    ${DATA_DIR}/${workbook}
    ${excelrow}    get row count    ${worksheet desktop}
    : FOR    ${row}    IN RANGE    2    ${excelrow}+1
    \    ${randomnumber}    evaluate    random.randint(1,10)    random
    \    ${title}    read cell data by name    ${worksheet desktop}    A${row}
    \    ${Hearbeat Frequency}    read cell data by name    ${worksheet desktop}    B${row}
    \    ${Log Frequency}    read cell data by name    ${worksheet desktop}    C${row}
    \    ${push}    read cell data by name    ${worksheet desktop}    D${row}
    \    ${password}    read cell data by name    ${worksheet desktop}    E${row}
    \    ${confirmpassword}    read cell data by name    ${worksheet desktop}    F${row}
    \    click element    ${New}    #click "new" button to create a new policy
    \    clear element text    ${Title Input}
    \    input text    ${Title Input}    ${title}
    \    input text    ${Heartbeat Input}    ${randomnumber}    #input the hearbeat frequency
    \    run keyword if    "${Hearbeat Frequency}"=="seconds"    Hearbeat frenquency
    \    run keyword if    "${Hearbeat Frequency}"=="hours"    Hearbeat frenquency-hours
    \    input text    ${Audit Log Input}    ${randomnumber}
    \    input text    ${Max Log Input}    ${randomnumber}
    \    input text    ${Password Button}    ${password}
    \    input text    ${ConfirmPassword Button}    ${confirmpassword}
    \    run keyword if    "${push}"=="disable"    unselect the push
    \    click element    ${Save Button}    #save the new policy

Create File Server Enforcer
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    click link    File Server Enforcer
    open excel    ${DATA_DIR}/${workbook}
    ${excelrow}    get row count    ${worksheet fileserver}
    : FOR    ${row}    IN RANGE    2    ${excelrow}+1
    \    ${randomnumber}    evaluate    random.randint(1,10)    random
    \    ${title}    read cell data by name    ${worksheet fileserver}    A${row}
    \    ${Hearbeat Frequency}    read cell data by name    ${worksheet fileserver}    B${row}
    \    ${Log Frequency}    read cell data by name    ${worksheet fileserver}    C${row}
    \    ${push}    read cell data by name    ${worksheet fileserver}    D${row}
    \    ${password}    read cell data by name    ${worksheet fileserver}    E${row}
    \    ${confirmpassword}    read cell data by name    ${worksheet fileserver}    F${row}
    \    click element    ${New}    #click "new" button to create a new policy
    \    clear element text    ${Title Input}
    \    input text    ${Title Input}    ${title}
    \    input text    ${Heartbeat Input}    ${randomnumber}    #input the hearbeat frequency
    \    run keyword if    "${Hearbeat Frequency}"=="seconds"    Hearbeat frenquency
    \    run keyword if    "${Hearbeat Frequency}"=="hours"    Hearbeat frenquency-hours
    \    input text    ${Audit Log Input}    ${randomnumber}
    \    input text    ${Max Log Input}    ${randomnumber}
    \    input text    ${Password Button}    ${password}
    \    input text    ${ConfirmPassword Button}    ${confirmpassword}
    \    run keyword if    "${push}"=="disable"    unselect the push
    \    click element    ${Save Button}    #save the new policy

Create Portal Enforcer
    click link    Policy Enforcer Configuration    #switch to the Policy config page
    click link    Portal Enforcer
    open excel    ${DATA_DIR}/${workbook}
    ${excelrow}    get row count    ${worksheet portal}
    : FOR    ${row}    IN RANGE    2    ${excelrow}+1
    \    ${randomnumber}    evaluate    random.randint(1,10)    random
    \    ${title}    read cell data by name    ${worksheet portal}    A${row}
    \    ${Hearbeat Frequency}    read cell data by name    ${worksheet portal}    B${row}
    \    ${Log Frequency}    read cell data by name    ${worksheet portal}    C${row}
    \    ${push}    read cell data by name    ${worksheet portal}    D${row}
    \    ${password}    read cell data by name    ${worksheet portal}    E${row}
    \    ${confirmpassword}    read cell data by name    ${worksheet portal}    F${row}
    \    click element    ${New}    #click "new" button to create a new policy
    \    clear element text    ${Title Input}
    \    input text    ${Title Input}    ${title}
    \    input text    ${Heartbeat Input}    ${randomnumber}    #input the hearbeat frequency
    \    run keyword if    "${Hearbeat Frequency}"=="seconds"    Hearbeat frenquency
    \    run keyword if    "${Hearbeat Frequency}"=="hours"    Hearbeat frenquency-hours
    \    input text    ${Audit Log Input}    ${randomnumber}
    \    input text    ${Max Log Input}    ${randomnumber}
    \    input text    ${Password Button}    ${password}
    \    input text    ${ConfirmPassword Button}    ${confirmpassword}
    \    run keyword if    "${push}"=="disable"    unselect the push
    \    click element    ${Save Button}    #save the new policy

cancel add profile
    click link    Policy Enforcer Configuration
    ${row}    get webelements    ${Exist Policy List}
    ${BeforeList}    get length    ${row}
    click element    ${New}    #go to the policy enforcer config page to add new profile
    click element    ${cancel button}    #cancel add new profile
    ${row}    get webelements    ${Exist Policy List}
    ${AfterList}    get length    ${row}
    should be equal    ${BeforeList}    ${AfterList}

Reset
    click link    Policy Enforcer Configuration
    click element    ${New}
    ${Before}    get value    ${Heartbeat Input}
    input text    ${Heartbeat Input}    22
    click element    ${Reset Button}    #reset the operation
    ${after}    get value    ${Heartbeat Input}
    should be equal    ${Before}    ${after}

*** Keywords ***
unselect the push
    unselect checkbox    ${Push Status}

Hearbeat frenquency
    select from list by label    ${Frequency}    days

Hearbeat frenquency-hours
    select from list by label    ${Frequency}    hours
