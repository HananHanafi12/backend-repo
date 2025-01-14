# Menggunakan image dasar PHP dengan versi yang cocok dengan versi Anda
FROM php:8.3-apache

# Set direktori kerja di dalam container
WORKDIR /var/www/html

# Menyalin file composer.json dan composer.lock
COPY composer.json composer.lock ./

# Menginstall Composer
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip && \
    docker-php-ext-install zip && \
    docker-php-ext-enable zip && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer install --no-dev --no-scripts --no-autoloader

# Menyalin seluruh kode proyek ke dalam container
COPY . ./

# Menjalankan npm install dan build aset front-end
RUN apt-get install -y nodejs npm && \
    npm install && npm run prod

# Mengatur hak akses untuk direktori storage dan bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Menjalankan script artisan migrate
RUN php artisan migrate --force

# Expose port 80
EXPOSE 80
