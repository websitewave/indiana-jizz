FROM php:8.0-fpm

# Устанавливаем необходимые пакеты и расширения PHP
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libtidy-dev \
    libxslt1-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    mysqli \
    pdo \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    intl \
    soap \
    zip \
    xsl \
    tidy \
    opcache

# Копируем кастомный php.ini
COPY php.ini /usr/local/etc/php/

USER root

RUN mkdir -p /var/www/html

# Установка прав доступа для директории
RUN find /var/www/html -type d -exec chmod 755 {} \; && \
    find /var/www/html -type f -exec chmod 644 {} \; && \
    chown -R www-data:www-data /var/www/html

# Настройка рабочей директории
WORKDIR /var/www/html