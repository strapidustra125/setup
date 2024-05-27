#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


#----------------------------------------------------------------------------------------------#
#   Список пакетов для установки
#----------------------------------------------------------------------------------------------#

# Системные пакеты
PACKAGES_SYSTEM=(
    language-pack-ru        # Русская раскладка клавиатуры
    gnome-tweaks            # Дополнительные настройки
    flameshot               # Утилита для создания скриншотов
    snapd                   # Пакетный менеджер
    gedit                   # Текстовый редактор
    mc                      # Файловый менеджер
    expect                  # Работа со скриптами
    p7zip                   # 7zip
    rar                     # Работа с .rar архивами
    samba                   # Шаринг директорий
    sshpass                 # Подсовывание пароля в ssh в скрипты
    gnome-sushi             # Предпросмотр в Nautilus
    openconnect             # Для подключения к VPN ТТМ
    libpangox-1.0-0         # Для поддержки оконного режима Cisco VPN
)

# Пакеты для C/C++
PACKAGES_C_CPP=(
    gcc                     # Компилятор для языка C
    g++                     # Компилятор для языка C++
    make                    # Низкоуровневая система сборки
    cmake                   # Высокоуровневая система сборки
    mpich                   # Параллельные многоядерные вычисления
    libgsl-dev              # Математические вычисления на C
    libboost-all-dev        # Фреймворк C++
    libzmq3-dev             # ZMQ
)

# Пакеты для разработки
PACKAGES_DEVELOPMENT=(
    # wireshark               # Сниффер трафика на сетевых интерфейсах
    git                     # Система контроля версия
    valgrind                # Утилита поиска утечек памяти
    gdb                     # Отладчик
    sqlitebrowser           # Посмотреть в sqlite БД
    meld                    # Сравнивалка файлов
)

# Мультимедиа пакеты
PACKAGES_MULTIMEDIA=(
    vlc                     # Медиапроигрыватель
    gimp                    # Редактор изображений
)

# Пакеты для общения
PACKAGES_COMMUNICATION=(

)

LOG_TITLE "Additional packages installing."

# Системные пакеты
for var in ${PACKAGES_SYSTEM[*]}
do
    INSTALL_PACKAGE ${var}
done

# Пакеты для C/C++
for var in ${PACKAGES_C_CPP[*]}
do
    INSTALL_PACKAGE ${var}
done

# Пакеты для разработки
for var in ${PACKAGES_DEVELOPMENT[*]}
do
    INSTALL_PACKAGE ${var}
done

# Мультимедиа пакеты
for var in ${PACKAGES_MULTIMEDIA[*]}
do
    INSTALL_PACKAGE ${var}
done

# Пакеты для общения
for var in ${PACKAGES_COMMUNICATION[*]}
do
    INSTALL_PACKAGE ${var}
done

# ----------------------------- #

# Установка Telegram
EXECUTE "wget https://telegram.org/dl/desktop/linux"
EXECUTE "sudo tar xJf linux -C /opt/"
EXECUTE "sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop"

# Запуск Telegram для добавления в список приложений
EXECUTE "telegram-desktop &"
sleep 5

LOG "Telegram PID: $(jobs -p)"

# Закрыть Telegram
kill $(jobs -p)

# Удалить скаченный установочник
EXECUTE "sudo rm -rf ./linux"

# ----------------------------- #

# Установка Discord
EXECUTE "sudo snap install discord"


notify-send "All additional packages was successfully loaded."