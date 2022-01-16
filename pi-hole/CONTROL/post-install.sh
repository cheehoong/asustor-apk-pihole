#!/bin/sh

WEBPASSWORD=pihole
WEB_PORT=3001
ServerIP=$AS_NAS_INET4_IP1
PIHOLE_FOLDER=/share/Docker/$APKG_PKG_NAME
PIHOLE_CONF=$PIHOLE_FOLDER/etc-pihole
PIHOLE_CONF1=$PIHOLE_FOLDER/etc-dnsmasq.d
OLD_CONF=$APKG_PKG_DIR
LOGGING=$PIHOLE_FOLDER/log.txt

case "$APKG_PKG_STATUS" in
	install)
		# Make sure configuration directory exists
		if [ ! -d "$PIHOLE_FOLDER" ]; then
			mkdir "$PIHOLE_FOLDER"
		fi

		# Make sure configuration directory exists
		if [ ! -d "$PIHOLE_CONF" ]; then
			mkdir "$PIHOLE_CONF"
			mkdir "$PIHOLE_CONF1"
		fi
		;;
	upgrade)
		# Make sure configuration directory exists
		if [ ! -d "$OLD_CONF" ]; then
			cp "$OLD_CONF/etc-pihole" $PIHOLE_FOLDER
			cp "$OLD_CONF/etc-dnsmasq.d" $PIHOLE_FOLDER
		fi
		;;
	*)
		;;
esac

printf "OLD_CONF" >> $LOGGING
printf "$OLD_CONF" >> $LOGGING
printf "IP1" >> $LOGGING
printf "$AS_NAS_INET4_IP1" >> $LOGGING
printf "IP2" >> $LOGGING
printf "$AS_NAS_INET4_IP2" >> $LOGGING
printf "ADDR_0" >> $LOGGING
printf "$AS_NAS_INET4_ADDR_0" >> $LOGGING
printf "111" >> /share/Docker/pihole-docker/etc-dnsmasq.d/111.log

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
