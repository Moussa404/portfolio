# Use official PHP + Apache image
FROM php:8.2-apache

# Point Apache DocumentRoot to Laravel's /public directory
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Set working directory
WORKDIR /var/www/html

# Install required system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite zip gd

# Enable Apache mod_rewrite for Laravel routes
RUN a2enmod rewrite

# Copy project files into container
COPY . .

# Ensure Laravel storage and cache directories are writable
RUN chmod -R 775 storage bootstrap/cache || true

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies (no dev, optimized for production)
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

# Generate Laravel app key if missing (won’t fail if already exists)
RUN php artisan key:generate || true

# Clear old caches to ensure fresh .env and paths are used
RUN php artisan config:clear || true && php artisan optimize:clear || true && php artisan view:clear || true

# Expose port 8080 for Railway
EXPOSE 8080

# Start Apache web server
CMD ["apache2-foreground"]
