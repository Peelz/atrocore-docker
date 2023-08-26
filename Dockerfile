FROM php:7.4-apache-bullseye

WORKDIR /var/www/atrocore

COPY ./skeleton-pim-no-demo/ /var/www/atrocore/

# Create system user to run Composer and Artisan Commands
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
  && docker-php-ext-install pdo_mysql mbstring zip pcntl sodium exif \
  && chown -R www-data:www-data /var/www/atrocore/ 

USER 1000

RUN php composer.phar self-update && php composer.phar update \
  && find . -type d -exec chmod 755 {} \; \
  && find . -type f -exec chmod 644 {} \; \
  && find client data custom upload -type d -exec chmod 775 {} \; \
  && find client data custom upload -type f -exec chmod 664 {} \; 

