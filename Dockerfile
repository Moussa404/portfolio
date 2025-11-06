# Use official PHP image with Apache
FROM php:8.2-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    sqlite3 \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite pdo_mysql

# Enable Apache mod_rewrite for Laravel routes
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy all project files into the container
COPY . .

# Set correct permissions for Laravel storage and cache
RUN chmod -R 777 storage bootstrap/cache

# Configure Apache to serve Laravel's public folder
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]