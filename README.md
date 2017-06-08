# Docker Omnibus

Dockerfile for building Netcool Operation Insight docker containers.

## Building 

Because many components depend on working DB2 database during installation, it
necessary to build a DB2 container first. Generally all docker images require
that you set up a HTTP server for supplying installation images (media) and specify 
names of those installation images either in Dockerfile or as build arguments.

### Setting up HTTP server

If you don't have the NOI installation media accessible via HTTP, the easiest
way is probably to use python's build in SimpleHTTPServer. Just navigate to
directory with downloaded NOI images and run
  
  python -m SimpleHTTPServer

This starts up a HTTP server serving on port 8000 on all local interfaces.

### DB2

Build the DB2 image using (replace the <HTTP\_ADDRESS> with your actual IP
address that is accessbile from docker internal network):

  docker build --build-arg INSTALL\_SOURCE=http://<HTTP\_ADDRESS>:8000 -t noi/db2 docker-db2-10.5

If you your interet access requires using proxy, just add add those arguments

  --build-arg no\_proxy=<HTTP\_ADDRESS> --build-arg http\_proxy=<PROXY> --build-arg https\_proxy=<PROXY>


DB2 image expects following media (you can override the arguments by editing Dockerfile or by supplying them using --build-arg):

  * INSTALL\_FILE\_DB2="DB2\_Svr\_10.5.0.3\_Linux\_x86-64.tar.gz" (base image)
  * INSTALL\_FILE\_DB2\_FP="v10.5fp8\_linuxx64\_universal\_fixpack.tar.gz" (optional fixpack image)
  * INSTALL\_FILE\_DB2\_LIC="DB2\_ESE\_Restricted\_QS\_Act\_10.5.0.1.zip" (optional activation image)

### Netcool/OMNIbus Object Server

Build the Object Server image by running:

  docker build --build-arg INSTALL\_SOURCE=http://<HTTP\_ADDRESS>:8000 -t noi/omnibus docker-omnibus-8.1

DB2 image expects following media (you can override the arguments by editing Dockerfile or by supplying them using --build-arg):

  * INSTALL\_FILE\_CORE="OMNIbus-v8.1.0.5-Core.linux64.zip" (base image)
  * INSTALL\_FILE\_FP="8.1.0-TIV-NCOMNIbus-Linux-FP0011.zip" (fixpack image)

## Running

You can start the stack using docker-compose and provided docker-compose.yml file. This starts up single Object Server named AGG and a WebGUI instance.

### Object Server
Objectserver runs as dedicated user netcool and contains a single volume /db for database. Database initialization is called on container startup only.

Container can be configured by following environment variables
  * OBJSRV\_PORT (default 4100) - port to start Object Server
  * DBINIT\_EXTRA - extra arguments passwd to nco\_dbinit
  * OBJSRV\_EXTRA - extra arguments passed to nco\_objserv
  * OMNIDAT\_EXTRA - extra content inserted to omni.dat

### WebGUI

WebGUI can be configured using following environment variables, that will be modified in *ncwDataSourceDefinitions.xml* configuration file

  * OBJECTSERVER\_PRIMARY\_HOST 
  * OBJECTSERVER\_PRIMARY\_NAME 
  * OBJECTSERVER\_USER 
  * OBJECTSERVER\_PASSWORD 
  * OBJECTSERVER\_ENCRYPTED 
  * OBJECTSERVER\_ALGORITHM\_ATTRIBUTE 
  * OBJECTSERVER\_SSL 
  * OBJECTSERVER\_PRIMARY\_PORT 
  * OBJECTSERVER\_SECONDARY\_HOST 
  * OBJECTSERVER\_FAILOVER 
  * OBJECTSERVER\_SECONDARY\_PORT



