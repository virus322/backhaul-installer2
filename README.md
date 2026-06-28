# Backhaul Installer

## نصب کننده خودکار تانل Backhaul

سازنده:
pouyazamani


## معرفی

این پروژه یک نصب کننده خودکار برای راه اندازی تانل Backhaul بین سرور ایران و خارج است.

امکانات:

- نصب خودکار Backhaul
- ساخت سرویس Systemd
- اجرای خودکار بعد از ریبوت
- حالت Server و Client
- مدیریت ساده


## معماری تانل

```
کاربر
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
