FROM php:8.2-apache

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_sqlite zip

RUN a2enmod rewrite

COPY . /var/www/html

RUN sed -i 's#/var/www/html#/var/www/html/public#g' /etc/apache2/sites-available/000-default.conf

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader

# Create database and fix permissions for Laravel writable directories
RUN mkdir -p database storage/logs bootstrap/cache && \
    touch database/database.sqlite && chmod -R 777 storage bootstrap/cache database

# Generate Laravel key (ignore if already exists)
RUN php artisan key:generate || true

EXPOSE 80
CMD ["apache2-foreground"]
