# Инициализация репозитория

Запустить такую команду:

```bash
wget -O - https://raw.githubusercontent.com/strapidustra125/setup/master/scripts/init_this_repo.sh | bash || rm -rf init_this_repo.sh
```

Она запускает скрипт и удаляет его после выполнения.
Клонируется репозиторий целиком.

Потом:

```bash
cd ~/Documents/repo/github/
```

# Конфигурация Ubuntu

### 1. Скрипт по настройке Ubuntu

Запустить такую команду:

```bash
wget -O - https://raw.githubusercontent.com/strapidustra125/setup/master/scripts/init_this_repo.sh | bash || rm -rf init_this_repo.sh
```

```bash
cd ~/Documents/repo/github/setup/ubuntu
```

```bash
./configure.sh
```

```bash
./conf-git-repo.sh
```

Она запускает скрипт и удаляет его после выполнения.

> Важно! Повторный запуск скрипта нежелателен. Как минимум, задвоятся строки в ```.bashrc```.

### 2. Установка дополнительных приложений

1. **Google Chrome**: https://www.google.com/intl/ru_ru/chrome
    - Зайти в гугл аккаунт для синхронизации браузера.
    - Закрепить в избранных.

2. **Cisco Secure Client Software VPN**: https://uci.service-now.com/kb_view.do?sysparm_article=KB0010201
    - > tar xzvf cisco-secure-client*
    - > cd vpn
    - > sudo ./vpn_install.sh

### 3. Настройка рабочего стола

1. Стандартные настройки системы:
    - **_Background_**: выбрать изображение рабочего стола из директории **_wallpapers_**
    - **_Appearance_**: темная тема, размер иконок - **_34_**, показывать на обоих дисплеях снизу
    - **_Online_** Accounts: войти в **_Ubuntu Single_**
    - **_Power_**: 15 минут таймаут
    - **_Displays_**: Основным сделать меньший по размеру, или левый (если одинаковые)
    - **_Keyboard Shortcuts_**: Удалить хоткей с **_PrintScreen_** и добавить команду ```flameshot gui``` на эту клавишу
    - **_Region & Language_**: Добавить русскую раскладку клавиатуры и выбрать "свой язык для каждого окна"
    - **_Default Applications_**: Выбрать **_хром_**, **_VLC_**

2. Настройки Gnome Tweaks:
    - **_Keyboard & Mouse_**: добавить смену раскладки на ```Alt + Shift```
    - **_Startup Applications_**: Добавить **_discord_** и **_flameshot_**
    - **_Top Bar_**: Расширить формат времени

### 4. Дополнительные настройки

1. Nautilus
    - Views -> Show sidebar
    - Views -> Sort folders before files
    - Views -> Allow folders to de expanded
    - Views -> Icon View Captions: First - Size, Second - Permissions
    - List Columns -> Size, Type, Permissions, Modified-Time, Star

2. Terminal
    - General -> Enable the menu accelerator key (F10) = false
    - Unnamed -> Initial Terminal size = 180x50

### 5. Почты

1. Работа - СГУ
2. Яндекс
3. Гугл
4. Мэйл
5. Семейный
