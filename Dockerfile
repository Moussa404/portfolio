# Stage 1: Build Composer dependencies
FROM composer:2 AS vendor

WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --prefer-dist --optimize-autoloader --no-interaction

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

# Copy application source and vendor files
COPY . .
COPY --from=vendor /app/vendor ./vendor

# Ensure Laravel directories are writable
RUN chmod -R 775 storage bootstrap/cache || true

# Generate key if missing (safe to fail if exists)
RUN php artisan key:generate || true

RUN php artisan config:clear || true && php artisan cache:clear || true && php artisan view:clear || true


# Expose port 8080 (for Railway)
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]
