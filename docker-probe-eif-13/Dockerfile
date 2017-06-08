FROM centos:7
MAINTAINER Julius Loman <lomo@kyberia.net>

RUN mkdir -p /tmp/install/probe && echo "<?xml version='1.0' encoding='UTF-8'?><agent-input><variables><variable name='sharedLocation' value='/tmp/install/var/ibm/InstallationManager'/></variables><server><repository location='/tmp/install/probe'/></server><profile id='IBM Tivoli Netcool OMNIbus' installLocation='/opt/IBM/tivoli/netcool'><data key='cic.selector.arch' value='x86_64'/><data key='user.migratedata,com.ibm.tivoli.omnibus.core' value='false'/></profile><install><offering profile='IBM Tivoli Netcool OMNIbus' id='com.ibm.tivoli.omnibus.integrations.nco-p-tivoli-eif' version='1.13.0.7' features='nco-p-tivoli-eif'/></install><preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='${sharedLocation}'/></agent-input>" >/tmp/install/eif-response.xml &&
    curl -O $INSTALLHOST/im-nco-p-tivoli-eif-13_0.zip && unzip -q -d /tmp/install/probe im-nco-p-tivoli-eif-13_0.zip && \
    /home/netcool/IBM/InstallationManager/eclipse/IBMIM -acceptLicense -ShowVerboseProgress -silent -nosplash -input /tmp/install/probe/omnibus-response.xml


