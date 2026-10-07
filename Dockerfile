FROM filesysorg/jfileserver:1.4.4

# Set the working directory for the file server
WORKDIR /jfileserver

# Copy in the Jars, scripts and configuration files
COPY target/jfileserver ./

# Make the run script executable
RUN chmod +x /jfileserver/runsrv.sh

# Create a folder for the licence, likely mapped to a host location or included inline in the configuration
RUN mkdir licence

# Create a folder for the database filesystem data
RUN mkdir dbshare

# Create a temporary folder for the database file share
RUN mkdir jdbctemp

# Install the PSQL command
RUN apk add postgresql-client

# Expose the file server ports
# SMB ports
EXPOSE 445/tcp
EXPOSE 139/tcp
EXPOSE 138/udp
EXPOSE 137/udp
# FTP port
EXPOSE 21/tcp
# Cloud sync
EXPOSE 8080/TCP

# Remote debugging
EXPOSE 8000/TCP

# Environment variables used in the server configuration that can be overridden
ENV JFSRV_SMB_ENABLE true
ENV JFSRV_FTP_ENABLE false
ENV JFSRV_NFS_ENABLE false

ENV JFSRV_SMB_SERVERNAME jfilesrv
ENV JFSRV_SMB_DOMAIN domain

ENV JFSRV_SMB_DIALECTS smb2,smb3
ENV JFSRV_SMB_DEBUGFLAGS Negotiate,Socket,State,Error,File,Info

ENV JFSRV_SMB_ENCRYPTION_TYPES GCM,CCM
ENV JFSRV_SMB_AES_PROVIDER SunJCE

ENV JFSRV_FTP_PORT 21
ENV JFSRV_FTP_DEBUGFLAGS File,Search,Error,DataPort,Directory

ENV JFSRV_NFS_DEBUGFLAGS File,FileIO

ENV JFSRV_SHARE_NAME jfileshare
ENV JFSRV_SHARE_COMMENT Test shared filesystem
ENV JFSRV_SHARE_PATH /jfileserver/fileShare

ENV JFSRV_DBSHARE_NAME dbshare
ENV JFSRV_DBSHARE_PATH /jfileserver/dbshare

ENV JFSRV_DBBLOB_NAME dbblob
ENV JFSRV_DBBLOB_TEMPDIR /jfileserver/jdbctemp

ENV JFSRV_ADMIN_USER admin
ENV JFSRV_ADMIN_PASSWORD jfilesrv

ENV JFSRV_NORMAL_USER user
ENV JFSRV_NORMAL_PASSWORD java

ENV JFSRV_DEBUG_OUTPUT Console
ENV JFSRV_DEBUG_LOGPATH /jfileserver/logs/jfileserver.log

ENV JFSRV_LICENCE_PATH /jfileserver/licence/jfileserver.lic

# Run the file server java application
ENTRYPOINT ["/jfileserver/runsrv.sh"]
