#!/bin/sh

APACHEHOPCONF=/etc/apache2/conf.d/hop.conf

if [ "$SUBURI" == "" ]; then
	echo "[i] Using default URI: /"
	SUBURI="/"
fi
echo "[i] Serving URI: $SUBURI"


if [ -f $APACHEHOPCONF ]; then
	echo "[i] SUBURI already configured!"
else
	echo "[i] Configuring URI: $SUBURI"
	cat <<EOF > $APACHEHOPCONF
<Directory /php>
    Options FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

Alias $SUBURI "/php/"
EOF
fi

if [ "$NOSYMLINK" == ""]; then
	echo "[i] There will be no symlink to hop.php"
else
	if [ -e /php/index.php ]; then
		echo "[i] index file exists, not touching"
	else
		echo "[i] index file does not exists, creating"
		ln -sf /php/hop.php /php/index.php
	fi
fi
