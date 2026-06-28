#!/usr/bin/env bash

# Backhaul Professional Installer
# Author: pouyazamani

set -e


VERSION="0.7.2"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/backhaul"
CONFIG_FILE="$CONFIG_DIR/config.toml"
SERVICE_FILE="/etc/systemd/system/backhaul.service"


clear

echo "======================================"
echo " Backhaul Professional Installer"
echo " Author: pouyazamani"
echo " Version: $VERSION"
echo "======================================"



if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi



echo "[+] Updating packages..."

apt update -y

apt install -y curl wget tar ufw



echo "[+] Detecting CPU..."

ARCH=$(uname -m)

case $ARCH in

x86_64)
ARCH="amd64"
;;

aarch64)
ARCH="arm64"
;;

*)
echo "CPU not supported"
exit 1
;;

esac



mkdir -p $CONFIG_DIR



echo ""
echo "Select mode:"
echo ""
echo "1) Server (Kharej)"
echo "2) Client (Iran)"
echo ""

read -p "Choice: " MODE



echo ""
read -p "Enter tunnel port [3080]: " PORT

PORT=${PORT:-3080}



echo "[+] Downloading Backhaul..."

wget -q \
"https://github.com/Musixal/Backhaul/releases/download/v0.7.2/backhaul_linux_${ARCH}.tar.gz" \
-O /tmp/backhaul.tar.gz



tar -xf /tmp/backhaul.tar.gz -C /tmp



cp /tmp/backhaul $INSTALL_DIR/backhaul

chmod +x $INSTALL_DIR/backhaul




if [ "$MODE" = "1" ]; then


echo "[+] Creating Server config"


cat > $CONFIG_FILE <<EOF

[server]

bind_addr = "0.0.0.0:$PORT"

transport = "tcp"

keepalive_period = 75

EOF



ufw allow $PORT/tcp || true



elif [ "$MODE" = "2" ]; then


read -p "Server outside IP: " SERVER_IP



cat > $CONFIG_FILE <<EOF

[client]

remote_addr = "$SERVER_IP:$PORT"

transport = "tcp"

keepalive_period = 75

EOF



else

echo "Invalid option"
exit 1

fi




echo "[+] Creating service..."

cat > $SERVICE_FILE <<EOF

[Unit]

Description=Backhaul Tunnel

After=network-online.target


[Service]

Type=simple

ExecStart=/usr/local/bin/backhaul -c $CONFIG_FILE

Restart=always

RestartSec=5

LimitNOFILE=65535


[Install]

WantedBy=multi-user.target

EOF




systemctl daemon-reload

systemctl enable backhaul

systemctl restart backhaul




echo ""
echo "======================================"
echo " Installation Finished"
echo "======================================"

echo ""

systemctl status backhaul --no-pageraarch64)
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
