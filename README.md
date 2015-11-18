# Docker Omnibus

Dockerfile for building Netcool/OMNIbus docker containers.

## Building 

Dockerfiles are using hostname netcool.install (see Dockerfile) to download installation images. To successfully build docker images, you need to change the INSTALLHOST environment value located in Dockerfile to point to your location of IBM Netcool/OMNIbus installation files. Another option is to add the _netcool.install_ hostname to your local DNS server (if possible) and start a simple http server with your installation images such as python's SimpleHTTPServer.

Optionally you can remove installation manager stuff (directories and install data) from image by uncommenting appropriate lines.

## Running

Objectserver runs as dedicated user netcool and contains a single volume /db for database. Database initialization is called on container startup only.

Container can be configured by following environment variables
  * OBJSRV\_PORT (default 4100) - port to start Object Server
  * DBINIT\_EXTRA - extra arguments passwd to nco\_dbinit
  * OBJSRV\_EXTRA - extra arguments passed to nco\_objserv
  * OMNIDAT\_EXTRA - extra content inserted to omni.dat
