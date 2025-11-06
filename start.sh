#!/bin/bash
# Ensure storage and cache folders have correct permissions
chmod -R 777 storage bootstrap/cache

# Create SQLite database if missing
if [ ! -f database/database.sqlite ]; then
  mkdir -p database
  touch database/database.sqlite
  chmod 666 database/database.sqlite
fi

# Run Laravel migrations (optional)
php artisan migrate --force || true

# Clear caches
php artisan optimize:clear

# Start the Laravel app serving from public folder
php -S 0.0.0.0:$PORT -t public index.php