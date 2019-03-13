#!/bin/bash

# Set user Password
if [[ ! -z $ROOT_PASSWORD ]]; then

  $(echo -e "$ROOT_PASSWORD\n$ROOT_PASSWORD" | passwd  root  2> /dev/null)

fi


# Check if username and password are set, if is check for alternative user folder.
if [[ ! -z $USER_NAME ]] && [[ ! -z  $USER_PASSWORD ]]; then
  
  if [[ ! -z $USER_FOLDER ]]; then

    $(mkdir -p $USER_FOLDER)
    $(useradd $USER_NAME -d $USER_FOLDER --shell /bin/bash)
    $(echo -e "$USER_PASSWORD\n$USER_PASSWORD" | passwd $USER_NAME )

  else

    $(useradd $USER_NAME -d $USER_FOLDER --shell /bin/bash)
    $(echo -e "$USER_PASSWORD\n$USER_PASSWORD" | passwd $USER_NAME )

  fi
fi  

exec "$@" 
