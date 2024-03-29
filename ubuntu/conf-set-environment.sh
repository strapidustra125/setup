#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


LOG_TITLE "Environment settings."


# ----------------------------- #

# Генерация ssh ключей
EXECUTE "ssh-keygen"


notify-send "All environment settings was successfully done."