#!/bin/sh

WEBPASSWORD=pihole
WEB_PORT=3001
ServerIP=$AS_NAS_INET4_ADDR_0
LOGGING=$APKG_PKG_DIR/log.txt

if [ ! -z $AS_NAS_INET4_ADDR_0 ]; then
	ServerIP=$AS_NAS_INET4_ADDR_0
else
	ServerIP=$AS_NAS_INET4_ADDR_1
fi

cd /usr/local/AppCentral/pihole-docker/CONTROL/

#sed -i 's/original/new/g' file.txt
#sed -i 's/3001/'"$WEB_PORT"'/g' docker-compose.yml
sed -i 's/192\.168\.1\.1/'"$ServerIP"'/g' docker-compose.yml
sed -i 's/admin/'"$WEBPASSWORD"'/g' docker-compose.yml

docker-compose up -d

exit 0
