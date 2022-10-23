*** Settings ***
Suite Setup       Declare Vars
Library           OperatingSystem

*** Keywords ***
Declare Vars
    ${ROOT} =    Normalize Path    ${CURDIR}/../..
    Set Global Variable    ${NORM_ROOT}    ${ROOT}
    Set Global Variable    ${VAR_DIR}    ${NORM_ROOT}/variables/Control Center
    Set Global Variable    ${LIB_DIR}    ${NORM_ROOT}/scripts/custom libraries
    Set Global Variable    ${DATA_DIR}    ${NORM_ROOT}/testdata/Control Center
    Set Global Variable    ${RES_DIR}    ${NORM_ROOT}/resources/Control Center
