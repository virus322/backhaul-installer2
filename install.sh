#!/usr/bin/env bash

# Backhaul Auto Installer
# Author: pouyazamani

set -e

VERSION="0.7.2"
DIR="/etc/backhaul"
BIN="/usr/local/bin/backhaul"

clear

echo "=============================="
echo " Backhaul Installer"
echo " Author: pouyazamani"
echo "=============================="

if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

apt update -y

apt install -y curl wget tar unzip systemd

mkdir -p $DIR


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


echo "Downloading Backhaul..."

wget -q \
https://github.com/Musixal/Backhaul/releases/download/v0.7.2/backhaul_linux_${ARCH}.tar.gz \
-O /tmp/backhaul.tar.gz


tar -xf /tmp/backhaul.tar.gz -C /tmp


mv /tmp/backhaul $BIN

chmod +x $BIN


echo ""
echo "Choose mode:"
echo "1) Server"
echo "2) Client"

read -p "Select: " MODE


if [ "$MODE" = "1" ]; then

cat > $DIR/config.toml <<EOF
[server]

bind_addr = "0.0.0.0:3080"

transport = "tcp"

EOF

else

read -p "Server IP: " SERVER

cat > $DIR/config.toml <<EOF
[client]

remote_addr = "${SERVER}:3080"

transport = "tcp"

EOF

fi



cat > /etc/systemd/system/backhaul.service <<EOF

[Unit]
Description=Backhaul Tunnel
After=network.target


[Service]

Type=simple

ExecStart=$BIN -c $DIR/config.toml

Restart=always

RestartSec=3


[Install]

WantedBy=multi-user.target

EOF



systemctl daemon-reload

systemctl enable backhaul

systemctl restart backhaul


echo ""
echo "=============================="
echo " Installed Successfully"
echo "=============================="

echo "Status:"
echo "systemctl status backhaul"
