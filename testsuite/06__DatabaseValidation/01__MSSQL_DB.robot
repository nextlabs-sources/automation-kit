*** Settings ***
Suite Setup       Connect To Database    pymssql    ${dbName}    ${dbUsername}    ${dbPassword}    ${dbHost}    ${dbPort}
Resource          ../resources/Control Center/${RES_DIR}/console_keywords/WebUI_keywords.robot
Library           DatabaseLibrary
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Change Password for SuperUser Through DB
    [Tags]    Initial_password_change
    ${output} =    Execute SQL String    UPDATE SUPER_APPLICATION_USER SET PASSWORD = HashBytes('MD5', '12345Blue!') WHERE USERNAME = 'Administrator';
    Log    ${output}

Table_Must_Exists
    [Tags]    db
    Table Must Exist    ACCESS_CONTROL
    Table Must Exist    ACCESS_GROUP
    Table Must Exist    ACTIVITY_JOURNALING_SETTINGS
    Table Must Exist    ACT_JOURN_SETTINGS_LOGGED_ACTS
    Table Must Exist    AGENT
    Table Must Exist    AGENT_PROFILE
    Table Must Exist    AGENT_REGISTRATION
    Table Must Exist    ALERT
    Table Must Exist    APA_LOG
    Table Must Exist    APA_LOG_ATTR
    Table Must Exist    APPLICATION_USER
    Table Must Exist    APPLICATION_USER_DOMAIN
    Table Must Exist    APP_USER_GROUP_MEMBERSHIP
    Table Must Exist    APP_USER_PROPERTIES
    Table Must Exist    ARCHIVE_OBLIGATION_LOG
    Table Must Exist    ARCHIVE_POLICY_ACTIVITY_LOG
    Table Must Exist    ARCHIVE_POLICY_CUSTOM_ATTR
    Table Must Exist    ARCHIVE_TRACKING_ACTIVITY_LOG
    Table Must Exist    ARCHIVE_TRACKING_CUSTOM_ATTR
    Table Must Exist    AUDIT_LOGS
    Table Must Exist    AUTH_HANDLER_REGISTRY
    Table Must Exist    CACHED_APPLICATION
    Table Must Exist    CACHED_HOST
    Table Must Exist    CACHED_HOSTGROUP
    Table Must Exist    CACHED_POLICY
    Table Must Exist    CACHED_USER
    Table Must Exist    CACHED_USERGROUP
    Table Must Exist    CACHED_USERGROUP_MEMBER
    Table Must Exist    COMM_PROFILE
    Table Must Exist    COMM_PROFILE_SEED
    Table Must Exist    COMM_PROFILE_SEED_ITEMS
    Table Must Exist    COMPONENT
    Table Must Exist    CUSTOM_APP
    Table Must Exist    DEPLOYMENT_REQUEST
    Table Must Exist    DEVELOPMENT_ENTITIES_TAGS
    Table Must Exist    DICT_ELEMENTS
    Table Must Exist    DICT_ELEMENT_TYPES
    Table Must Exist    DICT_ENROLLMENTS
    Table Must Exist    DICT_ENROLLMENT_DELTA
    Table Must Exist    DICT_ENROLLMENT_PROPERTIES
    Table Must Exist    DICT_ENUM_GROUPS
    Table Must Exist    DICT_ENUM_GROUP_MEMBERS
    Table Must Exist    DICT_ENUM_MEMBERS
    Table Must Exist    DICT_ENUM_REF_MEMBERS
    Table Must Exist    DICT_FIELD_MAPPINGS
    Table Must Exist    DICT_LEAF_ELEMENTS
    Table Must Exist    DICT_STRUCT_GROUPS
    Table Must Exist    DICT_TYPE_FIELDS
    Table Must Exist    DICT_UPDATES
    Table Must Exist    ENTITY_AUDIT_LOG
    Table Must Exist    EVENT
    Table Must Exist    EVENT_REGISTRATION
    Table Must Exist    FOLDER
    Table Must Exist    HEART_BEAT_RECORD
    Table Must Exist    INQUIRY
    Table Must Exist    INQUIRY_ACTIONS
    Table Must Exist    INQUIRY_OBLIGATIONS
    Table Must Exist    INQUIRY_POLICIES
    Table Must Exist    INQUIRY_POLICY_DECISIONS
    Table Must Exist    INQUIRY_RESOURCES
    Table Must Exist    INQUIRY_USERS
    Table Must Exist    LOGGER_CONFIG
    Table Must Exist    MFA_GOOGLE_AUTH_ACCOUNT
    Table Must Exist    MFA_GOOGLE_AUTH_CODE
    Table Must Exist    MFA_GOOGLE_AUTH_TOKEN
    Table Must Exist    MONITOR
    Table Must Exist    MONITOR_TAGS
    Table Must Exist    OBLIGATION_LOG
    Table Must Exist    OPERATOR_CONFIG
    Table Must Exist    PASSWORD_HISTORY
    Table Must Exist    PM_ACTION_CONFIG
    Table Must Exist    PM_ATTRIBUTE_CONFIG
    Table Must Exist    PM_ATTRIB_CONFIG_OPER_CONFIG
    Table Must Exist    PM_OBLIGATION_CONFIG
    Table Must Exist    PM_PARAMETER_CONFIG
    Table Must Exist    POLICY_ACTIVITY_LOG
    Table Must Exist    POLICY_CUSTOM_ATTR
    Table Must Exist    POLICY_LOG_REPORT_DETAILS
    Table Must Exist    POLICY_MODEL
    Table Must Exist    POLICY_MODEL_TAGS
    Table Must Exist    POLICY_TAGS
    Table Must Exist    REPORT
    Table Must Exist    REPORT_CUSTOM_APP
    Table Must Exist    REPORT_CUSTOM_APP_FILES
    Table Must Exist    REPORT_CUSTOM_APP_UI
    Table Must Exist    REPORT_INTERNAL
    Table Must Exist    REPORT_OBLIGATION_LOG
    Table Must Exist    REPORT_POLICY_ACTIVITY_LOG
    Table Must Exist    REPORT_POLICY_CUSTOM_ATTR
    Table Must Exist    REPORT_SUMMARY_RESULTS
    Table Must Exist    REPORT_TRACKING_ACTIVITY_LOG
    Table Must Exist    REPORT_TRACKING_CUSTOM_ATTR
    Table Must Exist    RESOURCE_CACHE_STATE
    Table Must Exist    REV_INFO
    Table Must Exist    RPA_LOG
    Table Must Exist    RPA_LOG_ATTR
    Table Must Exist    RPA_LOG_MAPPING
    Table Must Exist    SAVED_REPORTS
    Table Must Exist    SAVED_SEARCH
    Table Must Exist    SECURE_SESSION
    Table Must Exist    SECURE_SESSION_PROPERTIES
    Table Must Exist    STORED_QUERY
    Table Must Exist    STORED_QUERY_BY_ID_RESULTS
    Table Must Exist    STORED_QUERY_SUMMARY_RESULTS
    Table Must Exist    SUPER_APPLICATION_USER
    Table Must Exist    SYS_CONFIG
    Table Must Exist    TAG_LABELS
    Table Must Exist    TARGET_AGENT
    Table Must Exist    TARGET_HOST
    Table Must Exist    TOOL
    Table Must Exist    TOOL_COMMAND
    Table Must Exist    TOOL_PARAMETER
    Table Must Exist    TOOL_TASK
    Table Must Exist    TOOL_TASK_PARAM_VALUE
    Table Must Exist    TRACKING_ACTIVITY_LOG
    Table Must Exist    TRACKING_CUSTOM_ATTR
    Table Must Exist    TRACKING_LOG_REPORT_DETAILS
    Table Must Exist    USER_PROFILE
    #Table Must Exist    connection_test_table_das56079
    Table Must Exist    deployment_entities
    Table Must Exist    deployment_records
    Table Must Exist    development_entities
    Table Must Exist    km_keyring
    Table Must Exist    pf_target_resolutions

View_Must_Exists
    [Tags]    db
    Table Must Exist    APP_USER_VIEW
    Table Must Exist    APP_USER_VIEW
    Table Must Exist    policy_attr_mapping_v2
    Table Must Exist    policy_custom_attribute_v1
    Table Must Exist    policy_custom_attribute_v2
    Table Must Exist    policy_log_v1
    Table Must Exist    policy_log_v2
    Table Must Exist    policy_obligation_log_v1
    Table Must Exist    TOOL_COMMAND_VIEW
    Table Must Exist    tracking_custom_attribute_v1
    Table Must Exist    tracking_log_v1
