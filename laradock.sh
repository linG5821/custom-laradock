#!/bin/bash
cmd=$1
target=$2

realPath() {
    [[ $1 =~ ^/ ]] && a=$1 || a=`pwd`/$1
    while [ -h $a ]
    do
        b=`ls -ld $a|awk '{print $NF}'`
        c=`ls -ld $a|awk '{print $(NF -2)}'`
        [[ $b =~ ^/ ]] && a=$b || a=`dirname $c`/$b
    done
    echo $a
}

if [ "$cmd" == "up" ]; then
    action="up -d workspace php-fpm nginx redis php-worker"
    echo $action
    if [ -n "$target" ]; then
        action="up -d $target"
    fi
elif [ "$cmd" == "build" ]; then
    action="up --build -d workspace php-fpm nginx redis php-worker"
    if [ -n "$target" ]; then
        action="up --build -d $target"
    fi
elif [ "$cmd" == "stop" ]; then
    action="stop workspace php-fpm nginx redis php-worker"
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
elif [ "$cmd" == "epw" ]; then
    action="exec php-worker bash"
fi
binPath=$(cd `dirname $0`;pwd)/laradock
shPath=`realPath $binPath`
cd `dirname $shPath`

if [ -n "$action" ]; then
    echo $action
    docker-compose $action
fi
