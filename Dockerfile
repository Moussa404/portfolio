# Use official PHP image with Apache (auto serves /public)
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_sqlite zip

# Enable Apache rewrite module (for Laravel routing)
RUN a2enmod rewrite

# Copy project files
COPY . .

# Copy the Laravel public folder to Apache root
COPY ./public /var/www/html/

# Set up Apache virtual host for Laravel
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html\n\
    <Directory /var/www/html>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Generate Laravel key if missing
RUN php artisan key:generate || true

# Create SQLite database if missing
RUN mkdir -p database && touch database/database.sqlite && chmod 666 database/database.sqlite

# Expose port 80
EXPOSE 80

# Run Apache with Laravel's /public as the web root
CMD rm -rf /var/www/html && \
    cp -r /opt/render/project/src /var/www/html && \
    sed -i 's#/var/www/html#/var/www/html/public#g' /etc/apache2/sites-available/000-default.conf && \
    apache2-foreground
