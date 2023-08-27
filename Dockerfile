FROM php:7.4-apache-bullseye

WORKDIR /var/www/html

ENV COMPOSER_HOME=/.composer

COPY ./atrocore/composer.* /var/www/html/

RUN mkdir /.composer && chown -R 1000:1000 /.composer && apt-get update && apt install -y \
    git \
    libonig-dev \
    libzip-dev \
    zlib1g-dev \
    zip unzip \
    build-essential \
    locales \
    curl \
    libsodium-dev \
    libmagickwand-dev \
  && pecl install imagick \
  && docker-php-ext-install pdo_mysql mbstring zip pcntl sodium exif gd xml \
  && docker-php-ext-enable imagick \
  && php composer.phar self-update && php composer.phar update \
  && find . -type d -exec chmod 755 {} + \
  && find . -type f -exec chmod 644 {} + \
  && find client data custom upload -type d -exec chmod 775 {} + \
  && find client data custom upload -type f -exec chmod 664 {} + \
  && chown -R www-data:www-data /var/www/html \
  && chmod -R 777 /var/www/html

