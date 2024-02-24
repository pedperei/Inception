#!/bin/bash

sleep 5

echo "Configuring WordPress..."

# if wp-config already exists
if [ -e "/var/www/html/wp-config.php" ]; then
    echo "WordPress already installed"
    exec "$@"
fi

cd "$WP_PATH"

# Set up WordPress
wp core download --allow-root \


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

wp user create --allow-root \
                "$WP_SECOND_USER" \
                "$WP_SECOND_USER_EMAIL" \
                --role=author \
                --user_pass="$WP_SECOND_USER_PASSWORD" \


chown -R www-data:www-data /var/www/html

echo "WordPress installed and configured successfully"

exec "$@"