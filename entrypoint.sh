#!/bin/sh
set -e

# Variables
LOG_PATH="/var/log"
LOG_OUT="docker.out.log"
LOG_ERR="docker.err.log"

# Functions

create_log()
{
    if [ ! -d "$LOG_PATH" ];
    then
        mkdir -p "$LOG_PATH"
    fi

    if [ ! -f "$LOG_PATH/$LOG_OUT" ];
    then
        touch "$LOG_PATH/$LOG_OUT"
    fi

    if [ ! -f "$LOG_PATH/$LOG_ERR" ];
    then
        touch "$LOG_PATH/$LOG_ERR"
    fi
}

log()
{
    create_log
    if [ "$1" -eq "0"  ];
    then
        echo -e "\e[32m[$(date)] $2\e[39m" > "$LOG_PATH/$LOG_OUT"
    else
        echo -e "\e[31m[$(date)][Error] $2 (code: $1)\e[39m" > "$LOG_PATH/$LOG_ERR"
    fi

}

create_ssl()
{
    if [ ! -z "$2" ];
    then
        if [ ! -d "$SSL_PATH" ]
        then
            mkdir -p "$SSL_PATH"
        fi
        echo "$2" > "$SSL_PATH/$1"
        log "$?" "Create $SSL_PATH/$1"

        if [ "$DEBUG" == "true" ]
        then
            cat $SSL_PATH/$1
        fi
    fi
}

symlink_ssl()
{
    if [ ! -z "$2" ]
    then
        if [ -f "$SSL_PATH/$1" ]
        then
            ln -s "$SSL_PATH/$1" "$SSL_PATH/$2"
            log "$?" "Create $SSL_PATH/$2"
        fi
    fi
}

ssl()
{
    create_ssl "$SSL_CRT_NAME" "$SSL_CRT"
    create_ssl "$SSL_KEY_NAME" "$SSL_KEY"
    create_ssl "$SSL_CA_NAME" "$SSL_CA"
    symlink_ssl "$SSL_CRT_NAME" "$SSL_CRT_NAME_OTHER"
    symlink_ssl "$SSL_KEY_NAME" "$SSL_KEY_NAME_OTHER"
}

# Menu

case "$1" in

"init")
    echo -e "\e[34m[$(date)] Initialization\e[39m"
    ssl
    echo -e "\e[34m[$(date)] End\e[39m"
    ;;

*)
    echo "Custom command: $@"
    exec "$@"
    ;;

esac
