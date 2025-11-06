# ----------------------------
# Stage 1: Composer dependencies
# ----------------------------
FROM composer:2 AS vendor

WORKDIR /app
COPY composer.json composer.lock ./

# safer, lighter install for limited environments
RUN COMPOSER_MEMORY_LIMIT=-1 composer install \
    --no-dev \
    --no-scripts \
    --ignore-platform-reqs \
    --prefer-dist \
    --no-interaction \
    --optimize-autoloader


# ----------------------------
# Stage 2: PHP + Apache server
# ----------------------------
FROM php:8.2-apache
ENV HTTPS_PROXY="on"

# Point Apache to Laravel's public folder
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Working directory inside container
WORKDIR /var/www/html

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite zip gd

# Enable Laravel's route rewriting
RUN a2enmod rewrite

# Copy all project files
COPY . .

# Copy vendor dependencies from the Composer stage
COPY --from=vendor /app/vendor ./vendor

# Fix permissions
RUN chmod -R 775 storage bootstrap/cache || true

# ✅ Configure Apache to serve Laravel's public folder properly
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Clear and rebuild Laravel caches
RUN php artisan config:clear || true && php artisan optimize:clear || true && php artisan view:clear || true

# Expose port 8080 for Railway
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]