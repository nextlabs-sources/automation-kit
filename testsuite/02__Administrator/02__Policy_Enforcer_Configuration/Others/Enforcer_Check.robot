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
${workbook}       PolicyEnforcerConfig.xls
${Title On Page}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgTitleIn"]
${ICENet On Page}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:profileBrokerURLMenu"]
${Heartbeat On Page}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgHBFrqIn"]
${Frequen On Page}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgHBFrqTmUnt"]
${Audit On Page}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgUplFrqIn"]
${Log On page}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgUplFrqTmUnt"]
${Logsize On Page}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:cfgLgSzIn"]
${Push Status}    //*[@id="agentConfigDefinitionSubview:contentSubview:agentConfigForm:agentConfigSettingTabBody:pushck"]
${worksheet desktop}    Desktop enforcer profile
${worksheet fileserver}    File server profile
${worksheet portal}    Portal Enforcer profile

*** Test Cases ***
Default desktop enforcer check
    click link    Policy Enforcer Configuration    #switch to the policy enforcer config page
    open excel    ${DATA_DIR}/${workbook}
    ${excelrow}    get row count    ${worksheet desktop}
    : FOR    ${row}    IN RANGE    2    ${excelrow}+1
    \    ${title}    read cell data by name    ${worksheet desktop}    A${row}
    \    ${ICENet}    read cell data by name    ${worksheet desktop}    B${row}
    \    ${hearbeat}    read cell data by name    ${worksheet desktop}    C${row}
    \    ${Hearbeat Frequency}    read cell data by name    ${worksheet desktop}    D${row}
    \    ${Audit LOG}    read cell data by name    ${worksheet desktop}    E${row}
    \    ${Log Frequency}    read cell data by name    ${worksheet desktop}    F${row}
    \    ${Log size}    read cell data by name    ${worksheet desktop}    G${row}
    \    ${push}    read cell data by name    ${worksheet desktop}    H${row}
    \    ${titlefrompage}    get value    ${Title On Page}    # get the tile from page
    \    ${ICENetfrompage}    get text    ${ICENet On Page}
    \    ${stripICENet}    strip string    ${ICENetfrompage}
    \    ${hearbeatfrompage}    get value    ${Heartbeat On Page}
    \    ${hearbeat}    Convert To Integer    ${hearbeat}    # covert the number to int type
    \    ${Audit LOG}    Convert To Integer    ${Audit LOG}
    \    ${Log size}    Convert To Integer    ${Log size}
    \    ${Hearbeat Frequencyfrompage}    get selected list value    ${Frequen On Page}
    \    ${Audit LOGfrompage}    get value    ${Audit On Page}
    \    ${Log Frequencyfrompage}    get selected list value    ${Log On page}
    \    ${Log sizefrompage}    get value    ${Logsize On Page}
    \    should be equal    ${title}    ${titlefrompage}
    \    should match    ${hearbeat}${Hearbeat Frequency}    ${hearbeatfrompage}${Hearbeat Frequencyfrompage}
    \    should match    ${ICENet}    ${stripICENet}
    \    should match    ${Audit LOG}${Log Frequency}    ${Audit LOGfrompage}${Log Frequencyfrompage}
    \    #    should match    ${Log size}    ${Log sizefrompage}
    \    run key word if    "${push}"=="disable"    check push

