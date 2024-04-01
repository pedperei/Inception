# Use a minimal Debian Bullseye image
FROM debian:bullseye-slim

# Update the package repository and install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

# Copy the custom MariaDB initialization script to the home directory
COPY /tools/maria_db.sh /home

# Give execute permissions to the MariaDB initialization script
RUN chmod 777 /home/maria_db.sh

# Initialize MariaDB database
RUN mysql_install_db

# Expose the default MariaDB port
EXPOSE 3306

# ENTRYPOINT sets the main command to be executed when the container starts.
# The provided script at /home/maria.sh will be the entry point
ENTRYPOINT ["/home/maria_db.sh"]
