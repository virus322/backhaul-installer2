# 🚀 Backhaul Professional Installer

## نصب کننده حرفه‌ای تانل Backhaul

سازنده:
**pouyazamani**

مخزن:
**virus322/backhaul-installer2**


---

# معرفی پروژه

این پروژه یک نصب کننده خودکار و حرفه‌ای برای راه‌اندازی تانل بین دو سرور با استفاده از Backhaul است.

هدف پروژه:

- نصب سریع بدون تنظیم دستی
- ساخت سرویس دائمی
- اجرای خودکار بعد از ریبوت
- مدیریت ساده
- مناسب برای سرور ایران و خارج


---

# معماری پیشنهادی

```
Client User

      |

      |

سرور ایران

      |

      |

Backhaul Tunnel

      |

      |

سرور خارج

```


در حالت معمول:

```
ایران = Client

خارج = Server
```


---

# امکانات

✅ نصب خودکار Backhaul

✅ تشخیص معماری CPU

✅ ساخت کانفیگ خودکار

✅ ساخت سرویس Systemd

✅ اجرای خودکار بعد از روشن شدن سرور

✅ باز کردن پورت فایروال

✅ فعال بودن Restart خودکار

✅ ابزار مدیریت

✅ بهینه سازی شبکه


---

# نیازمندی‌ها

سیستم پیشنهادی:

- Ubuntu 20.04
- Ubuntu 22.04
- Debian 11
- Debian 12


نیاز:

- دسترسی root
- IPv4 فعال
- پورت آزاد


---

# نصب سریع


روی هر دو سرور:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/virus322/backhaul-installer2/main/install.sh)
```


---

# نصب سرور خارج (Server)


روی سرور خارج اجرا کنید:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/virus322/backhaul-installer2/main/install.sh)
```


انتخاب:

```
1
```


بعد:

پورت تانل را وارد کنید.


مثال:

```
3080
```


بعد از نصب:

بررسی سرویس:


```bash
systemctl status backhaul
```


---

# نصب سرور ایران (Client)


روی سرور ایران:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/virus322/backhaul-installer2/main/install.sh)
```


انتخاب:

```
2
```


IP سرور خارج را وارد کنید:


مثال:

```
91.107.148.66
```


پورت را وارد کنید:

```
3080
```


---

# مدیریت سرویس


وضعیت:

```bash
systemctl status backhaul
```


شروع:

```bash
systemctl start backhaul
```


خاموش:

```bash
systemctl stop backhaul
```


ریستارت:

```bash
systemctl restart backhaul
```


فعال کردن بعد از ریبوت:

```bash
systemctl enable backhaul
```


---

# فایل‌های پروژه


```
backhaul-installer2

├── install.sh

├── menu.sh

├── README.md


├── scripts

│   ├── optimize.sh

│   ├── update.sh

│   └── uninstall.sh


└── systemd

    └── backhaul.service

```


---

# ابزار مدیریت


اجرا:

```bash
bash menu.sh
```


منو:

```
1 نصب
2 وضعیت
3 ریستارت
4 بهینه سازی
5 آپدیت
6 حذف
7 خروج
```


---

# بهینه سازی شبکه


اجرا:

```bash
bash scripts/optimize.sh
```


فعال می‌کند:

- TCP BBR
- افزایش Buffer شبکه
- TCP Fast Open
- IP Forward


---

# آپدیت


برای آپدیت:

```bash
bash scripts/update.sh
```


---

# حذف کامل


```bash
bash scripts/uninstall.sh
```


تمام موارد حذف می‌شوند:

- سرویس
- فایل اجرایی
- تنظیمات


---

# محل تنظیمات


```
/etc/backhaul/config.toml
```


---

# عیب‌یابی


مشاهده لاگ:

```bash
journalctl -u backhaul -f
```


بررسی پورت:

```bash
ss -tulpn
```


بررسی BBR:

```bash
sysctl net.ipv4.tcp_congestion_control
```


---

# نکات مهم


- پورت انتخابی باید باز باشد
- هر دو سرور ساعت درست داشته باشند
- برای پایداری بهتر از VPS نزدیک استفاده شود
- IPv4 پیشنهاد می‌شود


---

# سازنده


pouyazamani

 |
 |
سرور ایران
 |
 |
Backhaul Tunnel
 |
 |
سرور خارج
```

معمولاً:

سرور خارج = Server

سرور ایران = Client


# نصب

روی هر دو سرور اجرا کنید:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/virus322/backhaul-installer2/main/install.sh)
```


# تنظیم سرور خارج

روی سرور خارج:

گزینه:

```
1
```

را انتخاب کنید.


پورت پیش فرض:

```
3080
```


فایل تنظیمات:

```
/etc/backhaul/config.toml
```


بررسی سرویس:

```bash
systemctl status backhaul
```


# تنظیم سرور ایران

روی سرور ایران:

اجرا:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/virus322/backhaul-installer2/main/install.sh)
```


گزینه:

```
2
```

را انتخاب کنید.


IP سرور خارج را وارد کنید.


مثال:

```
91.107.148.66
```


# دستورات مدیریت


وضعیت:

```bash
systemctl status backhaul
```


ریستارت:

```bash
systemctl restart backhaul
```


توقف:

```bash
systemctl stop backhaul
```


شروع:

```bash
systemctl start backhaul
```


# محل کانفیگ

```
/etc/backhaul/config.toml
```


# حذف کامل

```bash
systemctl stop backhaul

systemctl disable backhaul

rm -rf /etc/backhaul

rm /usr/local/bin/backhaul

rm /etc/systemd/system/backhaul.service

systemctl daemon-reload
```


# نکات

- پورت Backhaul باید باز باشد
- Ubuntu/Debian پیشنهاد می‌شود
- برای پینگ بهتر از VPS نزدیک استفاده کنید


# Author

pouyazamani
