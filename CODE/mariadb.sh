echo "Cài đặt mariadb"

curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s -- --mariadb-server-version="mariadb-10.3"
yum install MariaDB-server MariaDB-client -y
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation

echo "Hoàn thành cài đặt mariadb"

exit 0
