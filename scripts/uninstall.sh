#!/usr/bin/env bash

# Backhaul Uninstall Script
# Author: pouyazamani

set -e


echo "=============================="
echo " Backhaul Uninstaller"
echo " Author: pouyazamani"
echo "=============================="


if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi



echo "[+] Stop service"

systemctl stop backhaul 2>/dev/null || true



echo "[+] Disable service"

systemctl disable backhaul 2>/dev/null || true



echo "[+] Removing systemd service"


rm -f /etc/systemd/system/backhaul.service



echo "[+] Removing files"


rm -f /usr/local/bin/backhaul

rm -rf /etc/backhaul



echo "[+] Reload systemd"


systemctl daemon-reload

systemctl reset-failed



echo ""

echo "Backhaul removed successfully"

echo ""
