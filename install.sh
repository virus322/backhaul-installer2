#!/usr/bin/env bash

# Backhaul Professional Installer
# Author: pouyazamani

set -e

REPO="https://github.com/virus322/backhaul-installer2.git"

INSTALL_DIR="/opt/backhaul-installer"

clear

echo "================================="
echo " Backhaul Installer"
echo " Author: pouyazamani"
echo "================================="


if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi


echo "[+] Installing requirements"

apt update -y

apt install -y git curl wget tar ufw


echo "[+] Download project files"


rm -rf $INSTALL_DIR

git clone $REPO $INSTALL_DIR


chmod +x $INSTALL_DIR/*.sh

chmod +x $INSTALL_DIR/scripts/*.sh 2>/dev/null || true



cd $INSTALL_DIR



echo "[+] Running installer"





VERSION="0.7.2"

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



mkdir -p /etc/backhaul



wget -q \
https://github.com/Musixal/Backhaul/releases/download/v0.7.2/backhaul_linux_${ARCH}.tar.gz \
-O /tmp/backhaul.tar.gz


tar -xf /tmp/backhaul.tar.gz -C /tmp


cp /tmp/backhaul /usr/local/bin/backhaul

chmod +x /usr/local/bin/backhaul




echo ""
echo "1) Server (Outside)"
echo "2) Client (Iran)"

read -p "Choose: " MODE


read -p "Port [3080]: " PORT

PORT=${PORT:-3080}



if [ "$MODE" = "1" ]; then


cat >/etc/backhaul/config.toml <<EOF

[server]

bind_addr="0.0.0.0:$PORT"

transport="tcp"

EOF



ufw allow $PORT/tcp || true



else


read -p "Outside IP: " IP



cat >/etc/backhaul/config.toml <<EOF

[client]

remote_addr="$IP:$PORT"

transport="tcp"

EOF


fi




cp $INSTALL_DIR/systemd/backhaul.service \
/etc/systemd/system/backhaul.service



systemctl daemon-reload

systemctl enable backhaul

systemctl restart backhaul



echo ""
echo "================================="
echo " Done"
echo "Project installed:"
echo "$INSTALL_DIR"
echo "================================="

systemctl status backhaul --no-pager
