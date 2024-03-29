#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


LOG_TITLE "Git repositories settings."

# Настройка гита

EMAIL_TTM="N.Novikov@transtelematica.ru"
EMAIL_SSU="strapidustra125.business@gmail.com"
EMAIL="strapidustra125@gmail.com"

NAME="Nikolay Novikov"

git config --global user.email "${DEF_EMAIL}"
git config --global user.name "${DEF_NAME}"


# ----------------------------- #



notify-send "All git repositories was successfully initialized."