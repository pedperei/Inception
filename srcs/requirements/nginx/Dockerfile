# Penultimate stable version of Debian
FROM debian:bullseye-slim

EXPOSE 443

# Install NGINX
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl

# Copy config file into the container
COPY ./conf/nginx.conf /etc/nginx/conf.d

# Copy .sh file into the container and give permissions
COPY ./tools/nginx.sh /home/nginx.sh
RUN chmod 777 /home/nginx.sh

# Start Nginx using the script
ENTRYPOINT ["/home/nginx.sh"]
