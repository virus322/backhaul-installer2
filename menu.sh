#!/usr/bin/env bash

# Backhaul Manager Menu
# Author: pouyazamani


clear


while true
do

echo "================================"
echo " Backhaul Manager"
echo " Author: pouyazamani"
echo "================================"

echo "1) نصب Backhaul"
echo "2) وضعیت سرویس"
echo "3) ریستارت"
echo "4) بهینه سازی شبکه"
echo "5) آپدیت"
echo "6) حذف کامل"
echo "7) خروج"

echo "================================"

read -p "انتخاب کنید: " choice


case $choice in


1)

echo "Installing..."

bash install.sh

;;


2)

systemctl status backhaul --no-pager

;;


3)

systemctl restart backhaul

echo "Restarted"

;;


4)

bash scripts/optimize.sh

;;


5)

bash scripts/update.sh

;;


6)

bash scripts/uninstall.sh

;;


7)

exit 0

;;


*)

echo "گزینه اشتباه"

;;

esac


echo ""

read -p "برای ادامه Enter بزنید..."

clear

done
