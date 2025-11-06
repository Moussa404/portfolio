# Use PHP with Apache so public/ assets serve correctly
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite zip gd

# Enable Apache rewrite module for Laravel routes
RUN a2enmod rewrite

# Copy project files
COPY . .

# Copy Composer from official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Set proper permissions for storage and bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache || true

# Generate Laravel key if missing
RUN php artisan key:generate || true

# Expose port
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]
