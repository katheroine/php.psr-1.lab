FROM php:8.4-apache

RUN apt-get update && apt-get install -y git

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY composer.json /var/www
COPY phpcs.xml /var/www/phpcs.xml

RUN composer install \
        --working-dir=/var/www \
        --no-interaction \
        --no-progress \
        --prefer-dist \
    && ln -s /var/www/vendor/bin/phpcs /usr/local/bin/phpcs \
    && ln -s /var/www/vendor/bin/phpcbf /usr/local/bin/phpcbf

RUN a2enmod rewrite

WORKDIR /var/www

EXPOSE 80
