# Stage 1: Build Composer dependencies
FROM composer:2 AS vendor

WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Stage 2: Laravel App with PHP + Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install required PHP extensions and tools
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite zip gd

# Enable Apache mod_rewrite for Laravel routes
RUN a2enmod rewrite

# Copy the Laravel app files
COPY . .

# Copy vendor dependencies from builder stage
COPY --from=vendor /app/vendor ./vendor

# Set correct permissions for Laravel
RUN chmod -R 775 storage bootstrap/cache || true

# Generate Laravel key if missing
RUN php artisan key:generate || true

# Expose Apache port
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]
