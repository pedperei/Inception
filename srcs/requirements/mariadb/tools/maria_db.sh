#!/bin/bash

# Print initial message
echo "Init MariaDB config.."

# Check if the database already exists
if [ -d "/var/lib/mysql/$DB_NAME" ];
then
    # If the database exists, print a message and skip the rest
    echo "Database already exists."
else
    # If the database doesn't exist, start the MariaDB service
    mysqld_safe &

    # Wait until the MariaDB service is up and running
    while ! mysqladmin ping -hlocalhost --silent; do
        sleep 1
    done

    # Secure the MariaDB installation
    mysql_secure_installation <<-INSTALLSQL
    Y
    $DB_ROOT_PASSWORD
    $DB_ROOT_PASSWORD
    Y
    Y
    Y
    Y
INSTALLSQL

    # Log into MariaDB as root and run SQL commands
    mysql -u root <<-SQLCMDS
        # Create the database if it doesn't exist
        CREATE DATABASE IF NOT EXISTS $DB_NAME;
        # Create the user if they don't exist
        CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
        # Grant all privileges on the database to the user
        GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
        # Reload the privilege tables
        FLUSH PRIVILEGES;
        # Change the root password
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
        # Reload the privilege tables again
        FLUSH PRIVILEGES;
SQLCMDS

     # Shutdown the MariaDB service
    mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown
fi

# Print final message
echo "Database created"

# mysqld_safe is a script provided by MariaDB that is designed to start and monitor the mysqld process
# The bind address is configured to allow external connections (0.0.0.0)
mysqld_safe --bind-address=0.0.0.0

# Execute any additional commands passed to the script
exec "$@"