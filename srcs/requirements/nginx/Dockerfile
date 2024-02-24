FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN mkdir -p /var/www/html

EXPOSE 443

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -keyout /etc/nginx/ssl/pedperei.key \
    -out /etc/nginx/ssl/pedperei.crt \
    -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=pedperei/CN=localhost/"

COPY /conf/default.conf /etc/nginx/default.d

CMD ["nginx", "-g", "daemon off;"]