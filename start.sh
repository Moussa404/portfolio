#!/bin/bash
chmod -R 777 storage bootstrap/cache

php artisan optimize:clear

# Use PHP built-in server correctly for Laravel 12
php -S 0.0.0.0:$PORT -t public public/index.php