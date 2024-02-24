#!/bin/bash

echo "Init MariaDB config.."

if [ -d "/var/lib/mysql/$DB_NAME" ];

then
	echo "Database already exists."

else
	service mariadb start

	while ! mysqladmin ping -hlocalhost --silent; do
        sleep 1
    done

	mysql_secure_installation <<-INSTALLSQL

	Y
	$DB_ROOT_PASSWORD
	$DB_ROOT_PASSWORD
	Y
	Y
	Y
	Y
	INSTALLSQL

	mysql -u root <<-SQLCMDS
		CREATE DATABASE IF NOT EXISTS $DB_NAME;
		CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
		GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
		FLUSH PRIVILEGES;
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
		FLUSH PRIVILEGES;
	SQLCMDS

 	mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown

fi

echo "Database created"

exec "$@"
