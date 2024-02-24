# Penultimate stable version of Debian
FROM debian:bullseye-slim

EXPOSE 443

# Install NGINX
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl

# Create directory for nginx pid file
RUN mkdir -p /run/nginx

# Create SSL certificate and key
RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/pedperei.key -out /etc/nginx/ssl/pedperei.crt \
    -subj "/CN=localhost"

# Set permissions for SSL certificates
RUN chmod 777 /etc/nginx/ssl/pedperei.crt /etc/nginx/ssl/pedperei.key

# Copy config file into the container
COPY ./conf/nginx.conf /etc/nginx/conf.d


#Start Nginx
CMD ["nginx", "-g", "daemon off;"]
