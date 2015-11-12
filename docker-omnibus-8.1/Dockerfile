FROM centos:7
MAINTAINER Julius Loman <lomo@kyberia.net>

ENV NCHOME  "/opt/IBM/tivoli/netcool"
ENV OMNIHOME  "/opt/IBM/tivoli/netcool/omnibus"
ENV OBJSRV  "NCOMS"
ENV OBJSRVPORT 4100

# Add dependencies
RUN yum --setopt=tsflags=nodocs -y install \
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
COPY 8.1.0-TIV-OMNIbusCore-linux-x86_64-FP0003.zip /tmp/install/
COPY agent.installer.linux.gtk.x86_64_1.8.1000.20141126_2002.zip /tmp/install/
COPY OMNIbus-v8.1-Core.linux64.zip /tmp/install/
COPY omnibus-response.xml /tmp/install/
COPY run_objectserver.sh /usr/local/bin/

RUN mkdir -p /tmp/install/core && unzip -d /tmp/install/core/ /tmp/install/OMNIbus-v8.1-Core.linux64.zip && \
    mkdir -p /tmp/install/fp3 && unzip -d /tmp/install/fp3/ /tmp/install/8.1.0-TIV-OMNIbusCore-linux-x86_64-FP0003.zip && \
    mkdir -p /tmp/install/im && unzip -d /tmp/install/im/ /tmp/install/agent.installer.linux.gtk.x86_64_1.8.1000.20141126_2002.zip && \ 
    /tmp/install/im/installc --launcher.ini /tmp/install/im/silent-install.ini  -acceptLicense && \
    /opt/IBM/InstallationManager/eclipse/IBMIM -acceptLicense -ShowVerboseProgress -silent -nosplash -input /tmp/install/omnibus-response.xml && \
    chmod +x /usr/local/bin/run_objectserver.sh && \ 
    rm -rf /tmp/install

EXPOSE 4100

CMD /usr/local/bin/run_objectserver.sh
