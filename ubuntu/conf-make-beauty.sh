#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


LOG_TITLE "Some beauty settings."

WP_DIR="/home/$(logname)/Pictures/wallpapers"
WP_FILE="wallpaper-mazda.jpg"
WP_URL="https://raw.githubusercontent.com/strapidustra125/setup/master/pictures/${WP_FILE}"

if ! [ -d ${WP_DIR} ];
then
    EXECUTE "mkdir -p ${WP_DIR}"
fi

if ! [ -f ${WP_DIR}/${WP_FILE}  ];
then
    EXECUTE "wget --no-check-certificate -O ${WP_DIR}/${WP_FILE} ${WP_URL}"
fi

notify-send "All beauty settings was successfully done."