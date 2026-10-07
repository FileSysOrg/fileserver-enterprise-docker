# JFileServer-Enterprise Docker Sample

This sample demonstrates how to run JFileServer-Enterprise using Docker.

The sample setup includes three shared filesystems :-
- Using a local folder
  
  Share name _jfileshare_

  Uses the _org.filesys.smb.server.disk.JavaNIODiskDriver_ filesystem driver

- Using the database filesystem with a local folder for file data

  Share name _dbshare_

  Uses the _org.filesys.server.filesys.db.DBDiskDriver_ filesystem driver with a PostGres database. The file data
  is stored in a local folder with the file/folder metadata stored in a database.

- Using the database filesystem with file data stored in database blob fields

  Share name _dbblob_

  Uses the _org.filesys.server.filesys.db.DBDiskDriver_ filesystem driver with a PostGres database. The file data
  and file/folder metadata are stored in the database.

The JFileServer-Enterprise sample includes a trial licence allowing up to 5 users. If you require a larger licence key
for testing email [info@filesys.org](mailto:info@filesys.org).

## Configuring the Docker sample

Firstly, download the sample [docker-compose.yml](docker-compose.yml) file.

Edit the _docker-compose.yml_ file and set the volume mapping for the local host folder to be shared by the file server.

    volumes:
      - <MAP-TO-A-LOCAL-FOLDER>:/jfileserver/fileShare

The file server can be configured using environment variables. The following table shows the environment variables that
can be overridden, and their default values :-

| Variable Name         | Description                                        |Default Value|
|-----------------------|----------------------------------------------------|--|
| JFSRV_SMB_ENABLE      | Enable the SMB server                              |true
| JFSRV_FTP_ENABLE      | Enable the FTP server                              |false
| JFSRV_NFS_ENABLE      | Enable the NFS server                              |false
| JFSRV_SMB_SERVERNAME  | Name of the SMB server, for NetBIOS connections    |jfilesrv
| JFSRV_SMB_DOMAIN      | Domain or workgroup that the SMB server belongs to |domain
| JFSRV_SMB_DIALECTS    | SMB dialects that the SMB server will negotiate    |SMB2,SMB3
| JFSRV_SMB_DEBUGFLAGS  | SMB debug flags                                    |Negotiate,Socket,State,Error,File,Info
| JFSRV_FTP_PORT        | Port that the FTP server listens on                |21
| JFSRV_FTP_DEBUGFLAGS  | FTP debug flags                                    |File,Search,Error,DataPort,Directory
| JFSRV_NFS_DEBUGFLAGS  | NFS debug flags                                    |File,FileIO
| JFSRV_SHARE_NAME      | Shared filesystem name                             |jfileshare
| JFSRV_SHARE_PATH      | Path to the shared filesystem data                 |/jfileserver/fileShare
| JFSRV_SHARE_COMMENT   | Comment for the shared filesystem                  |Test shared filesystem
| JFSRV_DBSHARE_NAME    | Name of the database share                         |dbshare
| JFSRV_DBSHARE_PATH    | Path to the database share data                    |/jfileserver/dbshare
| JFSRV_ADMIN_USER      | Administrator user name                            |admin
| JFSRV_ADMIN_PASSWORD  | Administrator user password                        |jfilesrv
| JFSRV_NORMAL_USER     | Normal user name                                   |user
| JFSRV_NORMAL_PASSWORD | Normal user password                               |java
| JFSRV_DEBUG_OUTPUT    | Debug output destination, 'File' or 'Console'      |Console
| JFSRV_DEBUG_LOGPATH   | Log file path when using 'File' debug output       |/jfileserver/logs/jfileserver.log
| JFSRV_LICENCE_PATH    | Path to the licence file                           |/jfileserver/licence/jfileserver.lic

## Starting the file server

To start the file server, run the following command:

docker-compose up

