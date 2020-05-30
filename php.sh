#!/bin/bash
cmd=$1
target=$2

if [ "$cmd" == "up" ]; then
    action="up -d workspace php-fpm nginx redis"
    echo $action
    if [ -n "$target" ]; then
        echo [ -n "$target" ]
        action="up -d $target"
    fi
elif [ "$cmd" == "build" ]; then
    action="up --build -d workspace php-fpm nginx redis"
    if [ -n "$target" ]; then
        action="up --build -d $target"
    fi
elif [ "$cmd" == "stop" ]; then
    action="stop workspace php-fpm nginx redis"
    if [ -n "$target" ]; then
        action="stop $target"
    fi
elif [ "$cmd" == "exec" ]; then
    if [ -n "$target" ]; then
        echo "must set container name"
    else
        action="exec $target bash"
    fi
elif [ "$cmd" == "ew" ]; then
    action="exec workspace bash"
elif [ "$cmd" == "ep" ]; then
    action="exec php-fpm bash"
elif [ "$cmd" == "en" ]; then
    action="exec nginx bash"
fi
cd /data/laradock
if [ -n "$action" ]; then
    echo $action
    docker-compose $action
fi
