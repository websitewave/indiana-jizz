Indiana Jizz
=============================

**Indiana Jizz** - простая Docker-сборка для PHP приложений с Apache, PHP-FPM, MySQL и phpMyAdmin

Сборка предназначена для использования в качестве модуля в ваших проектах, что позволяет обновлять её независимо от вашего основного кода.

Особенности
-----------

*   **Apache 2.4** с поддержкой PHP через PHP-FPM
*   **PHP 8.0-FPM** с необходимыми расширениями
*   **MySQL 5.7** для работы с базами данных
*   **phpMyAdmin** для удобного управления базой данных
*   **Поддержка Docker Compose** для простого управления сервисами
*   **Монтирование директории с исходным кодом** для удобной разработки

Требования
----------

*   **Docker** версии 19.03 или выше
*   **Docker Compose** версии 1.25 или выше
*   **Git** для работы с репозиториями и подмодулями
*   **WSL 2 (Windows Subsystem for Linux)**, если вы используете Windows

Установка и настройка
---------------------

### 1\. Клонирование репозитория

Клонируйте этот репозиторий в любую директорию на вашей машине:

`git clone https://github.com/websitewave/indiana-jizz.git`

### 2\. Интеграция с вашим проектом

Вы можете использовать эту Docker-сборку как подмодуль в вашем основном проекте.

#### Добавление в существующий проект

Перейдите в корневую директорию вашего проекта и выполните команду:

`git submodule add https://github.com/websitewave/indiana-jizz.git docker`

Это добавит Docker-сборку в папку `docker` вашего проекта.

#### Структура проекта

Ваша файловая структура должна выглядеть следующим образом:

    your-project/
    ├── docker/                # подмодуль с Docker-сборкой
    │   ├── docker-compose.yml
    │   ├── .env
    │   └── docker/            # папка с Dockerfile и конфигурациями
    ├── source/                # ваши файлы приложения
    ├── README.md
    └── .gitignore


### 3\. Настройка переменных окружения

В файле `.env` задайте необходимые переменные окружения для MySQL:

`MYSQL_ROOT_PASSWORD=your_root_password MYSQL_DATABASE=your_database MYSQL_USER=your_user MYSQL_PASSWORD=your_password`

Замените `your_root_password`, `your_database`, `your_user` и `your_password` на ваши реальные данные.

### 4\. Запуск Docker-сборки

Перейдите в директорию с `docker-compose.yml` и запустите сборку:

`cd docker docker-compose up -d --build`

Это запустит все сервисы в фоновом режиме.

### 5\. Доступ к сервисам

*   **Веб-приложение** будет доступно по адресу: [http://localhost](http://localhost)
*   **phpMyAdmin** будет доступен по адресу: [http://localhost:8080](http://localhost:8080)

Команды для управления Docker-контейнерами
------------------------------------------

### Остановка контейнеров

`docker-compose down`

### Перезапуск контейнеров

`docker-compose up -d`

### Пересборка контейнеров

Если вы внесли изменения в Dockerfile или конфигурационные файлы:

`docker-compose up -d --build`

### Просмотр логов

Просмотр логов Apache:

`docker logs apache`

Просмотр логов PHP-FPM:

`docker logs php`

Просмотр логов MySQL:

`docker logs mysql`

Обновление Docker-сборки
------------------------

### Обновление подмодуля

Если вы используете эту Docker-сборку как подмодуль и хотите обновить её до последней версии:

`cd docker git pull origin master cd .. git add docker git commit -m "Update Docker submodule" git push`

### Клонирование репозитория с подмодулями

Если вы клонируете ваш основной репозиторий, содержащий подмодули, используйте флаг `--recurse-submodules`:

`git clone --recurse-submodules https://github.com/yourusername/your-project.git`

Или инициализируйте и обновите подмодули после клонирования:

`git submodule init git submodule update`

Использование Git Subtree (Альтернатива подмодулям)
---------------------------------------------------

Вы можете интегрировать Docker-сборку в ваш проект с помощью Git Subtree.

### Добавление Docker-сборки с помощью Subtree

`git subtree add --prefix=docker https://github.com/websitewave/indiana-jizz.git master --squash`

### Обновление Docker-сборки

`git subtree pull --prefix=docker https://github.com/websitewave/indiana-jizz.git master --squash`

Настройка PHP и Apache
----------------------

### Добавление дополнительных PHP-расширений

Если вашему приложению требуются дополнительные PHP-расширения, вы можете добавить их в `docker/php/Dockerfile`:

`RUN docker-php-ext-install your_extension`

### Настройка `php.ini`

Вы можете изменить настройки PHP, отредактировав файл `docker/php/php.ini`.

### Настройка Apache

Вы можете изменить конфигурацию Apache, отредактировав файл `docker/apache/httpd.conf` или соответствующий `Dockerfile`.

Работа с WSL 2 (для пользователей Windows)
------------------------------------------

Если вы используете WSL 2, рекомендуется хранить файлы проекта внутри файловой системы WSL для оптимальной производительности и правильного монтирования директорий.

### Перемещение проекта в файловую систему WSL

`mv /mnt/c/Users/YourUser/YourProject ~/YourProject`

### Обновление путей в `docker-compose.yml`

Убедитесь, что пути в `docker-compose.yml` соответствуют местоположению вашего проекта внутри WSL.

Решение возможных проблем
-------------------------

### Проблемы с правами доступа

Убедитесь, что у Docker-контейнеров есть необходимые права доступа к файлам вашего приложения. При необходимости измените права доступа на файлы и директории.

### Порты заняты другими приложениями

Если порты 80 или 3306 заняты другими приложениями на вашей машине, вы можете изменить их в файле `docker-compose.yml`:

`ports:   - "8080:80"    # для Apache   - "3307:3306"  # для MySQL`

### Проблемы с монтированием директорий

Если вы сталкиваетесь с проблемами монтирования директорий в WSL 2, убедитесь, что ваш проект находится в файловой системе WSL, а не на диске Windows.

Контактная информация
---------------------

Если у вас возникли вопросы или вы столкнулись с проблемами, пожалуйста, создайте [Issue](https://github.com/websitewave/indiana-jizz/issues) на GitHub или свяжитесь со мной по электронной почте: [alex.websitewave@gmail.com](mailto:alex.websitewave@gmail.com).

Лицензия
--------

Этот проект лицензирован на условиях лицензии MIT.

* * *

**Примечание:** Замените `yourusername`, `alex.websitewave@gmail.com` и другие placeholder-значения на ваши реальные данные.