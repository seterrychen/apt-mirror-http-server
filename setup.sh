#!/bin/bash
function create_link {
    # parse mirror.list to share under /var/www/package path
    grep '^deb' /etc/apt/mirror.list | awk '{print $2}' | while IFS= read -r line
    do
        local mirror_path=
        mirror_path=$(echo "$line" | sed -e 's|^ftp||' -e 's|^https\?||' -e 's|^rsync||' -e 's|://||' -e 's|/$||')
        local target="/var/www/package"

        local dest=
        case "$line" in
            *ubuntu*)
                dest="$target/ubuntu"
            ;;
            *debian*)
                dest="$target/debian"
            ;;
        esac
        if [ ! -h "$dest" ] && [ x"$dest" != x"" ]; then
            echo "[$(date)] Create $dest"
            ln -s "/var/spool/apt-mirror/mirror/$mirror_path" "$dest"
        fi 
    done
}

# To setup http server config at first time
if [ ! -d /var/www/package ]; then
    mkdir -p /var/www/package
    sed -i '12s|DocumentRoot /var/www/html|DocumentRoot /var/www/package|' /etc/apache2/sites-enabled/000-default.conf

    # If user doesn't provide mirror.list, using default setting
    if [ ! -e /etc/apt/mirror.list ]; then
        echo "[$(date)] Using default mirror.list"
        ln -s /mirror.list /etc/apt/mirror.list
    fi
    create_link
fi

echo "[$(date)] Starting apache server"
service apache2 start

while true; do
    echo "[$(date)] Starting apt-mirror"
    apt-mirror
    echo "[$(date)] Completed"
    echo "[$(date)] Sleeping $RESYNC_PERIOD to execute apt-mirror again ======"
    sleep "$RESYNC_PERIOD"
done
