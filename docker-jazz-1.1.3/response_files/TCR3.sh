#!/bin/bash

INSTALL_TCR_DB_NAME="TCR3x"
INSTALL_TCR_DB_CONN_URL="jdbc:db2://127.0.0.1:50000/TCR3x"
INSTALL_TCR_DB_USER_NAME="db2inst1x"
INSTALL_TCR_DB_PASSWORD="db2inst1x"
INSTALL_TCR_DB_JDBC_HOST_NAME="127.0.1x"
INSTALL_TCR_DB_JDBC_PORT="50000x"

INSTALL_TCR_DB_PASSWORD="AA=$(tools/imutilsc encryptString "$INSTALL_TCR_DB_PASSWORD")"

xmlstarlet ed \
-u "/agent-input/profile[@id='Core services in Jazz for Service Management']/data[@key='user.DB_NAME,com.ibm.tivoli.tacct.psc.install.reporting.services']/@value" -v "$INSTALL_TCR_DB_NAME" \
-u "/agent-input/profile[@id='Core services in Jazz for Service Management']/data[@key='user.DB_CONN_URL,com.ibm.tivoli.tacct.psc.install.reporting.services']/@value" -v "$INSTALL_TCR_DB_CONN_URL" \
-u "/agent-input/profile[@id='Core services in Jazz for Service Management']/data[@key='user.DB_USER_NAME,com.ibm.tivoli.tacct.psc.install.reporting.services']/@value" -v "$INSTALL_TCR_DB_USER_NAME" \
-u "/agent-input/profile[@id='Core services in Jazz for Service Management']/data[@key='user.DB_PASSWORD,com.ibm.tivoli.tacct.psc.install.reporting.services']/@value" -v "$INSTALL_TCR_DB_PASSWORD" \
-u "/agent-input/profile[@id='Core services in Jazz for Service Management']/data[@key='user.DB_JDBC_HOST_NAME,com.ibm.tivoli.tacct.psc.install.reporting.services']/@value" -v "$INSTALL_TCR_DB_JDBC_HOST_NAME" \
-u "/agent-input/profile[@id='Core services in Jazz for Service Management']/data[@key='user.DB_JDBC_PORT,com.ibm.tivoli.tacct.psc.install.reporting.services']/@value" -v "$INSTALL_TCR_DB_JDBC_PORT" response_was_jazz_webgui.xml
