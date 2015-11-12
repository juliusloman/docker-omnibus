#!/bin/sh

[ -z "$OBJSRV" ] && OBJSRV="NCOMS"
[ -z "$OBJSRVPORT" ] && OBJSRVPORT=4100
[ -z "$NCHOME" ] && NCHOME="/opt/IBM/tivoli/netcool"
[ -z "$OMNIHOME" ] && NCHOME="/opt/IBM/tivoli/netcool/omnibus"

echo -e "[$OBJSRV]\n{\n\tPrimary: $HOSTNAME $OBJSRVPORT\n}" >$NCHOME/etc/omni.dat

$NCHOME/bin/nco_igen &&
$OMNIHOME/bin/nco_dbinit -server $OBJSRV -force &&
$OMNIHOME/bin/nco_objserv -name $OBJSRV
