# Use a minimal Debian Bullseye image
FROM debian:bullseye-slim

# Expose the default MariaDB port
EXPOSE 3306

# Update the package repository and install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

# Copy the custom MariaDB initialization script to the home directory
COPY /tools/maria_db.sh /home

# Give execute permissions to the MariaDB initialization script
RUN chmod 777 /home/maria_db.sh

# CMD sets the main command to be executed when the container starts.
CMD ["/home/maria_db.sh"]