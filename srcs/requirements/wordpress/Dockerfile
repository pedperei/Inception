# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

EXPOSE 9000

# Install php
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    mariadb-client \
    curl

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Create the directory for pid file
RUN mkdir /run/php/ && chmod 777 /run/php/

COPY ./tools/config.sh /home/config.sh
RUN chmod 777 /home/config.sh

ENTRYPOINT ["/home/config.sh"]

CMD ["php-fpm7.4", "-F"]
