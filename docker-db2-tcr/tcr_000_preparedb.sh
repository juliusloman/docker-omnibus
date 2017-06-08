#!/bin/bash

su - -c "db2 -vtf /docker-init-postinstance.d/tcr_create_db2_cs.sql" $DB2INSTANCE