Default file server enforcer check
    click link    Policy Enforcer Configuration    #switch to the policy enforcer config page
    click link    File Server Enforcer
    open excel    ${DATA_DIR}/${workbook}
    ${excelrow}    get row count    ${worksheet fileserver}
    : FOR    ${row}    IN RANGE    2    ${excelrow}+1
    \    ${title}    read cell data by name    ${worksheet fileserver}    A${row}
    \    ${ICENet}    read cell data by name    ${worksheet fileserver}    B${row}
    \    ${hearbeat}    read cell data by name    ${worksheet fileserver}    C${row}
    \    ${Hearbeat Frequency}    read cell data by name    ${worksheet fileserver}    D${row}
    \    ${Audit LOG}    read cell data by name    ${worksheet fileserver}    E${row}
    \    ${Log Frequency}    read cell data by name    ${worksheet fileserver}    F${row}
    \    ${Log size}    read cell data by name    ${worksheet fileserver}    G${row}
    \    ${push}    read cell data by name    ${worksheet fileserver}    H${row}
    \    log    ${title}
    \    ${titlefrompage}    get value    ${Title On Page}    # get the tile from page
    \    ${ICENetfrompage}    get text    ${ICENet On Page}
    \    ${stripICENet}    strip string    ${ICENetfrompage}
    \    ${hearbeatfrompage}    get value    ${Heartbeat On Page}
    \    ${hearbeat}    Convert To Integer    ${hearbeat}    # covert the number to int type
    \    ${Audit LOG}    convert to integer    ${Audit LOG}
    \    ${Log size}    convert to integer    ${Log size}
    \    ${Hearbeat Frequencyfrompage}    get selected list value    ${Frequen On Page}
    \    ${Audit LOGfrompage}    get value    ${Audit On Page}
    \    ${Log Frequencyfrompage}    get selected list value    ${Log On page}
    \    ${Log sizefrompage}    get value    ${Logsize On Page}
    \    should be equal    ${title}    ${titlefrompage}
    \    should match    ${hearbeat}${Hearbeat Frequency}    ${hearbeatfrompage}${Hearbeat Frequencyfrompage}
    \    should match    ${ICENet}    ${stripICENet}
    \    should match    ${Audit LOG}${Log Frequency}    ${Audit LOGfrompage}${Log Frequencyfrompage}
    \    #    should match    ${Log size}    ${Log sizefrompage}
    \    run key word if    "${push}"=="disable"    check push

Default portal enforcer check
    click link    Policy Enforcer Configuration    #switch to the policy enforcer config page
    click link    Portal Enforcer
    open excel    ${DATA_DIR}/${workbook}
    ${excelrow}    get row count    ${worksheet portal}
    : FOR    ${row}    IN RANGE    2    ${excelrow}+1
    \    ${title}    read cell data by name    ${worksheet portal}    A${row}
    \    ${ICENet}    read cell data by name    ${worksheet portal}    B${row}
    \    ${hearbeat}    read cell data by name    ${worksheet portal}    C${row}
    \    ${Hearbeat Frequency}    read cell data by name    ${worksheet portal}    D${row}
    \    ${Audit LOG}    read cell data by name    ${worksheet portal}    E${row}
    \    ${Log Frequency}    read cell data by name    ${worksheet portal}    F${row}
    \    ${Log size}    read cell data by name    ${worksheet portal}    G${row}
    \    ${push}    read cell data by name    ${worksheet portal}    H${row}
    \    ${titlefrompage}    get value    ${Title On Page}    # get the tile from page
    \    ${ICENetfrompage}    get text    ${ICENet On Page}
    \    ${stripICENet}    strip string    ${ICENetfrompage}
    \    ${hearbeatfrompage}    get value    ${Heartbeat On Page}
    \    ${hearbeat}    Convert To Integer    ${hearbeat}    # covert the number to int type
    \    ${Audit LOG}    convert to integer    ${Audit LOG}
    \    ${Log size}    convert to integer    ${Log size}
    \    ${Hearbeat Frequencyfrompage}    get selected list value    ${Frequen On Page}
    \    ${Audit LOGfrompage}    get value    ${Audit On Page}
    \    ${Log Frequencyfrompage}    get selected list value    ${Log On page}
    \    ${Log sizefrompage}    get value    ${Logsize On Page}
    \    should be equal    ${title}    ${titlefrompage}
    \    should match    ${hearbeat}${Hearbeat Frequency}    ${hearbeatfrompage}${Hearbeat Frequencyfrompage}
    \    should match    ${ICENet}    ${stripICENet}
    \    should match    ${Audit LOG}${Log Frequency}    ${Audit LOGfrompage}${Log Frequencyfrompage}
    \    #    should match    ${Log size}    ${Log sizefrompage}
    \    run key word if    "${push}"=="disable"    check push

*** Keywords ***
check push
    checkbox should not be selected    ${Push Status}
