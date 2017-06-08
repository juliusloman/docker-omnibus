#!/bin/sh

docker build --build-arg no_proxy=195.28.103.20 --build-arg http_proxy=195.28.100.45:8080 --build-arg https_proxy=195.28.100.45:8080 --build-arg INSTALL_SOURCE=http://195.28.103.20:8000 --build-arg INSTALL_OBJECTSERVER_PRIMARY_HOST=lps1.ambit.tempest.sk --build-arg INSTALL_OBJECTSERVER_PRIMARY_PORT=4100 --build-arg INSTALL_OBJECTSERVER_PRIMARY_NAME=OMNI_V --build-arg INSTALL_OBJECTSERVER_USER=root --build-arg INSTALL_OBJECTSERVER_PASSWORD= -t lomo/webgui .
