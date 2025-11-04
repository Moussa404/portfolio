# Use official PHP image with Apache (better for web apps)
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install required system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    unzip \
    libzip-dev \
    sqlite3 \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite zip

# Enable Apache mod_rewrite (needed for Laravel routing)
RUN a2enmod rewrite

# Copy Composer from official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Create SQLite database file with proper permissions
RUN mkdir -p database && touch database/database.sqlite && chmod 666 database/database.sqlite

# Install PHP dependencies (optimized for production)
RUN composer install --no-dev --optimize-autoloader

# Generate Laravel app key if missing
RUN php artisan key:generate || true

# Set permissions for Laravel storage and bootstrap cache
RUN chmod -R 777 storage bootstrap/cache

# Expose port (Render uses 10000)
EXPOSE 10000

# Start Laravel via Artisan serve
CMD php artisan serve --host=0.0.0.0 --port=10000
