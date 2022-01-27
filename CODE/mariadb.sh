#! /bin/bash

dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y


echo "[mariadb]" >> /etc/yum.repos.d/MariaDB.repo
echo "name = MariaDB" >> /etc/yum.repos.d/MariaDB.repo
echo "baseurl = https://mirrors.bkns.vn/mariadb/yum/10.3/rhel8-amd64" >> /etc/yum.repos.d/MariaDB.repo
echo "module_hotfixes=1" >> /etc/yum.repos.d/MariaDB.repo
echo "gpgkey=https://mirrors.bkns.vn/mariadb/yum/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo

echo "Cài đặt mariadb"

dnf install -y MariaDB-server
systemctl enable --now mariadb
systemctl start mariadb
mysql_secure_installation



exit 0
