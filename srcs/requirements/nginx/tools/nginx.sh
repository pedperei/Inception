#!/bin/bash

# Create directory for nginx pid file
mkdir -p /run/nginx

# Create SSL directory
mkdir -p /etc/nginx/ssl

# Check if SSL key and certificate already exist
if [ ! -f /etc/nginx/ssl/pedperei.crt ] || [ ! -f /etc/nginx/ssl/pedperei.key ]; then
    # Generate SSL certificate and key
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/pedperei.key -out /etc/nginx/ssl/pedperei.crt \
        -subj "/CN=localhost"

    # Set permissions for SSL certificates
    chmod 777 /etc/nginx/ssl/pedperei.crt /etc/nginx/ssl/pedperei.key

    echo "SSL certificate and key generated successfully."
else
    echo "SSL certificate and key already exist. Skipping generation."
fi

exec "$@"
