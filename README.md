# docker-nettools

Basic network tools in a Docker image ([hacklab/docker-nettools](https://hub.docker.com/r/hacklab/docker-nettools/)). Built to be used in pipelines for Continuous Integration.

Available software:
- openssh 
- nmap 
- curl 
- tcpdump 
- wget 
- rsync

# Environment variables


If  needs, you can change the root password, or add a one user using environment variables and specify UID and GID.  
```
ROOT_PASSWORD (optional): change root password

USER_NAME: name of new user to be created 

USER_PASSWORD: password of user to be created

USER_FOLDER (optional): path da home do novo usuário

USER_ID (optional): set UID of new user to be created

GROUP_ID (optional): set GID of new user to be created
```

**Creating User**

When you create a user, the USER_NAME variable can not be null, or user not be created, if you don't define password the default password of user will be 'hacklab'

**User ID and Group ID**

When you set environment variables USER_ID and GROUP_ID, the new user will be crated respecting this attributes, if UID or GID conflicting with any UID or GID used by sistem accounts (like 33 used by apache or 101, used by systemd) user will not be created.


**User home Folder**

If not set USER_FOLDER, a new user will be created in /home, but if you need a diferent home folder for user, you need to specify a complete location like: '/tmp/john' and if not exist, will created and map to your user.

Ex:

`docker run  --name tools  -e ROOT_PASSWORD=hackerone -e USER_NAME=hacklab -e USER_PASSWORD=12345678  -it hacklab/docker-nettools:latest bash`

The command create user 'hacklab' with password '12345678' and home at **'/home/hacklab'**  

Ex:

`docker run  --name tools  -e ROOT_PASSWORD=hackerone -e USER_NAME=hacklab -e USER_PASSWORD=12345678 -e USER_FOLDER='opt/hacklab' -it hacklab/docker-nettools:latest bash`

The command create user 'hacklab' with password '12345678' and home set to folder **'opt/hacklab'**


Ex:

`docker run  --name tools  -e ROOT_PASSWORD=hackerone -e USER_NAME=hacklab -e USER_PASSWORD=12345678 -e USER_ID=2000 GROUP_ID=2002  -e USER_FOLDER='/opt/hacklab' -it hacklab/docker-nettools:latest bash`

The command create user 'hacklab' with password '12345678' with **UID 2000**, **GID 2002** and home set to folder **'opt/hacklab'**

# Enable Apache User.

Apache user (www-data), is used to control web files or manage a features, but this user is deactivated by default, in special cases we need use then.

To enable www-data as a valid user in system use: 

```
APACHE_USER=True: Enable apache www-data and set as valid user in system.
APACHE_PASSWORD (optional): Set password for www-data user.
```
When you enable www-data user, a folder /var/www/html is enabled to, if not exists will be created an seted as home folder of www-data user.
