#!/bin/bash

. ../scripts/lib.sh      # Подключение файлика с общими функциями


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