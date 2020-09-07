*** Settings ***
Library  Collections
Library  RoboZap  https://127.0.0.1:<port>  <port>
Library  RoboFunctionalTest

*** Variables ***
${TARGET_NAME}  <target_name>  #
${TARGET_URI}  <target_uri>  #

#CONFIG
${RESULTS_PATH}  <report_dir>  #

#ZAP
${ZAP_PATH}  <zap_dir>  #
${CONTEXT}  <context>  #
${REPORT_TITLE}  Mosip-Test-Report-ZAP  #
${REPORT_FORMAT}  json  #
${ZAP_REPORT_FILE}  MOSIP.json  #
${REPORT_AUTHOR}  <author>  #
${SCANPOLICY}  <scan_policy>  #

#TEST-RIG
${PATH}  <testrig_dir>  #
${MODULE}  <module>  #
${ENVUSER}  <envuser>  #
${TESTLEVEL}  <testlevel>  #
${HOST}  <host>  #
${PORT}  <port>  #


*** Test Cases ***
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
    sleep  10

ZAP Active Scan
    [Tags]  zap_start_ascan
    ${scanid}=  zap start ascan  ${CONTEXT_ID}  ${TARGET_URI}  ${SCANPOLICY}
    set suite variable  ${SCAN_ID}  ${scanid}
    zap scan status  ${scanid}
    sleep  100

ZAP Json Report
    [Tags]  zap_write_to_json_file
    zap write to json file  ${TARGET_URI}  ${RESULTS_PATH}  ${REPORT_TITLE}

#ZAP Die
#    [Tags]  zap_kill
#    zap shutdown
#    sleep  10

#Write ZAP Results to DB
#    parse zap json  ${RESULTS_PATH}/${ZAP_REPORT_FILE}  ${TARGET_NAME}
