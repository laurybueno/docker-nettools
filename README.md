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


If  needs, you can change the root password, or add a one user using environment variables.  
```
ROOT_PASSWORD (optional): change root password

USER_NAME: name of new user to be created 

USER_PASSWORD: password of user to be created

USER_FOLDER (optional): path da home do novo usuário
```
**Creating User**

When you create a user, the USER_NAME variable can not be null, or user not be created, if you don't define password the default password of user will be 'hacklab'

**User home Folder**

If not set USER_FOLDER, a new user will be created in /home, but if you need a diferent home folder for user, you need to specify a complete location like: '/tmp/john' and if not exist, will created and map to your user.

Ex:

`docker run  --name tools  -e ROOT_PASSWORD=hackerone -e USER_NAME=hacklab -e USER_PASSWORD=12345678  -it hacklab/docker-nettools:latest bash`

The command create user 'hacklab' with password '12345678' and home at **'/home/hacklab'**  

Ex:

`docker run  --name tools  -e ROOT_PASSWORD=hackerone -e USER_NAME=hacklab -e USER_PASSWORD=12345678 -e USER_FOLDER='opt/hacklab' -it hacklab/docker-nettools:latest bash`

The command create user 'hacklab' with password '12345678' and home set to folder **'opt/hacklab'**
