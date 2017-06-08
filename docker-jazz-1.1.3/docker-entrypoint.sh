#!/bin/bash

DOCKER_INIT_FINISHED="/tmp/.docker-init.d.executed"
. /docker-entrypoint-functions.sh

# Run docker-init.d shell scripts
if [ ! -f "$DOCKER_INIT_FINISHED" ];
then
        for f in /docker-init.d/*; do
                case "$f" in
                        *.sh)     echo "Running init script $f"; . "$f" ;;
                esac
        done

	configureNCWDataSources
	configureTCRCS

        touch "$DOCKER_INIT_FINISHED"
fi

# Run entrypoint scripts (executed every time container starts)
for f in /docker-entrypoint.d/*; do
        case "$f" in
                *.sh)     echo "$0: running entrypoint script $f"; . "$f" ;;
        esac
        echo
done

execJazzSM
