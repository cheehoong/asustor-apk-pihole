#!/bin/sh

echo "pre-install"

PIHOLE_FOLDER=/share/Docker/$APKG_PKG_NAME
PIHOLE_CONF=$PIHOLE_FOLDER/etc-pihole
PIHOLE_CONF1=$PIHOLE_FOLDER/etc-dnsmasq.d
OLD_CONF=$APKG_PKG_DIR/CONTROL
LOGGING=$PIHOLE_FOLDER/log.txt

if [ ! -d "$PIHOLE_FOLDER" ]; then
	mkdir "$PIHOLE_FOLDER"
fi

case "$APKG_PKG_STATUS" in
	install)
		# Make sure configuration directory exists
		printf "install\n" >> $LOGGING

		# Make sure configuration directory exists
		if [ ! -d "$PIHOLE_CONF" ]; then
			mkdir "$PIHOLE_CONF"
			mkdir "$PIHOLE_CONF1"
		fi
		;;
	upgrade)
		# Make sure configuration directory exists
		printf "upgrade\n" >> $LOGGING

		if [ -d "$OLD_CONF" ]; then
			cp -r "$OLD_CONF/etc-pihole" $PIHOLE_FOLDER
			cp -r "$OLD_CONF/etc-dnsmasq.d" $PIHOLE_FOLDER
		fi
		;;
	*)
		;;
esac

printf "OLD_CONF\n" >> $LOGGING
printf "$OLD_CONF\n" >> $LOGGING

docker pull pihole/pihole
