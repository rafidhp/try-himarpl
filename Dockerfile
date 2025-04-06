# Gunakan image PHP dengan Apache
FROM php:8.2-apache

# Install dependency
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy semua project ke folder kerja di container
COPY . /var/www/html/

COPY ./apache.conf /etc/apache2/sites-available/000-default.conf

RUN composer install --no-dev --optimize-autoloader
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Set permission folder Laravel
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite


# Expose port 80
EXPOSE 80
