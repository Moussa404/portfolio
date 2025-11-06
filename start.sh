#!/bin/bash
chmod -R 777 storage bootstrap/cache
php artisan optimize:clear
php artisan serve --host=0.0.0.0 --port=$PORT