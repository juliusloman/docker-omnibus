FROM centos:7
MAINTAINER Julius Loman <lomo@kyberia.net>

ENV NCHOME  "/opt/IBM/tivoli/netcool"
ENV OMNIHOME  "/opt/IBM/tivoli/netcool/omnibus"
ENV OBJSRV  "NCOMS"
ENV OBJSRVPORT 4100

# Add dependencies
RUN yum --setopt=tsflags=nodocs -y install \
    wget \
    tar \
    gtk2 \
    dejavu-fonts-common \
    dejavu-sans-fonts \    
    libXtst \    
    audit-libs \    
    expat \    
    fontconfig \    
    freetype \    
    glibc \    
    libICE \    
    libSM \    
    libX11 \    
    libXau \    
    libXext \    
    libXft \    
    libXmu \    
    lilbXp \    
    libXpm \    
    libXrender \    
    libXt \    
    libgcc \    
    libidn \    
    libjpeg-turbo \    
    libpng12 \    
    libstdc++ \    
    libuuid \    
    libxcb \    
    motif \    
    nss-softokn-freebl \    
    pam \    
    zlib \    
    libstdc++.i686 \    
    compat-libstdc++-33.i686 \    
    glibc.i686 \    
    libgcc.i686 \    
    nss-softokn-freebl.i686 \    
    hostname \    
    unzip \
    compat-libstdc++-33 \    
    compat-libstdc++-296 && \
    rm -rf /var/cache/yum/* && \
    yum clean all

# Add installation media
COPY agent.installer.linux.gtk.x86_64_1.8.1000.20141126_2002.zip  WAS_V8.5.0.1_FOR_JAZZSM_LINUX_ML.zip 1.1.2.0-TIV-JazzSM-multi.zip OMNIbus-v8.1-FP2-WebGUI.linux64.zip OMNIbus-v8.1-WebGUI.linux64.zip JAZZ_FOR_SM_1.1.0.3_FOR_LNX.zip webgui-response.xml /tmp/install
COPY run_webgui.sh /usr/local/bin/

RUN unzip -d /tmp/install/im/ /tmp/install/agent.installer.linux.gtk.x86_64_1.8.1000.20141126_2002.zip && \ 
    unzip -d /tmp/install/was-8.5.0.1/ /tmp/install/WAS_V8.5.0.1_FOR_JAZZSM_LINUX_ML.zip && \
    unzip -d /tmp/install/jazz-1.1.0.3/ /tmp/install/JAZZ_FOR_SM_1.1.0.3_FOR_LNX.zip && \
    unzip -d /tmp/install/jazz-1.1.2/ /tmp/install/1.1.2.0-TIV-JazzSM-multi.zip && \
    unzip -d /tmp/install/webgui-8.1.0.2/ /tmp/install/OMNIbus-v8.1-FP2-WebGUI.linux64.zip && \
    unzip -d /tmp/install/webgui-8.1/ /tmp/install/OMNIbus-v8.1-WebGUI.linux64.zip && \
    /tmp/install/im/installc --launcher.ini /tmp/install/im/silent-install.ini  -acceptLicense && \
    /opt/IBM/InstallationManager/eclipse/IBMIM -acceptLicense -ShowVerboseProgress -silent -nosplash -input /tmp/install/webgui-response.xml && \
    /opt/IBM/JazzSM/profile/bin/startServer.sh server1 -script /usr/local/bin/startJazz.sh && \
    chmod +x /usr/local/bin/run_webgui.sh && \ 
    rm -rf /tmp/install

EXPOSE 16311 16310 16315 16316

CMD /usr/local/bin/run_webgui.sh
