# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

# Expose port 9000 for the PHP FastCGI Process Manager
EXPOSE 9000

# Update the package lists and install necessary packages
# curl: tool for transferring data with URLs
# mariadb-client: MariaDB database client, for interacting with MariaDB databases
# php-fpm: PHP FastCGI Process Manager, for handling PHP requests
# php-mysql: PHP extension for MySQL database access
RUN apt-get update && apt-get install -y \
    curl \
    mariadb-client \
    php-fpm \
    php-mysql 

# Copy the WordPress configuration file into the PHP configuration directory in the Docker image
COPY ./conf/wordpress.conf /etc/php/7.4/fpm/pool.d/wordpress.conf

# Create the directory for the PHP FastCGI Process Manager's PID file and set its permissions
RUN mkdir /run/php/ && chmod 777 /run/php/

# Copy the configuration script into the Docker image and set its permissions
COPY ./tools/config.sh /home/config.sh
RUN chmod 777 /home/config.sh

# Set the configuration script as the entrypoint, i.e., the command that will be run when the Docker container is started
ENTRYPOINT ["/home/config.sh"]
