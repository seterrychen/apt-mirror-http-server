#!/bin/bash
function create_link {
    # parse mirror.list to share under /var/www/package path
    for i in `egrep -o '(rsync|ftp|https?)://[^ ]+' /etc/apt/mirror.list`; do
        url=${i/http:\/\//''}
        target='/var/www/package/' 

        IFS='/' read -a distName <<< "$url"
        dest=$target${distName[-1]}
        if [ ! -h $dest ]; then 
            echo "Create $dest"
            ln -s /var/spool/apt-mirror/mirror/$url $dest
        fi 
    done
}

# read mirror.list to link /var/www/package folder
mkdir /var/www/package
sed -i '12s|DocumentRoot /var/www/html|DocumentRoot /var/www/package|' /etc/apache2/sites-enabled/000-default.conf
service apache2 restart

# If user doesn't provide mirror.list, using default setting
need_create_line=true
if [ ! -e /etc/apt/mirror.list ]; then
    echo "Using default mirror.list"
    ln -s /mirror.list /etc/apt/mirror.list
    sed -i "s|http://archive.ubuntu.com/ubuntu|$MIRROR_URL|g" /etc/apt/mirror.list
    create_link
    need_create_line=false
fi

while true; do
    if $need_create_line; then
        create_link
    fi
    apt-mirror
    printf "\n\n====== wait $TIMEOUT to execute apt-mirror again ======\n\n"
    sleep $TIMEOUT
done
