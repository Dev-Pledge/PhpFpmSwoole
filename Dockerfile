FROM php:7.4.1-fpm

WORKDIR /var/www

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN apt-get update && apt-get install -y git \
    && apt-get install --yes zip unzip \
    libssl-dev --no-install-recommends \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get update && apt-get install -y git curl libmcrypt-dev default-mysql-client \
    && docker-php-ext-install pdo_mysql

RUN apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev

RUN docker-php-ext-configure gd \
    && docker-php-ext-install gd

RUN pecl install swoole

RUN docker-php-ext-install exif

RUN docker-php-ext-enable swoole

RUN apt-get install -q -y msmtp mailutils

RUN apt-get install -y cron

RUN docker-php-ext-install bcmath

RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql


