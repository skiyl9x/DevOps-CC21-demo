FROM php:7-fpm
RUN apt-get update && \
    apt-get install zlib1g-dev libpng-dev libcurl4-openssl-dev libxml2-dev libonig-dev libzip-dev -y && \
    docker-php-ext-install mysqli gd curl dom exif fileinfo json mbstring xml zip && \
    docker-php-ext-enable mysqli gd curl dom exif fileinfo json mbstring xml zip
