#!/bin/sh

secretFiles="
    jupyterlab_token
    mariadb_root_pass
    mariadb_wordpress_pass
    proftpd_login0_pass
    redis_server_pass
    wordpress_admin_pass
    wordpress_user0_pass
"

domains="
amsaleh.42.fr
amsaleh.42.fr.adminer
amsaleh.42.fr.lab
"

for file in $secretFiles;
do
    if [ -e secrets/"$file" ]; then
        echo "$file exists."
    else
        echo "Generating $file"
        < /dev/random tr -dc a-zA-Z0-9=._+- | head -c 79 > secrets/"$file"
    fi
done

for domain in $domains;
do
    if [ -e secrets/"$domain".crt ] && [ -e secrets/"$domain".key ]; then
        echo "Certificate and key of $domain exists."
    else
        echo "Generating certificate and key for $domain"
        openssl req -newkey rsa:2048 -noenc -x509 -days 365 \
            -keyout secrets/"$domain".key -out secrets/"$domain".crt \
            -subj "/C=JO/ST=Amman/L=Amman/O=amsaleh/CN=$domain" 2> /dev/null
    fi
done