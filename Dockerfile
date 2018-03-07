FROM php:7.2.1-fpm

WORKDIR /var/www

RUN apt-get update && apt-get install -y git \
    && apt-get install --yes zip unzip \
    mysql-client libssl-dev --no-install-recommends \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && docker-php-ext-install pdo_mysql

RUN pecl install swoole

RUN docker-php-ext-enable swoole
