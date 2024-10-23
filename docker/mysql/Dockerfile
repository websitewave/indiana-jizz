FROM mysql:5.7

# Создание директории для хранения данных
RUN mkdir -p /var/lib/mysql

# Установка владельца и группы
RUN chown -R mysql:mysql /var/lib/mysql

# Установка прав доступа для директории
RUN chmod 750 /var/lib/mysql

# Установка прав доступа для файлов в директории
RUN find /var/lib/mysql -type f -exec chmod 640 {} \;

# Папка для хранения данных
VOLUME /var/lib/mysql
