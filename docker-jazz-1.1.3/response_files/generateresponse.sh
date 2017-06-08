INSTALL_TMP=/tmp/install

xmlstarlet ed \
-d '/agent-input/install/offering[@id="com.ibm.tivoli.tacct.psc.install.reporting.services"]' \
-d '/agent-input/server/repository' \
-s '/agent-input/server' -t elem -n repository \
-i "/agent-input/server/repository[not(@location)]" \
-t attr -n location -v "$INSTALL_TMP/was/WASRepository"  \
-s '/agent-input/server' -t elem -n repository \
-i "/agent-input/server/repository[not(@location)]" \
-t attr -n location -v "$INSTALL_TMP/jazz/JazzSMRepository"  \
-s '/agent-input/server' -t elem -n repository \
-i "/agent-input/server/repository[not(@location)]" \
-t attr -n location -v "$INSTALL_TMP/webgui/OMNIbusWebGUIRepository"  \
-s '/agent-input/server' -t elem -n repository \
-i "/agent-input/server/repository[not(@location)]" \
-t attr -n location -v "$INSTALL_TMP/webgui-fp/OMNIbusWebGUIRepository/delta"  \
-s '/agent-input/server' -t elem -n repository \
-i "/agent-input/server/repository[not(@location)]" \
-t attr -n location -v "$INSTALL_TMP/webgui-fp/OMNIbusWebGUI_NOIExtensionsRepository/delta"  \
-s '/agent-input' -t elem -n profile \
-i "/agent-input/profile[not(@id)]" -t attr -n id -v "IBM Netcool" \
-i "/agent-input/profile[@id='IBM Netcool']" -t attr -n installLocation -v "/opt/IBM/netcool"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "cic.selector.arch" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='cic.selector.arch']" -t attr -n value -v "x86_64"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.DashHomeDir" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.DashHomeDir']" -t attr -n value -v "/opt/IBM/JazzSM/ui"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.WasHomeDir" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.WasHomeDir']" -t attr -n value -v "/opt/IBM/WebSphere/AppServer"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.DashHomeUserID" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.DashHomeUserID']" -t attr -n value -v "smadmin"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.DashHomePwd" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.DashHomePwd']" -t attr -n value -v "smadmin"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.DashHomeContextRoot" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.DashHomeContextRoot']" -t attr -n value -v "/ibm/console"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.DashHomeWasCell" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.DashHomeWasCell']" -t attr -n value -v "JazzSMNode01Cell"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.DashHomeWasNode" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.DashHomeWasNode']" -t attr -n value -v "JazzSMNode01"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.DashHomeWasServerName" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.DashHomeWasServerName']" -t attr -n value -v "server1"  \
-s "/agent-input/profile[@id='IBM Netcool']" -t elem -n data -i "/agent-input/profile[@id='IBM Netcool']/data[not(@key)]" -t attr -n key -v "user.SaasEnabled" -i "/agent-input/profile[@id='IBM Netcool']/data[@key='user.SaasEnabled']" -t attr -n value -v "false"  \
-s '/agent-input' -t elem -n install \
-s "/agent-input/install[not(offering)]" -t elem -n offering -i "/agent-input/install/offering[not(@profile)]" -t attr -n profile -v "IBM Netcool" \
-i "/agent-input/install/offering[@profile='IBM Netcool']" -t attr -n id -v 'com.ibm.tivoli.netcool.omnibus.webgui' \
-i "/agent-input/install/offering[@profile='IBM Netcool']" -t attr -n features -v 'VMM.feature,WebGUI.feature' \
install_jazzsm_was_fullprofile_response.xml
