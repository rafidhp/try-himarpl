#!/bin/bash

# Tunggu database siap (opsional, bisa pakai sleep atau healthcheck)

# Jalankan migrasi
php artisan migrate --force

# Start apache
apache2-foreground
