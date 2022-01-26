#! /bin/bash

echo "Nhập dải ip của máy để phục vụ cài đặt NFS(ví dụ: 192.168.1.0)"
read A
./setup_mariadb.sh
./setup_memcached.sh

echo "Dải ip được cấp cho NFS là là : 192.168.1.0"

./setup_NFS 

echo "Nhập ip của máy Web server số 1 (192.168.1.20)"
read B

echo "Nhập ip của máy Web server số 2 (192.168.1.21)"
read C

echo "Thiết lập firewall"

./firewall_setup 192.168.1.20
./firewall_setup 192.168.1.21

exit 0