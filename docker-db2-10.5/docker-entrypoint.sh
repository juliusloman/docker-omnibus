#!/bin/bash

DOCKER_INIT_FINISHED="/tmp/.docker-init.d.executed"

createInstance()
{
	echo "Creating DB2 instance $DB2INSTANCE with fenced user $DB2INSTANCE_FENCEDUSER on port $DB2INSTANCE_PORT"
	useradd "$DB2INSTANCE"
	echo "$DB2INSTANCE_PASSWORD"|passwd --stdin "$DB2INSTANCE"
	useradd "$DB2INSTANCE_FENCEDUSER"
	echo "$DB2INSTANCE_FENCEDUSER_PASSWORD"|passwd --stdin "$DB2INSTANCE_FENCEDUSER"
	[ -z "$DB2INSTANCE_PORT" ] && DB2INSTANCE_PORT=50000
	/opt/ibm/db2/instance/db2icrt -u "$DB2INSTANCE_FENCEDUSER" -p $DB2INSTANCE_PORT $DB2INSTANCE_OPTS "$DB2INSTANCE" 
}


startInstance()
{
	su - -c "db2start" "$DB2INSTANCE"
}

stopInstance()
{
	su - -c "db2stop" "$DB2INSTANCE"
	[ $? -ne 0 ] &&	su - -c "db2stop force" "$DB2INSTANCE"
	exit 0
}


# Run docker-init.d shell scripts
if [ ! -f "$DOCKER_INIT_FINISHED" ];
then
        for f in /docker-init-preinstance.d/*; do
                case "$f" in
                        *.sh)     echo "Running init script $f"; . "$f" ;;
                esac
        done
	createInstance
	startInstance
	[ -n "$DB2INSTANCE_DATABASE" ] && su - -c "db2 create database $DB2INSTANCE_DATABASE" $DB2INSTANCE
        touch "$DOCKER_INIT_FINISHED"

        for f in /docker-init-postinstance.d/*; do
                case "$f" in
                        *.sh)     echo "Running init script $f"; . "$f" ;;
                esac
        done
else 
	startInstance
fi



# Run entrypoint scripts (executed every time container starts)
for f in /docker-entrypoint.d/*; do
        case "$f" in
                *.sh)     echo "$0: running entrypoint script $f"; . "$f" ;;
        esac
        echo
done

trap stopInstance SIGTERM SIGINT


while [ 1 ]; do sleep 60 & wait $1 ; done

