#!/usr/bin/env bash

# Backhaul Network Optimizer
# Author: pouyazamani

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi


echo "=============================="
echo " Backhaul Network Optimize"
echo " Author: pouyazamani"
echo "=============================="


echo "[+] Updating system"

apt update -y

apt install -y curl wget


echo "[+] Enabling BBR"


cat > /etc/sysctl.d/99-backhaul.conf <<EOF

net.core.default_qdisc=fq

net.ipv4.tcp_congestion_control=bbr

net.core.rmem_max=134217728

net.core.wmem_max=134217728

net.ipv4.tcp_rmem=4096 87380 67108864

net.ipv4.tcp_wmem=4096 65536 67108864

net.ipv4.tcp_fastopen=3

net.ipv4.ip_forward=1

EOF


sysctl --system


echo "[+] Setting limits"


cat >> /etc/security/limits.conf <<EOF

* soft nofile 65535

* hard nofile 65535

EOF



echo "[+] Restarting Backhaul"

systemctl restart backhaul 2>/dev/null || true


echo ""
echo "Optimization completed"
echo ""


echo "Check BBR:"
echo "sysctl net.ipv4.tcp_congestion_control"
