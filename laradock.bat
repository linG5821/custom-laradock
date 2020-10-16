@echo off
SET cmd=%1
SET target=%2

IF "%cmd%"=="up" (
    SET action=up -d workspace php-fpm nginx redis
    IF DEFINED target (
        SET action=up -d %target%
    )
)

IF "%cmd%"=="stop" (
    SET action=stop workspace php-fpm nginx redis
    IF DEFINED target (
        SET action=stop %target%
    )
)

IF "%cmd%"=="exec" (
    IF NOT DEFINED target (
        echo "must set container name"
    ) ELSE (
        SET action=exec %target% bash
    )

)

IF "%cmd%"=="ew" (
    SET action=exec workspace bash

)

IF "%cmd%"=="ep" (
    SET action=exec php-fpm bash

)

IF "%cmd%"=="en" (
    SET action=exec nginx bash

)


C:
cd \Projects\laradock
IF DEFINED action (
    call docker-compose %action%
)


