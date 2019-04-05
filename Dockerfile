FROM php:7.3.3-fpm

WORKDIR /var/www

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN apt-get update && apt-get install -y git \
    && apt-get install --yes zip unzip \
    mysql-client libssl-dev --no-install-recommends \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && docker-php-ext-install pdo_mysql

RUN apt-get install php7.3-gd

RUN pecl install swoole

RUN docker-php-ext-enable swoole

RUN apt-get install -q -y ssmtp mailutils

RUN apt-get install -y cron
