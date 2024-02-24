FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    php \
    php-fpm \
    php-mysql \
    php-opcache \
    php-xml \
    php-gd \
    php-curl \
    php-mbstring \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php/ && chmod 755 /run/php/

RUN sed -i 's+listen = /run/php/php7.4-fpm.sock+listen = 9000+g' /etc/php/7.4/fpm/pool.d/www.conf


COPY ./conf/wp_conf.sh /home
RUN chmod +x /home/wp_conf.sh

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT ["/home/wp_conf.sh"]

CMD ["php-fpm7.4", "-F", "-R"]