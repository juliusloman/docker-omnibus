#!/bin/sh

echo -e "[$OBJSRV]\n{\n\tPrimary: $HOSTNAME $OBJSRV_PORT\n}\n$OMNIDAT_EXTRA" >$NCHOME/etc/omni.dat

$NCHOME/bin/nco_igen
if [ ! -e "/db/.initialized" ];
then
	setarch $(arch) --uname-2.6 $OMNIHOME/bin/nco_dbinit -server $OBJSRV -memstoredatadirectory /db "$DBINIT_EXTRA"
	touch /db/.initialized
fi
setarch $(arch) --uname-2.6 $OMNIHOME/bin/nco_objserv -name $OBJSRV "$OBJSRV_EXTRA"
