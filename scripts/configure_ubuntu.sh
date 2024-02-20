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
#----------------------------------------------------------------------------------------------#

# Обновление базовых пакетов системы
FLAG_UPDATE_PACKAGES="disable"

# Настройка окружения
FLAG_SET_ENVIRONMENT="disable"

# Настройка красивостей
FLAG_MAKE_BEAUTY="disable"


#----------------------------------------------------------------------------------------------#
#   Список пакетов для установки
#----------------------------------------------------------------------------------------------#

# apt
# "git"



# vscode


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
    TITLE_COUNTER=${TITLE_COUNTER}+1
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

################################################################################################
#
#   Конфигурация системы
#
################################################################################################


#----------------------------------------------------------------------------------------------#
#   Обновление базовых пакетов системы.
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_UPDATE_PACKAGES}" = "enable" ]
then

    LOG_TITLE "Base system packages updating."

    # Проверка обновлений пакетов системы
    EXECUTE "sudo apt update"

    # Обновление пакетов системы
    EXECUTE "sudo apt upgrade"

fi # if [ "${FLAG_UPDATE_PACKAGES}" = "enable" ]


#----------------------------------------------------------------------------------------------#
#   Настройка окружения
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_SET_ENVIRONMENT}" = "enable" ]
then

    LOG_TITLE "Environment settings."


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
    sudo echo "${ADD_GIT_BRANCH}" >> /home/$(logname)/.bashrc

    # Добавление в .bashrc для root пользователя
    LOG "Changing console welcome string and add current git branch for user \"root\""
    sudo echo "${ADD_GIT_BRANCH}" >> /root/.bashrc

fi # if [ "${FLAG_SET_ENVIRONMENT}" = "enable" ]


#----------------------------------------------------------------------------------------------#
#   Настройка красивостей
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_MAKE_BEAUTY}" = "enable" ]
then

    LOG_TITLE "Some beauty settings."

    WP_DIR="/home/$(logname)/Pictures/wallpapers"
    WP_FILE="wallpaper-mazda-back.jpg"
    WP_URL="https://raw.githubusercontent.com/strapidustra125/setup/master/pictures/${WP_FILE}"

    if ! [ -d ${WP_DIR} ];
    then
        EXECUTE "mkdir ${WP_DIR}"
    fi

    if ! [ -d ${WP_DIR}/${WP_FILE}  ];
    then
        EXECUTE "wget --no-check-certificate -O ${WP_DIR}/${WP_FILE} ${WP_URL}"
    fi

fi # if [ "${FLAG_UPDATE_PACKAGES}" = "enable" ]
