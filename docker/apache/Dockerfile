FROM httpd:2.4

# Создание директории логов, если она не существует
RUN mkdir -p /usr/local/apache2/logs/

# Установка прав доступа для логов
USER root
RUN chown -R www-data:www-data /usr/local/apache2/logs && chmod -R 755 /usr/local/apache2/logs

# Создание директории для документов
RUN mkdir -p /var/www/html

# Копируем стандартный конфигурационный файл httpd.conf во временное место
RUN cp /usr/local/apache2/conf/httpd.conf /usr/local/apache2/conf/httpd.conf.bak

# Вносим необходимые изменения с помощью sed
RUN sed -i '/LoadModule proxy_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i '/LoadModule proxy_fcgi_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i '/LoadModule rewrite_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i '/LoadModule dir_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i 's/AllowOverride None/AllowOverride All/g' /usr/local/apache2/conf/httpd.conf \
    && sed -i 's|DocumentRoot "/usr/local/apache2/htdocs"|DocumentRoot "/var/www/html"|g' /usr/local/apache2/conf/httpd.conf \
    && sed -i 's|<Directory "/usr/local/apache2/htdocs">|<Directory "/var/www/html">|g' /usr/local/apache2/conf/httpd.conf \
    && echo 'DirectoryIndex index.php index.html' >> /usr/local/apache2/conf/httpd.conf \
    && echo '<FilesMatch \.php$>' >> /usr/local/apache2/conf/httpd.conf \
    && echo '    SetHandler "proxy:fcgi://php:9000"' >> /usr/local/apache2/conf/httpd.conf \
    && echo '</FilesMatch>' >> /usr/local/apache2/conf/httpd.conf

# Установка прав доступа для директории
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Возвращаемся к пользователю www-data
USER www-data