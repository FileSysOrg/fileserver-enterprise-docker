#!/bin/sh

echo "Enterprise Java File Server starting"
exec java -agentlib:jdwp=transport=dt_socket,server=y,address=8000,suspend=n -cp .:lib/* org.filesys.app.EnterpriseFileServer fileSrvConfig.xml
