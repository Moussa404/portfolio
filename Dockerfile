# Use official PHP image with necessary extensions
FROM php:8.2-cli

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    libzip-dev \
    && docker-php-ext-install pdo pdo_sqlite zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Create SQLite database automatically
RUN mkdir -p database && touch database/database.sqlite && chmod 666 database/database.sqlite

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Generate Laravel key if missing
RUN php artisan key:generate || true

# Expose the Laravel port
EXPOSE 10000

# Start the Laravel app
CMD php artisan serve --host=0.0.0.0 --port=10000
