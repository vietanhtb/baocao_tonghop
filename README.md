<!--
# h1
## h2
### h3
#### h4
##### h5
###### h6

*in nghiêng*

**bôi đậm**

***vừa in nghiêng vừa bôi đậm***

`inlide code`

```php

echo ("highlight code");

```

[Link test](https://viblo.asia/helps/cach-su-dung-markdown-bxjvZYnwkJZ)

![markdown](https://images.viblo.asia/518eea86-f0bd-45c9-bf38-d5cb119e947d.png)

* mục 3
* mục 2
* mục 1

1. item 1
2. item 2
3. item 3

***
horizonal rules

> text

{@youtube: https://www.youtube.com/watch?v=HndN6P9ke6U}
* Cài đặt nginx bằng câu lệnh sau
```php
dnf -y install nginx
```
*	Cấu hình nginx như sau
```php
vi /etc/nginx/nginx.conf

 Server{
     ...
     server_name www.srv.world;
     ...
 }
 
-->

# TÀI LIỆU HƯỚNG DẪN CÀI ĐĂT MỘT MÔ HÌNH HỆ THỐNG CƠ BẢN 
## Người viết : Phùng Công Việt Anh
### Mail: pcvietanh.99@gmail.com

***
# Mục lục
[1. Giới thiệu mô hình]

[2. Tiến hành cài đặt]

[3. Xử lý trong trường hợp phát sinh thêm server web]

***
## 1.	Giới thiệu mô hình
* Do giới hạn về mặt tài nguyên nên mô hình sẽ gồm:

    * Load balancing 192.168.1.19

    * Web server 1: 192.168.1.20

    * Web server 2: 192.168.1.21

    * Mấy 192.168.1.22 sẽ đóng vai trò làm 3 máy
        * Mariadb(mysql)

        * NFS server

        * Memcached server
## 2.	Tiến hành cài đặt
* Đầu tiên sẽ tiến hành cài đặt 4 con máy ảo với ip tương tự như trên
* Việc đầu tiên ở tất cả các máy chúng ta sẽ tiến hành tắt SELINUX và reboot lại hệ thống
```php
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config
reboot
```
* Sau đó ta sẽ tiến hành cài đặt bắt đầu từ máy 192.168.1.22 đầu tiên
* Ta hãy sử dụng những file sau trên kho code 
```php
#Copy Code của các file code sau hoặc tải các file code sau về và để chúng tại thư mục root
setup_NFS.sh
setup_mariadb.sh
setup_memcache.sh
setup_server_mariadb_nfs_memcache.sh
firewall_setup.sh

# Sau đó ta tiến hành cài đặt
chmod 755 setup_*
chmod 755 firewall_setup.sh

./setup_server_mariadb_nfs_memcache.sh

#Lưu ý code sẽ không tự động toàn bộ quá trình mà sẽ dừng lại để người dùng nhập 1 số thông tin cần thiết ví dụ như sau
#Nhập dải để cho sử dụng cho máy chủ NFS
#Tự thiết lập mật khẩu và 1 số mục trong mariadb
#Nhập ip để kích hoạt tường lửa mở khóa dịch vụ cho 2 máy web server
#Việc làm này khiến cho chúng ta có thể dễ dàng cài đặt trên các mô hình tương đương nhưng có dải ip khác với mô hình mà đang dự kiến sử dụng
#Khi quá trình cài đặt đã hoàn thành hãy kiểm tra lại xem có phần nào bị lỗi không

```
* Tiếp theo sẽ tiến hành cài đặt máy web server
```php
#Sử dụng file code 
setup_web_server.sh

#Phân quyền 
chmod 755 setup_web_server.sh
./setup_web_server.sh

#Nhập ip của máy chủ NFS-Memcached-mariadb và chờ đợi cài đặt
#sau khi cài đặt thành công ta sẽ kiểm tra các cổng bằng cách cài đặt telnet
yum -y install telnet

#sau đó kiểm tra các cổng sau
telnet 192.168.1.21 11211

telnet 192.168.1.21 3306

telnet 192.168.1.21 2049

telnet 192.168.1.21 20048

#Riêng cổng 3306 thì kết nối vào là đóng luôn do chưa thiết lập tài khoản kết nối từ xa vấn đề này ta sẽ quay lại máy chủ chứ mariadb và tạo tài khoản cho phép truy cập từ xa

#Trên máy chủ
#truy cập vào mysql
mysql -u root -p
#Tạo tài khoản mới để truy cập từ xa
create user 'va123'@'%' identified by 'vietanh99tb';

GRANT ALL PRIVILEGES ON *.* TO 'va123'@'192.168.1.20' IDENTIFIED BY 'vietanh99tb';

GRANT ALL PRIVILEGES ON *.* TO 'va123'@'192.168.1.21' IDENTIFIED BY 'vietanh99tb';

FLUSH PRIVILEGES;
#Hoặc sử dụng tài khoản root để truy cập từ xa

GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.1.20' IDENTIFIED BY 'vietanh99tb' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.1.21' IDENTIFIED BY 'vietanh99tb' WITH GRANT OPTION;

FLUSH PRIVILEGES;

#Sau đó quay lại bên web server thì telnet sẽ kết nối bình thường

```
* Cuối cùng là thiết lập cân bằng tải tại máy 192.168.1.19
```php
#Sử dụng file code 
setup_loadbalancing.sh

#Phân quyền cho file
chmod 755 setup_loadbalancing.sh

#Chạy tools cài đặt
./setup_loadbalancing.sh

#Nhập ip của web server số 1 và web server số 2 sau đó chờ
```

