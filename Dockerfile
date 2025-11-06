FROM php:8.2-apache

# Set the working directory for Laravel
WORKDIR /var/www/html

# Install system packages needed for Laravel + SQLite
RUN apt-get update && apt-get install -y \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_sqlite zip

# Enable Apache mod_rewrite for Laravel routes
RUN a2enmod rewrite

# Copy project files into the container
COPY . /var/www/html

# Set up Apache so the public folder is the web root
RUN sed -i 's#/var/www/html#/var/www/html/public#g' /etc/apache2/sites-available/000-default.conf

# Copy Composer from its image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Create the SQLite database if it doesn't exist
RUN mkdir -p database && touch database/database.sqlite && chmod 666 database/database.sqlite

# Generate Laravel key (ignore if already exists)
RUN php artisan key:generate || true

# Expose port 80 for Apache
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
