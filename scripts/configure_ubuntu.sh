#!/bin/bash

################################################################################################
#
#   Скрипт - волшебная палочка для автоматической настройки чистой Ubuntu.
#
#
#
################################################################################################


#----------------------------------------------------------------------------------------------#
#   Переменные
#----------------------------------------------------------------------------------------------#

# Конфигурируемая система
SYSTEM="Ubuntu"

# Счетчик заголовков
TITLE_COUNTER=1

# Префикс логов
PREFIX=": -------- : "

# Разделитель логов
DEVIDER=": -------- : -------- : -------- : -------- : -------- :"


#----------------------------------------------------------------------------------------------#
#   Конфигурация. Только строка "enable" означает, что компонент будет выполняться.
#   Закоммнтировать ненужное.
#----------------------------------------------------------------------------------------------#

FLAG_UPDATE_PACKAGES="enable"           # Обновление базовых пакетов системы
FLAG_ADDITIONAL_PACKAGES="enable"       # Установка дополнительных пакетов
FLAG_SET_ENVIRONMENT="enable"           # Настройка окружения
FLAG_SET_BASHRC="enable"                # Настройка файла .bashrc
FLAG_MAKE_BEAUTY="enable"               # Настройка красивостей

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


#----------------------------------------------------------------------------------------------#
#   Логгирование
#----------------------------------------------------------------------------------------------#

# Лог в случае ошибки с выходом из скрипта
function LOG_ERR
{
    echo -e "\n${PREFIX}ERROR: $1\n"
    echo -e "${PREFIX}ERROR: \"${SYSTEM}\" configuration failed :("
    exit -1
}

# Штатный лог
function LOG
{
    echo -e "\n${PREFIX}$1\n"
}

# Лог для группы команд
function LOG_TITLE
{
    echo -e "\n${DEVIDER}\n"
    LOG "${TITLE_COUNTER}. $1"
    TITLE_COUNTER=$((${TITLE_COUNTER}+1))
}


#----------------------------------------------------------------------------------------------#
#   Дополнительные функции
#----------------------------------------------------------------------------------------------#

# Выполнение команды, завернутое в лог
function EXECUTE
{
    LOG "Processing \"$1\"..."

    $1 || LOG_ERR $1

    LOG "... \"$1\" success!"
}

# Установка пакета из стандартного репозитория через apt
function INSTALL_PACKAGE
{
    LOG "Installing package \"$1\"..."

        INSTALLED=$(apt list $1 2>>/dev/null | grep installed)

        if [[ -z ${INSTALLED} ]]
        then
            echo -e "Required package \"$1\" is NOT INSTALLED"
            echo -e "Installing...\n"
            EXECUTE "sudo apt install -y $1"
        else
            LOG "Required package \"$1\" is INSTALLED"
        fi
}

################################################################################################
#
#   Конфигурация системы
#
################################################################################################


#----------------------------------------------------------------------------------------------#
#   Обновление базовых пакетов системы.
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_UPDATE_PACKAGES}" ]
then

    LOG_TITLE "Base system packages updating."

    # Проверка обновлений пакетов системы
    EXECUTE "sudo apt update"

    # Обновление пакетов системы
    EXECUTE "sudo apt upgrade -y"

    notify-send "All base system packages was successfully updated."

fi # if [ "${FLAG_UPDATE_PACKAGES}" ]


#----------------------------------------------------------------------------------------------#
#   Установка дополнительных пакетов.
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_ADDITIONAL_PACKAGES}" ]
then

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

fi # if [ "${FLAG_ADDITIONAL_PACKAGES}" ]

#----------------------------------------------------------------------------------------------#
#   Настройка красивостей
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_MAKE_BEAUTY}" ]
then

    LOG_TITLE "Some beauty settings."

    WP_DIR="/home/$(logname)/Pictures/wallpapers"
    WP_FILE="wallpaper-mazda-back.jpg"
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

fi # if [ "${FLAG_UPDATE_PACKAGES}" ]


#----------------------------------------------------------------------------------------------#
#   Настройка файла .bashrc
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_SET_BASHRC}" ]
then

    LOG_TITLE ".bashrc settings."

    # Строка с соблюдением отступов, которая добавится в .bashrc
    ADD_GIT_BRANCH="
# Get git branch name
function git-current-branch
{
    git branch --no-color 2> /dev/null | grep \* | colrm 1 2
}

# Current system time
function cur-time
{
    date +%r
}

# Change prompt line
function set_prompt_line
{
    local        BLUE=\"\[\033[0;34m\]\"
    local         RED=\"\[\033[0;31m\]\"
    local       GREEN=\"\[\033[0;32m\]\"
    local     DEFAULT=\"\[\033[0m\]\"

    BRANCH=\"[\\\$(git-current-branch)]\"
    CUR_TIME=\"\\\$(cur-time)\"

    export PS1=\"\${RED}\${CUR_TIME}\${GREEN}\\u: \${BLUE}\\w \${RED}\${BRANCH} \${GREEN}\\$ \${DEFAULT}\"
}

# Add git branch name to prompt line
set_prompt_line
"

    # Добавление в .bashrc текущего пользователя
    LOG "Changing console welcome string and add current git branch for user \"$(logname)\""
    EXECUTE "sudo echo \"${ADD_GIT_BRANCH}\" >> /home/$(logname)/.bashrc"

    # Добавление в .bashrc для root пользователя
    LOG "Changing console welcome string and add current git branch for user \"root\""
    EXECUTE "sudo echo \"${ADD_GIT_BRANCH}\" >> /root/.bashrc"


    notify-send ".bashrc was successfully updated."

fi # if [ "${FLAG_SET_BASHRC}" ]


#----------------------------------------------------------------------------------------------#
#   Настройка окружения
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_SET_ENVIRONMENT}" ]
then

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

fi # if [ "${FLAG_SET_ENVIRONMENT}" ]

