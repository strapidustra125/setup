### Изменение строки приглашения в консоли с добавление ветки.

```bash
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
    local        BLUE="\[\033[0;34m\]"
    local         RED="\[\033[0;31m\]"
    local       GREEN="\[\033[0;32m\]"
    local     DEFAULT="\[\033[0m\]"

    BRANCH="[\$(git-current-branch)]"
    CUR_TIME="\$(cur-time)"

    export PS1="${RED}${CUR_TIME}${GREEN}\u: ${BLUE}\w ${RED}${BRANCH} ${GREEN}\$ ${DEFAULT}"
}

# Add git branch name to prompt line
set_prompt_line
```