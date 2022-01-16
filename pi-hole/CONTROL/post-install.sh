#!/bin/sh

WEBPASSWORD=pihole
WEB_PORT=3001
ServerIP=$AS_NAS_INET4_IP1
PIHOLE_FOLDER=/share/Docker/$APKG_PKG_NAME
LOGGING=$PIHOLE_FOLDER/log.txt

printf "IP1\n" >> $LOGGING
printf "$AS_NAS_INET4_IP1\n" >> $LOGGING
printf "IP2\n" >> $LOGGING
printf "$AS_NAS_INET4_IP2\n" >> $LOGGING
printf "ADDR_0\n" >> $LOGGING
printf "$AS_NAS_INET4_ADDR_0\n" >> $LOGGING

if [ ! -z $AS_NAS_INET4_IP1 ]; then
	ServerIP=$AS_NAS_INET4_IP1
else
	ServerIP=$AS_NAS_INET4_IP2
fi

cd /usr/local/AppCentral/pihole-docker/CONTROL/

#sed -i 's/original/new/g' file.txt
#sed -i 's/3001/'"$WEB_PORT"'/g' docker-compose.yml
sed -i 's/192\.168\.1\.1/'"$ServerIP"'/g' docker-compose.yml
sed -i 's/admin/'"$WEBPASSWORD"'/g' docker-compose.yml

docker-compose up -d

exit 0
