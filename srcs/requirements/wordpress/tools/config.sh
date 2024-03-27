#!/bin/bash

sleep 5

echo "Configuring WordPress..."

# if wp-config already exists
if [ -e "/var/www/html/wp-config.php" ]; then
    echo "WordPress already installed"
    exec "$@"
fi

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp


if wp --info &> /dev/null; then \
        echo "WP-CLI was installed successfully."; \
    else \
        echo "WP-CLI installation failed."; \
        exit 1; \
    fi

cd "$WP_PATH"

# Set up WordPress
wp core download --version=5.9.3 --force --allow-root


wp config create --allow-root \
                --dbname=$DB_NAME \
                --dbuser=$DB_USER \
                --dbpass=$DB_PASSWORD \
                --dbhost=$DB_HOST \
                --path=$WP_PATH

wp core install --allow-root \
               --url="$WP_URL" \
               --title="$WP_TITLE" \
               --admin_user="$WP_ADMIN_USER" \
               --admin_password="$WP_ADMIN_PASSWORD" \
               --admin_email="$WP_ADMIN_EMAIL" \


chown -R www-data:www-data /var/www/html

echo "WordPress installed and configured successfully"

exec "$@"