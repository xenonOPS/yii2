#!/bin/bash

sed -i "s|'username' => 'DB_USER'|'username' => '$DB_USER'|g" /var/www/html/app/config/db.php
sed -i "s|'mysql:host=localhost;dbname=DB_NAME',|'mysql:host=$DB_HOST;dbname=$DB_NAME',|g" /var/www/html/app/config/db.php
sed -i "s|'password' => 'DB_PASSWORD',|'password' => '$DB_PASS',|g" /var/www/html/app/config/db.php
sed -i "s|'cookieValidationKey' => '',|'cookieValidationKey' => '0eb52fbc9b320f5bb527',|g" app/config/web.php

chmod 777 /var/www/html/runtime -R
chmod 777 /var/www/html/assets -R 
chmod 777 /var/www/html/uploads -R 


# ##### removal of any existing files #####
# ##### checking if the directory is empty #####

if [ $RUN_SERVICE == "fpm" ]
then 
        /var/www/html/yii migrate
    fi
fi 
    

