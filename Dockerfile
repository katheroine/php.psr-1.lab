FROM php:8.4-apache

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . .

RUN composer require \
        --dev \
        --no-interaction \
        --no-progress \
        --prefer-dist \
        squizlabs/php_codesniffer \
    && composer install \
        --no-interaction \
        --no-progress \
        --prefer-dist \
    && ln -s /var/www/vendor/bin/phpcs /usr/local/bin/phpcs \
    && ln -s /var/www/vendor/bin/phpcbf /usr/local/bin/phpcbf

COPY docker/apache/site.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

USER www-data
EXPOSE 80
