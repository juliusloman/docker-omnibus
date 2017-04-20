#!/bin/bash


# Backup WebGUI Data Sources file
backupNCWDataSources() { 
        NCW_DATASOURCES="/opt/IBM/netcool/gui/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"
        [ ! -f "$NCW_DATASOURCES" ] && NCW_DATASOURCES="/opt/IBM/netcool/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"
	[ -e "$NCW_DATASOURCES" ] && cp "$NCW_DATASOURCES" /tmp/ncwDataSourceDefinitions.xml
}

# Restore WebGUI Data Sources file
restoreNCWDataSources() { 
        NCW_DATASOURCES="/opt/IBM/netcool/gui/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"
        [ ! -f "$NCW_DATASOURCES" ] && NCW_DATASOURCES="/opt/IBM/netcool/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"
	[ -e "/tmp/ncwDataSourceDefinitions.xml" ] && cp /tmp/ncwDataSourceDefinitions.xml "$NCW_DATASOURCES"
}

# Configure WebGUI Data Sources
configureNCWDataSources() {
        NCW_DATASOURCES="/opt/IBM/netcool/gui/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"
        [ ! -f "$NCW_DATASOURCES" ] && NCW_DATASOURCES="/opt/IBM/netcool/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"

        if [ -f "$NCW_DATASOURCES" ];
        then
                for VAR in OBJECTSERVER_PRIMARY_HOST OBJECTSERVER_PRIMARY_NAME OBJECTSERVER_USER OBJECTSERVER_PASSWORD OBJECTSERVER_ENCRYPTED OBJECTSERVER_ALGORITHM_ATTRIBUTE OBJECTSERVER_SSL OBJECTSERVER_PRIMARY_PORT OBJECTSERVER_SECONDARY_HOST OBJECTSERVER_FAILOVER OBJECTSERVER_SECONDARY_PORT
                do
                        if [ -z "${!VAR}" ];
                        then
                                echo "WARNING $NCW_DATASOURCES configuration value ${VAR} empty"
                        else
                                echo "Setting $NCW_DATASOURCES configuration value CONFIGURATION_TOKEN_$VAR to ${!VAR}"
                        fi
                        sed -i"" -e "s/@CONFIGURATION_TOKEN_$VAR@/${!VAR}/g" /opt/IBM/netcool/gui/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml
                done
        else
                echo "Netcool/OMNIbus WebGUI data sources configuration file not found, skipping datasources initialization"
        fi
}

# Start JazzSM (non-blocking)
startJazzSM() {
	/opt/IBM/JazzSM/profile/bin/startServer.sh server1
}

stopJazzSM() {
	/opt/IBM/JazzSM/profile/bin/stopServer.sh server1 -username "$SMADMIN_USERNAME" -password "$SMADMIN_PASSWORD"
}

# Start JazzSM (blocking)
execJazzSM() {
	[ ! -f /opt/IBM/JazzSM/profile/bin/startJazz.sh ] && /opt/IBM/JazzSM/profile/bin/startServer.sh server1 -script /opt/IBM/JazzSM/profile/bin/startJazz.sh
	exec /opt/IBM/JazzSM/profile/bin/startJazz.sh
}
