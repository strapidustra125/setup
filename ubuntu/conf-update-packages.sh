#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


LOG_TITLE "Base system packages updating."

# Проверка обновлений пакетов системы
EXECUTE "sudo apt update"

# Обновление пакетов системы
EXECUTE "sudo apt upgrade -y"

notify-send "All base system packages was successfully updated."