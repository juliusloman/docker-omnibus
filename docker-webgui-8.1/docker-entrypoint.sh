#!/bin/bash

DOCKER_INIT_FINISHED="/tmp/.docker-init.d.executed"

# Run docker-init.d shell scripts
if [ ! -f "$DOCKER_INIT_FINISHED" ];
then
        for f in /docker-init.d/*; do
                case "$f" in
                        *.sh)     echo "Running init script $f"; . "$f" ;;
                esac
        done

        # Configure WebGUI Data Sources
        NCW_DATASOURCES="/opt/IBM/netcool/gui/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"
        [ ! -f "$NCW_DATASOURCES" ] && NCW_DATASOURCES="/opt/IBM/netcool/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml"

        if [ -f "$NCW_DATASOURCES" ];
        then
                for VAR in OBJECTSERVER_PRIMARY_HOST OBJECTSERVER_PRIMARY_NAME OBJECTSERVER_USER OBJECTSERVER_PASSWORD OBJECTSERVER_ENCRYPTED OBJECTSERVER_ALGORITHM_ATTRIBUTE OBJECTSERVER_SSL OBJECTSERVER_PRIMARY_PORT OBJECTSERVER_SECONDARY_HOST OBJECTSERVER_FAILOVER OBJECTSERVER_SECONDARY_PORT
                do
                        if [ -z "${!VAR}" ];
                        then
                                echo "WARNING configuration value ${VAR} empty"
                        else
                                echo "Setting CONFIGURATION_TOKEN_$VAR to ${!VAR}"
                        fi
                        sed -i"" -e "s/@CONFIGURATION_TOKEN_$VAR@/${!VAR}/g" /opt/IBM/netcool/gui/omnibus_webgui/etc/datasources/ncwDataSourceDefinitions.xml
                done
        else
                echo "Netcool/OMNIbus WebGUI data sources configuration file not found, skipping datasources initialization"
        fi
        touch "$DOCKER_INIT_FINISHED"
fi

# Run entrypoint scripts (executed every time container starts)
for f in /docker-entrypoint.d/*; do
        case "$f" in
                *.sh)     echo "$0: running entrypoint script $f"; . "$f" ;;
        esac
        echo
done

# Prepare start WAS start script and start WAS
[ ! -f /opt/IBM/JazzSM/profile/bin/startJazz.sh ] && /opt/IBM/JazzSM/profile/bin/startServer.sh server1 -script /opt/IBM/JazzSM/profile/bin/startJazz.sh
exec /opt/IBM/JazzSM/profile/bin/startJazz.sh

