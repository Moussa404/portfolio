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

# Explicitly serve from the 'public' folder
cd public
php -S 0.0.0.0:$PORT ../server.php