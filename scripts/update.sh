#!/usr/bin/env bash

# Backhaul Update Script
# Author: pouyazamani

set -e


echo "=============================="
echo " Backhaul Auto Update"
echo " Author: pouyazamani"
echo "=============================="


if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi


BIN="/usr/local/bin/backhaul"

SERVICE="/etc/systemd/system/backhaul.service"


echo "[+] Detecting architecture"


ARCH=$(uname -m)


case $ARCH in

x86_64)
ARCH="amd64"
;;

aarch64)
ARCH="arm64"
;;

*)
echo "Unsupported CPU"
exit 1
;;

esac



echo "[+] Download latest Backhaul"


wget -q \
https://github.com/Musixal/Backhaul/releases/download/v0.7.2/backhaul_linux_${ARCH}.tar.gz \
-O /tmp/backhaul-update.tar.gz



mkdir -p /tmp/backhaul-update


tar -xf /tmp/backhaul-update.tar.gz \
-C /tmp/backhaul-update



echo "[+] Stopping service"

systemctl stop backhaul || true



echo "[+] Replacing binary"


cp /tmp/backhaul-update/backhaul $BIN


chmod +x $BIN



echo "[+] Starting service"


systemctl daemon-reload

systemctl start backhaul


echo ""

echo "Update completed"

echo ""

systemctl status backhaul --no-pager
