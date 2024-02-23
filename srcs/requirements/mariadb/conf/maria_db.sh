#!/bin/bash

echo "Entering MariaDB configuration process.."

# Check if the database directory exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists."
else
    # Start MariaDB service using systemctl
    systemctl start mariadb

    # Wait for MariaDB to start
    while ! systemctl is-active --quiet mariadb; do
        sleep 1
    done

    # Run secure installation script non-interactively
    mysql_secure_installation <<-SECURE_INSTALL
Y
$MYSQL_ROOT_PASS
$MYSQL_ROOT_PASS
Y
Y
Y
Y
SECURE_INSTALL

    # Sleep for 1 second
    sleep 1

    # Run SQL commands
    mysql -u root <<-SQL_COMMANDS
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS';
FLUSH PRIVILEGES;
SQL_COMMANDS

    # Stop MariaDB service using systemctl
    systemctl stop mariadb

    # Sleep for 1 second
    sleep 1

    echo "MariaDB configuration process completed."
fi

# Execute any additional commands passed to the script
exec "$@"
