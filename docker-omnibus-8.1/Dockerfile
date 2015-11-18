FROM centos:7
MAINTAINER Julius Loman <lomo@kyberia.net>

ENV INSTALLHOST="http://netcool.install:8000" NCHOME="/opt/IBM/tivoli/netcool" OMNIHOME="/opt/IBM/tivoli/netcool/omnibus" OBJSRV="NCOMS" OBJSRV_PORT=4100 

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
COPY run_objectserver.sh omnibus-response.xml /tmp/install/scripts/

# Add dedicated user
RUN mkdir -p $NCHOME /tmp/install/core /tmp/install/fp3 /tmp/install/im && \
    useradd -c "Netcool user" netcool && mkdir -p /db /tmp/install && chown -R netcool:netcool /db /tmp/install $NCHOME && \
    mv /tmp/install/scripts/run_objectserver.sh /

USER netcool

# Perform installation
RUN cd /tmp/install && \
    curl -O $INSTALLHOST/OMNIbus-v8.1-Core.linux64.zip &&  unzip -q -d /tmp/install/core OMNIbus-v8.1-Core.linux64.zip && \
    curl -O $INSTALLHOST/8.1.0-TIV-OMNIbusCore-linux-x86_64-FP0004.zip && unzip -q -d /tmp/install/fp3 8.1.0-TIV-OMNIbusCore-linux-x86_64-FP0004.zip && \
    curl -O $INSTALLHOST/agent.installer.linux.gtk.x86_64_1.8.3000.20150606_0047.zip && unzip -q -d /tmp/install/im agent.installer.linux.gtk.x86_64_1.8.3000.20150606_0047.zip && \
    /tmp/install/im/userinstc --launcher.ini /tmp/install/im/user-silent-install.ini  -acceptLicense && \
    /home/netcool/IBM/InstallationManager/eclipse/IBMIM -acceptLicense -ShowVerboseProgress -silent -nosplash -input /tmp/install/scripts/omnibus-response.xml && \
    chmod +x /run_objectserver.sh && \ 
# Optially remove Installation Manager stuff to lower image footprint
#   rm -rf /home/netcool/var /home/netcool/IBM && \
    rm -rf /tmp/install

EXPOSE $OBJSRV_PORT

CMD /run_objectserver.sh
