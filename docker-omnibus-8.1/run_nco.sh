#!/bin/sh

echo -e "[$OBJSRV]\n{\n\tPrimary: $HOSTNAME $OBJSRV_PORT\n}\n$OMNIDAT_EXTRA" >$NCHOME/etc/omni.dat

setarch $(arch) --uname-2.6 $NCHOME/bin/nco_igen
setarch $(arch) --uname-2.6 $@
