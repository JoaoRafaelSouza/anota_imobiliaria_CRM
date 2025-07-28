FROM php:8.2-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
    unzip \
    nano \
    curl \
    git \
    libzip-dev \
    zip \
    && docker-php-ext-install zip

RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

RUN echo '<Directory /var/www/html/>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
    </Directory>' > /etc/apache2/conf-available/override.conf && \
    a2enconf override

RUN echo "xdebug.mode=debug\n\
    xdebug.start_with_request=yes\n\
    xdebug.client_host=host.docker.internal\n\
    xdebug.client_port=9003\n\
    xdebug.log=/tmp/xdebug.log" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini