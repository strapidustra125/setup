# Конфигурация Ubuntu

### 1. Скрипт по настройке Ubuntu

Запустить такую команду:

```bash
wget -O - https://raw.githubusercontent.com/strapidustra125/setup/master/scripts/configure_ubuntu.sh | bash || rm -rf configure_ubuntu.sh
```

Она запускает скрипт и удаляет его после выполнения.

> Важно! Повторный запуск скрипта нежелателен. Как минимум, задвоятся строки в ```.bashrc```.

### 2. Установка дополнительных приложений

1. **Google Chrome**: https://www.google.com/intl/ru_ru/chrome
    - Зайти в гугл аккаунт для синхронизации браузера.
    - Закрепить в избранных.

2. **Visual Studio Code**: https://code.visualstudio.com/download
    - Включить синхронизацию с GitHub для подтягивания расширений.
    - Закрепить в избранных.

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
