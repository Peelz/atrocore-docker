FROM php:7.4-apache-bullseye

COPY ./atrocore/composer.json /var/www/atrocore/

WORKDIR /var/www/atrocore

RUN apt-get update && apt install -y libmcrypt-dev\
  && docker-php-ext-install pdo pdo_mysql curl gd mbstring xml zip \
  && docker-php-ext-enable mcrypt imagick \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=compose \
  && composer self-update && composer update \
  && chown -R www-data:www-data /var/www/atrocore/ \
  && a2enmod rewrite
  # && find . -type d -exec chmod 755 {} + && find . -type f -exec chmod 644 {} +; \
  # && find client data custom upload -type d -exec chmod 775 {} + && find client data custom upload -type f -exec chmod 664 {} + 

