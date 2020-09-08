FROM php:7.1-fpm

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++ libxml2-dev
RUN apt-get install -y libmemcached-dev
RUN apt install -y libmcrypt-dev
RUN apt-get install -y libxslt-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install opcache && docker-php-ext-enable opcache
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl soap xml
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd
RUN pecl install memcached
RUN docker-php-ext-enable memcached
RUN pecl install apcu && docker-php-ext-enable apcu
RUN docker-php-ext-configure mcrypt
RUN docker-php-ext-install mcrypt && docker-php-ext-enable mcrypt
RUN docker-php-ext-install xsl && docker-php-ext-enable xsl
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install bcmath && docker-php-ext-enable bcmath
RUN docker-php-ext-install sockets && docker-php-ext-enable sockets


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN yes | pecl install xdebug

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
