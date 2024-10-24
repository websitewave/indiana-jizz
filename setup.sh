#!/bin/bash

# Прерываем выполнение при ошибке
set -e

# Запрашиваем имя пользователя Linux
read -p "Введите свое имя Linux пользователя: " LINUX_USER

# Шаг 1: Запускаем контейнеры с билдом
echo "Запускаем docker-compose up -d --build..."
docker-compose up -d --build && echo "Docker-compose успешно запущен!" || echo "Ошибка при запуске docker-compose."

# Шаг 2: Создаем директорию source
echo "Создаем директорию source..."
mkdir -p ./source && echo "Директория source создана!" || echo "Ошибка при создании директории source."

# Шаг 3: Добавляем пользователя в группу www-data
echo "Добавляем $LINUX_USER в группу www-data..."
sudo usermod -aG www-data "$LINUX_USER" && echo "Пользователь $LINUX_USER добавлен в группу www-data!" || echo "Ошибка при добавлении пользователя в группу www-data."

# Шаг 4: Добавляем пользователя в группу docker
echo "Добавляем $LINUX_USER в группу docker..."
sudo usermod -aG docker "$LINUX_USER" && echo "Пользователь $LINUX_USER добавлен в группу docker!" || echo "Ошибка при добавлении пользователя в группу docker."

# Шаг 5: Изменяем группу на www-data для директории source
echo "Изменяем группу на www-data для директории source..."
sudo chgrp -R www-data ./source && echo "Группа изменена на www-data!" || echo "Ошибка при изменении группы."

# Шаг 6: Устанавливаем права для директорий
echo "Устанавливаем права для директорий (2775)..."
sudo find ./source -type d -exec chmod 2775 {} + && echo "Права для директорий успешно установлены!" || echo "Ошибка при установке прав для директорий."

# Шаг 7: Устанавливаем права для файлов
echo "Устанавливаем права для файлов (664)..."
sudo find ./source -type f -exec chmod 664 {} + && echo "Права для файлов успешно установлены!" || echo "Ошибка при установке прав для файлов."

echo "Настройка завершена успешно! Возможно, вам потребуется перезайти в систему, чтобы изменения вступили в силу."