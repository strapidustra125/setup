#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


LOG_TITLE "Environment settings."

# Настройка гита

DEF_EMAIL="N.Novikov@transtelematica.ru"
DEF_NAME="Nikolay Novikov"

git config --global user.email "${DEF_EMAIL}"
git config --global user.name "${DEF_NAME}"


# ----------------------------- #

# Генерация ssh ключей
# ssh-keygen -N "" -f /home/nikolay/.ssh/id_rsa

EXECUTE "ssh-keygen"


# SSH_DIR="/home/$(logname)/.ssh"
# SSH_FILE="id_rsa"
# if ! [ -d  ${SSH_DIR} ];
# then
#     EXECUTE "mkdir -p ${SSH_DIR}"
# fi

# if ! [ -f ${SSH_FILE} ];
# then
#     EXECUTE "ssh-keygen -N \"\" -f ${SSH_DIR}/${SSH_FILE}"
# fi


notify-send "All environment settings was successfully done."