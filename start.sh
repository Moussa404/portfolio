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

# Start the Laravel app
php artisan serve --host=0.0.0.0 --port=8080
