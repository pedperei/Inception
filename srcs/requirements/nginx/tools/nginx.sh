#!/bin/bash

# Create a directory for the Nginx PID file if it doesn't already exist
mkdir -p /run/nginx

# Create a directory for the SSL certificate and key if it doesn't already exist
mkdir -p /etc/nginx/ssl

# Check if the SSL certificate and key already exist
if [ ! -f /etc/nginx/ssl/pedperei.crt ] || [ ! -f /etc/nginx/ssl/pedperei.key ]; then
    # If they don't exist, generate a new SSL certificate and key using OpenSSL
    # The certificate is valid for 365 days and uses a 2048-bit RSA key
    # The subject of the certificate is set to localhost
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/pedperei.key -out /etc/nginx/ssl/pedperei.crt \
        -subj "/CN=localhost"

    # Set the permissions for the SSL certificate and key to be readable, writable, and executable by all users
    chmod 777 /etc/nginx/ssl/pedperei.crt /etc/nginx/ssl/pedperei.key

    # Print a message indicating that the SSL certificate and key were generated successfully
    echo "SSL certificate and key generated successfully."
else
    # If the SSL certificate and key already exist, print a message and skip the generation step
    echo "SSL certificate and key already exist. Skipping generation."
fi

# Execute the command that was passed to the script
exec "$@"