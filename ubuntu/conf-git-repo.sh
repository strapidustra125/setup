#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


LOG_TITLE "Git repositories settings."

# Настройка гита

EMAIL_TTM="N.Novikov@transtelematica.ru"
EMAIL_SSU="strapidustra125.business@gmail.com"
EMAIL="strapidustra125@gmail.com"

NAME="Nikolay Novikov"

git config --global user.email "${EMAIL_TTM}"
git config --global user.name "${NAME}"


# ----------------------------- #

REPO_DIR="~/Documents/repo/"
mkdir $REPO_DIR
cd $REPO_DIR




notify-send "All git repositories was successfully initialized."