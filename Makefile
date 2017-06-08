NO_PROXY=195.28.103.20
PROXY=195.28.100.45:8080
INSTALL_SOURCE=http://$(shell hostname -i):8000

INSTALL_TCR_DB_CONN_URL="jdbc:db2://$(shell hostname -i):50000/TCR3"
INSTALL_TCR_DB_USER_NAME="db2inst1"
INSTALL_TCR_DB_PASSWORD="db2inst1"
INSTALL_TCR_DB_JDBC_HOST_NAME="$(shell hostname -i)"
INSTALL_TCR_DB_JDBC_PORT="50000"
INSTALL_OBJECTSERVER_PRIMARY_HOST="$(shell hostname -i)"
INSTALL_OBJECTSERVER_PRIMARY_PORT="4100"
INSTALL_OBJECTSERVER_PRIMARY_NAME="NCOMS"
INSTALL_OBJECTSERVER_USER="root"
INSTALL_OBJECTSERVER_PASSWORD=""


.PHONY: jazz omnibus db2


DOCKER_BUILD_ARGS=--build-arg no_proxy=$(NO_PROXY) --build-arg http_proxy=$(PROXY) --build-arg https_proxy=$(PROXY) --build-arg INSTALL_SOURCE=$(INSTALL_SOURCE)
#DOCKER_BUILD_ARGS=--build-arg INSTALL_SOURCE=$(INSTALL_SOURCE)

DOCKER_BUILD_ARGS_JAZZ=$(DOCKER_BUILD_ARGS) --build-arg INSTALL_TCR_DB_CONN_URL=$(INSTALL_TCR_DB_CONN_URL) --build-arg INSTALL_TCR_DB_USER_NAME=$(INSTALL_TCR_DB_USER_NAME) --build-arg INSTALL_TCR_DB_PASSWORD=$(INSTALL_TCR_DB_PASSWORD) --build-arg INSTALL_TCR_DB_JDBC_HOST_NAME=$(INSTALL_TCR_DB_JDBC_HOST_NAME) --build-arg INSTALL_TCR_DB_JDBC_PORT=$(INSTALL_TCR_DB_JDBC_PORT) --build-arg INSTALL_OBJECTSERVER_PRIMARY_HOST=$(INSTALL_OBJECTSERVER_PRIMARY_HOST) --build-arg INSTALL_OBJECTSERVER_PRIMARY_PORT=$(INSTALL_OBJECTSERVER_PRIMARY_PORT) --build-arg INSTALL_OBJECTSERVER_PRIMARY_NAME=$(INSTALL_OBJECTSERVER_PRIMARY_NAME) --build-arg INSTALL_OBJECTSERVER_USER=$(INSTALL_OBJECTSERVER_USER) --build-arg INSTALL_OBJECTSERVER_PASSWORD=$(INSTALL_OBJECTSERVER_PASSWORD)

db2:
	docker build $(DOCKER_BUILD_ARGS) -t noi/db2 docker-db2-10.5

db2-tcr:
	docker build $(DOCKER_BUILD_ARGS) -t noi/db2-tcr docker-db2-tcr

omnibus:
	docker build $(DOCKER_BUILD_ARGS) -t noi/omnibus docker-omnibus-8.1/

jazz:
	#docker ps |grep noi-db2-tcr-install && docker stop noi-db2-tcr-install
	docker run --rm -d --net=host --name noi-install-db2 --privileged noi/db2-tcr
	docker run --rm -d --net=host --name noi-install-omnibus noi/omnibus
	docker build --rm $(DOCKER_BUILD_ARGS_JAZZ) -t noi/jazz docker-jazz-1.1.3/
	docker stop noi-install-omnibus noi-install-db2

test:

all: 	omnibus db2 db-tcr jazz
