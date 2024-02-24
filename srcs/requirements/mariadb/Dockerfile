# Use a minimal Debian Bullseye image
FROM debian:bullseye-slim

# Update the package repository and install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

# Copy the custom MariaDB initialization script to the home directory
COPY /conf/maria_db.sh /home

# Give execute permissions to the MariaDB initialization script
RUN chmod 777 /home/maria_db.sh

# Initialize MariaDB database
RUN mysql_install_db

# Expose the default MariaDB port
EXPOSE 3306

# ENTRYPOINT sets the main command to be executed when the container starts.
# The provided script at /home/maria.sh will be the entry point
ENTRYPOINT ["/home/maria_db.sh"]

# Define default arguments for the entry point or the command to be executed
# If no specific command is provided during container runtime, this defaults to starting the MariaDB server
# The bind address is configured to allow external connections (0.0.0.0)
# mysqld_safe is a script provided by MariaDB that is designed to start and monitor the mysqld process.
CMD ["mysqld_safe", "--bind-address=0.0.0.0"]

