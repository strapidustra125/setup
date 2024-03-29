#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


LOG_TITLE "Environment settings."

# Настройка гита

EMAIL_TTM="N.Novikov@transtelematica.ru"
EMAIL_SSU="strapidustra125.business@gmail.ru"
EMAIL="N.Novikov@transtelematica.ru"
NAME="Nikolay Novikov"

git config --global user.email "${DEF_EMAIL}"
git config --global user.name "${DEF_NAME}"


# ----------------------------- #

# Генерация ssh ключей
EXECUTE "ssh-keygen"


notify-send "All environment settings was successfully done."