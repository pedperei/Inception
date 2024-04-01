# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

# Expose port 443 in the container
EXPOSE 443

# Update the package lists, upgrade all packages, and install NGINX and OpenSSL
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl

# Copy the NGINX configuration file from the host to the container
COPY ./conf/nginx.conf /etc/nginx/conf.d

# Copy the shell script from the host to the container
COPY ./tools/nginx.sh /home/nginx.sh
# Change the permissions of the shell script to make it executable
RUN chmod 777 /home/nginx.sh

# Specify the entrypoint script to run when the container starts
ENTRYPOINT ["/home/nginx.sh"]