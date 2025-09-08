FROM php:8.2-fpm

# -------------------
# Installer dépendances et extensions PHP nécessaires
# -------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    zip unzip curl bash git libzip-dev libonig-dev libicu-dev \
    libpng-dev libjpeg-dev libfreetype6-dev libxml2-dev libcurl4-openssl-dev \
    libkrb5-dev libssl-dev \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) \
        mysqli pdo pdo_mysql zip intl opcache calendar gd bcmath soap \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# -------------------
# Configurer OPCache
# -------------------
RUN echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo "opcache.interned_strings_buffer=8" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo "opcache.max_accelerated_files=4000" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo "opcache.revalidate_freq=2" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo "opcache.validate_timestamps=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
 && echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

WORKDIR /var/www/html
EXPOSE 80
