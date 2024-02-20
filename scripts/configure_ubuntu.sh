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

# FLAG_UPDATE_PACKAGES="enable"         # Обновление базовых пакетов системы
FLAG_ADDITIONAL_PACKAGES="enable"     # Установка дополнительных пакетов
# FLAG_SET_ENVIRONMENT="enable"         # Настройка окружения
# FLAG_MAKE_BEAUTY="enable"             # Настройка красивостей

#----------------------------------------------------------------------------------------------#
#   Список пакетов для установки
#----------------------------------------------------------------------------------------------#

# Пакеты для C/C++
PACKAGES_C_CPP=(
    gcc                     # Компилятор для языка C
    g++                     # Компилятор для языка C++
    make                    # Низкоуровневая система сборки
    cmake                   # Высокоуровневая система сборки
    mpich                   # Параллельные многоядерные вычисления
    libgsl-dev              # Математические вычисления на C
)

# Пакеты для разработки
PACKAGES_DEVELOPMENT=(
    git                     # Система контроля версия
    valgrind                # Утилита поиска утечек памяти
    gdb                     # Отладчик
    wireshark               # Сниффер трафика на сетевых интерфейсах
    sqlitebrowser           # Посмотреть в sqlite БД
    meld                    # Сравнивалка файлов
)

# Мультимедиа пакеты
PACKAGES_MULTIMEDIA=(
    vlc                     # Медиапроигрыватель
)

# Пакеты для общения
PACKAGES_COMMUNICATION=(

)

# vscode
# telegram
# discord


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
    EXECUTE "sudo apt upgrade"

fi # if [ "${FLAG_UPDATE_PACKAGES}" ]


#----------------------------------------------------------------------------------------------#
#   Установка дополнительных пакетов.
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_ADDITIONAL_PACKAGES}" ]
then

    LOG_TITLE "Additional packages installing."

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

fi # if [ "${FLAG_ADDITIONAL_PACKAGES}" ]

#----------------------------------------------------------------------------------------------#
#   Настройка окружения
#----------------------------------------------------------------------------------------------#

if [ "${FLAG_SET_ENVIRONMENT}" ]
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

fi # if [ "${FLAG_SET_ENVIRONMENT}" ]


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
        EXECUTE "mkdir ${WP_DIR}"
    fi

    if ! [ -d ${WP_DIR}/${WP_FILE}  ];
    then
        EXECUTE "wget --no-check-certificate -O ${WP_DIR}/${WP_FILE} ${WP_URL}"
    fi

fi # if [ "${FLAG_UPDATE_PACKAGES}" ]
