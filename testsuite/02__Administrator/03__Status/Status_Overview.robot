*** Settings ***
Suite Setup       Sign In To Administrator
Suite Teardown    Close Browser
Force Tags        priority/1    severity/critical    type/sanity    mode/full    WebUI    Administrator
Library           Selenium2Library
Variables         ${VAR_DIR}/console_variables/WebUI_variables.yaml
Variables         ${VAR_DIR}/common_variables.yaml
Resource          ${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           String
Library           OperatingSystem
Library           ExcelLibrary.ExcelLibrary.ExcelLibrary

*** Variables ***
${pc hostname}    win
${workbook1}      Console_Administration_reports_tools.xls
${system status}    //*[@id="statusOverviewDefinitionSubview:contentSubview:stsBxTtleTxt"]
${System Statistics}    //*[@id="statusOverviewDefinitionSubview:contentSubview:srvrStatsTtleLbl"]
${Server Status}    //*[@id="statusOverviewDefinitionSubview:contentSubview:srvrStatsTtleLbl"]
${CheckBoxOnStatus}    //*[@id="statusByHostDefinitionSubview:contentSubview:_id10"]/table/tbody/tr[3]/td/input
${Policy Enforcer Status List}    //*[@id="statusByHostDefinitionSubview:contentSubview:stsTblDv:statustable:0"]/tbody[2]/tr
${username}       //*[@id="username"]
${password button}    //*[@id="password"]
${Login Button}    //*[@id="fm1"]/div[3]/input
${Login user}     //*[@id="statusOverviewDefinitionSubview:headerSubview:usrInfoFrm:usrNmTxt"]
${version}        //*[@id="statusOverviewDefinitionSubview:headerSubview:versionTest"]
${Logout Button}    //*[@id="statusOverviewDefinitionSubview:headerSubview:usrInfoFrm:lgoutLnk"]
${Warning checkbox}    //*[@id="statusByHostDefinitionSubview:contentSubview:_id10"]/table/tbody/tr[3]/td/input
${Search input}    //*[@id="statusByHostDefinitionSubview:contentSubview:srchBxFrm:searchBox"]
${Search Button}    //*[@id="statusByHostDefinitionSubview:contentSubview:srchBxFrm:srchBtn"]
${Host column}    //*[@id="statusByHostDefinitionSubview:contentSubview:stsTblDv:statustable:0"]/tbody[2]
${Old Password Button}    //*[@id="changePasswordDefinitionSubview:contentSubview:changePasswordForm:oldPwrdInTxt"]
${New Password Button}    //*[@id="changePasswordDefinitionSubview:contentSubview:changePasswordForm:newPwrdInTxt"]
${Confirm Button}    //*[@id="changePasswordDefinitionSubview:contentSubview:changePasswordForm:newConfirmPwrdInTxt"]
${Change Button}    //*[@id="changePasswordDefinitionSubview:contentSubview:changePasswordForm:chngBtn"]
${reason}         //*[@class="reason"]

*** Test Cases ***
Status Overview
    page should contain element    ${system status}    #check the webpage section
    page should contain element    ${System Statistics}
    page should contain element    ${Server Status}
    capture page screenshot    administrator status.png

Display current Policy Enforcer Status
    click link    Policy Enforcer Status    #switch to the policy enforcer status page
    unselect checkbox    ${CheckBoxOnStatus}    #display all enforcers
    capture page screenshot    all policy enforcer status.png

Search policy host
    click link    Policy Enforcer Status
    unselect checkbox    ${Warning checkbox}    #unselect the checkbox
    input text    ${Search input}    ${pc hostname}    #input the search text
    click button    ${Search Button}    #click the search button
    ${status}    ${content}    run keyword and ignore error    page should \ contain    - No Records Found -
    log    ${status}
    run keyword if    "${status}"=="FAIL"    search result

check login user
    maximize browser window
    open excel    ${DATA_DIR}/${workbook1}
    ${excelrow}    get row count    login user check
    : FOR    ${row}    IN RANGE    2    ${excelrow}-1
    \    ${name}    read cell data by name    login user check    A${row}
    \    ${version}    read cell data by name    login user check    B${row}
    \    ${password}    read cell data by name    login user check    C${row}
    \    click link    Policy Enforcer Status
    \    click link    Status Overview
    \    ${loginuser}    get text    ${Login user}
    \    #    ${pageversion}    get text    ${version}
    \    should be equal    ${name}    ${loginuser}
    \    #    should be equal    ${version}    ${pageversion}
    \    click element    ${Logout Button}    #logout page and switch other user to login

change password
    click link    change password
    open excel    ${DATA_DIR}/${workbook1}
    ${excelrow}    get row count    change password
    : FOR    ${row}    IN RANGE    2    ${excelrow}-4
    \    ${oldpassword}    read cell data by name    change password    B${row}
    \    ${newpassword}    read cell data by name    change password    C${row}
    \    ${confirmpassword}    read cell data by name    change password    D${row}
    \    ${description}    read cell data by name    change password    F${row}
    \    input text    ${Old Password Button}    ${oldpassword}
    \    input text    ${New Password Button}    ${newpassword}
    \    input text    ${Confirm Button}    ${confirmpassword}
    \    click button    ${Change Button}
    \    ${actualresult}    get text    ${reason}
    \    should be equal    ${description}    ${actualresult}
    [Teardown]

*** Keywords ***
search result
    ${row}    get webelements    ${Policy Enforcer Status List}
    ${rowcount}    get length    ${row}
    : FOR    ${eachcount}    IN RANGE    1    ${rowcount}+1
    \    ${searchedhost}    get text    ${Host column}/tr[${eachcount}]/td[2]/span
    \    log    ${searchedhost}
    \    should match regexp    ${searchedhost}    \\${pc hostname}*
