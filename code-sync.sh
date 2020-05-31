#!/bin/bash
Path=/mnt/d/Projects/phpstorm

/usr/bin/inotifywait -mrq --format '%w%f' -e create,close_write,delete $Path | while read line; do
    if [ -f $line ]; then
        rsync -az $line --delete /data/www
    else
        cd $Path && \
        rsync -az ./ --delete /data/www
    fi
done
