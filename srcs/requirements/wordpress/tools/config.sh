#!/bin/bash

# Pause the script for 5 seconds
sleep 5

echo "Configuring WordPress..."

# Check if WordPress is already installed
if [ -e "/var/www/html/wp-config.php" ]; then
    echo "WordPress already installed"
    # Execute any arguments to the script
    exec "$@"
else

    # Download WP-CLI, make it executable, and move it to /usr/local/bin
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

    # Check if WP-CLI was installed successfully
    if wp --info &> /dev/null; then \
            echo "WP-CLI was installed successfully."; \
        else \
            echo "WP-CLI installation failed."; \
            # Exit the script with a non-zero status code
            exit 1; \
        fi

    # Change to the WordPress directory
    cd "$WP_PATH"

    # Download WordPress
    wp core download --version=5.9.3 --force --allow-root

    # Create the WordPress configuration file
    wp config create --allow-root \
                    --dbname=$DB_NAME \
                    --dbuser=$DB_USER \
                    --dbpass=$DB_PASSWORD \
                    --dbhost=$DB_HOST \
                    --path=$WP_PATH \

    # Install WordPress
    wp core install --allow-root \
                --url="$WP_URL" \
                --title="$WP_TITLE" \
                --admin_user="$WP_ADMIN_USER" \
                --admin_password="$WP_ADMIN_PASSWORD" \
                --admin_email="$WP_ADMIN_EMAIL" \

    # Change the owner of the WordPress files to www-data
    chown -R www-data:www-data /var/www/html

fi

# Start PHP FastCGI Process Manager
php-fpm7.4 -F

# Execute any arguments to the script
exec "$@"