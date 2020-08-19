*** Settings ***
Library  Collections
Library  RoboZap  https://127.0.0.1:8090  8090
Library  RoboFunctionalTest

*** Variables ***
${TARGET_NAME}  Mosip
${TARGET_URI}  https://qa.mosip.net/

#CONFIG
${RESULTS_PATH}  /home/mosipuser/mosip/reports

#ZAP
${ZAP_PATH}  /home/mosipuser/securitytools/
${APPNAME}  qa.mosip.net
${CONTEXT}  qa.mosip.net
${REPORT_TITLE}  MOSIP Test Report - ZAP
${REPORT_FORMAT}  json
${ZAP_REPORT_FILE}  MOSIP.json
${REPORT_AUTHOR}  MANDEEP
${SCANPOLICY}  Default Policy

#TEST-RIG
${PATH}  /home/mosipuser/mosip/function-test-suite
${MODULE}  prereg
${ENVUSER}  qa
${TESTLEVEL}  smoke
${HOST}  127.0.0.1
${PORT}  8081


*** Test Cases ***
#Create Targets
#    find or create target  ${TARGET_NAME}  ${TARGET_URI}

Initialize ZAP
    [Tags]  zap_init
    start gui zap  ${ZAP_PATH}
    sleep  20
    zap open url  ${TARGET_URI}

ZAP Contextualize
    [Tags]  zap_context
    ${contextid}=  zap define context  ${CONTEXT}  ${TARGET_URI}
    set suite variable  ${CONTEXT_ID}  ${contextid}
    sleep  10

Functional Test Start
    [Tags]  start_functional_test
    start functional test  ${PATH}  ${MODULE}  ${ENVUSER}  ${TARGET_URI}  ${TESTLEVEL}  ${HOST}  ${PORT}

ZAP Active Scan
    [Tags]  zap_start_ascan
    ${scanid}=  zap start ascan  ${CONTEXT_ID}  ${TARGET_URI}  ${SCANPOLICY}
    set suite variable  ${SCAN_ID}  ${scanid}
    zap scan status  ${scanid}
#    Wait Until Keyword Succeeds   30 minute  1 minute   Check status

#Check status
#    ${status}=  zap scan status  ${SCAN_ID}
#    Should Be Equal As Strings   ${status}  "100"

ZAP Generate Report
    [Tags]  zap_generate_report
    zap export report  ${RESULTS_PATH}/${ZAP_REPORT_FILE}  ${REPORT_FORMAT}  ${REPORT_TITLE}  ${REPORT_AUTHOR}
    sleep  30

#ZAP Die
#    [Tags]  zap_kill
#    zap shutdown
#    sleep  10

#Write ZAP Results to DB
#    parse zap json  ${RESULTS_PATH}/${ZAP_REPORT_FILE}  ${TARGET_NAME}

#Generate Threat Maps
#    generate threat maps

#Write Final Report
#    write markdown report
