# Use official PHP image with necessary extensions
FROM php:8.2-cli

# Set working directory
WORKDIR /opt/render/project/src

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_sqlite zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Generate Laravel key if missing
RUN php artisan key:generate || true

# Expose the Laravel port
EXPOSE 10000

# Start the Laravel app (auto-create SQLite if missing and serve from /public)
CMD if [ ! -f /opt/render/project/src/database/database.sqlite ]; then \
      mkdir -p /opt/render/project/src/database && \
      touch /opt/render/project/src/database/database.sqlite && \
      chmod 666 /opt/render/project/src/database/database.sqlite; \
    fi && \
    php artisan migrate --force && \
    php -S 0.0.0.0:10000 -t public
