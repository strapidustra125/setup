#!/bin/bash

################################################################################################
#
#   Общие функции, используемые во всех скриптах.
#
################################################################################################


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