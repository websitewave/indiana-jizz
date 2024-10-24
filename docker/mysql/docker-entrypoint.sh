#!/bin/bash
set -e

# Проверяем, что MYSQL_HOST установлен
if [ -z "$MYSQL_HOST" ]; then
  echo "MYSQL_HOST not set!"
  exit 1
fi

# Запускаем MySQL с переданным bind-address
exec mysqld --bind-address="$MYSQL_HOST"