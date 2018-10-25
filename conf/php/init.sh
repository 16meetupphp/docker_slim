#!/bin/sh

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
adduser -s /bin/bash -u $USER_ID -D -h /var/www/ meet
export HOME=/var/www/

cd $HOME
chmod -R 777 logs
if [ ! -e "/var/www/composer.lock" ]
then
    composer update
fi

exec php "$@"