FROM alpine:latest
RUN apk add --no-cache php8 php8-fpm php8-mysqli php8-pdo_mysql
RUN docker-php-ext-install mysqli pdo pdo_mysql
COPY php-fpm.d/www.conf /etc/php8/php-fpm.d/www.conf
EXPOSE 9000
CMD ["php-fpm8", "--nodaemonize"]