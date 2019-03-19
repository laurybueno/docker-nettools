#!/bin/bash

# Set user Password
if [[ ! -z $ROOT_PASSWORD ]]; then

  $(echo -e "$ROOT_PASSWORD\n$ROOT_PASSWORD" | passwd  root  2> /dev/null)

fi

# Enable Apache www-data user shell
if [[ $USER_APACHE == True ]]; then
  
  $(mkdir -p /var/www/html)
  $(usermod -d /var/www/html --shell /bin/bash www-data)
  
  if [[ ! -z $APACHE_PASSWORD ]]; then
  $(echo -e "$APACHE_PASSWORD\n$APACHE_PASSWORD" | passwd  www-data  2> /dev/null)
  fi 
fi

# Check if username and password are set, if is check for alternative user folder.
if [[ ! -z $USER_NAME ]] && [[ ! -z  $USER_PASSWORD ]]; then
  
  # check User ID, Group ID and Folder are Set

  if [[ ! -z $USER_ID ]] && [[ ! -z  $GROUP_ID ]] && [[ ! -z $USER_FOLDER ]]; then

    $(mkdir -p $USER_FOLDER)
    $(groupadd $GROUP_ID)
    $(useradd $USER_NAME -p $USER_PASSWORD -u $USER_ID -d $USER_FOLDER --shell /bin/bash)
    $(groupmod -g $GROUP_ID $USER_NAME)

  # check User ID  and Group ID are Set
  elif [[ ! -z $USER_ID ]] && [[ ! -z  $GROUP_ID ]]; then
	  
    $(groupadd $GROUP_ID)
    $(useradd $USER_NAME -p $USER_PASSWORD -u $USER_ID --shell /bin/bash)
    $(groupmod -g $GROUP_ID $USER_NAME)

  # check if only alternative Folder are Set.
  elif [[ ! -z $USER_FOLDER ]]; then

    $(mkdir -p $USER_FOLDER)
    $(useradd $USER_NAME -p $USER_PASSWORD -d $USER_FOLDER --shell /bin/bash)

  else

    $(useradd $USER_NAME -p $USER_PASSWORD -m --shell /bin/bash)

  fi

fi  

exec "$@" 
