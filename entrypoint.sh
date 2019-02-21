#!/bin/bash

# Set user Password
if [[ ! -z $ROOT_PASSWORD ]]; then

  $(echo 'root:'$ROOT_PASSWORD | chgpasswd)

fi


# Check if username and password are set, if is check for alternative user folder.
if [[ ! -z $USER_NAME ]] && [[ ! -z  $USER_PASSWORD ]]; then
  
  if [[ ! -z $USER_FOLDER ]]; then

    $(mkdir -p $USER_FOLDER)
    $(useradd $USER_NAME -p $USER_PASSWORD -d $USER_FOLDER --shell /bin/bash)

  else

    $(useradd $USER_NAME -p $USER_PASSWORD -m --shell /bin/bash)

  fi
fi  

exec "$@" 
