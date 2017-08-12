#!/bin/bash
####################################################################################
#
# 				System:Centos6/7
# 				Yum:default
# 				Server:
# 					Mysql:5.6.36
#					Apache:2.4.25
#					PHP:5.6.9
#            
#        
#################################################################################### 

#MAKE DIR
mkdir /web && \
mkdir /web/{server,www,upload,log,conf,lib}&& \
mkdir /web/server/{apache,mysql,php,nginx}&& \
mkdir /web/server/mysql/{data,tmp,log}

#MAKE USERS
groupadd web 
useradd -g web mysql 
useradd -g web www 

# INSTALL LIB

yum install gcc gcc-c++ -y&& \ 
yum install libtool -y&& \
yum install libtool-ltdl-devel -y&& \
yum install libtool-ltdl -y&& \
yum install libvpx libvpx-devel -y&& \
yum install libjpeg-turbo libjpeg-turbo-devel -y&& \
yum install libpng libpng-devel -y&& \
yum install libzip libzip-devel -y&& \
yum install libXpm libXpm-devel -y&& \
yum install freetype freetype-devel -y&& \
yum install t1lib  t1lib-devel -y&& \
yum install openssl openssl-devel -y&& \
yum install zlib zlib-devel -y&& \
yum install bzip2 bzip2-devel -y&& \
yum install libxml2 libxml2-devel -y&& \
yum install gd gd-devel -y&& \
yum install gettext gettext-devel -y&&  \
yum install gmp gmp-devel -y&&  \
yum install curlpp-devel curl -y&& \
yum install libcurl-devel libcurl -y

#INSTALL APR
cd /web/upload/&& \
wget https://mirrors.tuna.tsinghua.edu.cn/apache/apr/apr-1.6.2.tar.gz&& \
tar -xzvf apr-1.6.2.tar.gz&& \
cd apr-1.6.2&& \

./configure \
--prefix=/web/server/lib/apr \
--enable-shared=yes \
--enable-static=no&& \
make && make install

#INSTALL APR-UTIL
cd /web/upload&& \
wget https://mirrors.tuna.tsinghua.edu.cn/apache/apr/apr-util-1.6.0.tar.gz&& \
tar -xzvf apr-util-1.6.0.tar.gz&& \
cd apr-util-1.6.0&& \
./configure --prefix=/web/server/lib/apr-util \
-with-apr=/web/server/lib/apr \
--enable-shared=yes \
 --enable-static=no&& \
 make && make install

#INSTALL PCRE
cd /web/upload&& \
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.tar.gz && tar -xzvf pcre-8.41.tar.gz&& \
cd pcre-8.41&& \
./configure \
--prefix=/web/server/lib/pcre \  
--enable-shared=yes \
--enable-static=no&& \
make && make install

#INSTALL APACHE
cd /web/upload&& \
wget https://mirrors.tuna.tsinghua.edu.cn/apache/httpd/httpd-2.4.27.tar.gz&& \
tar -xzvf httpd-2.4.27.tar.gz&& \
cd /web/upload/httpd-2.4.27&& \
./configure --prefix=/web/server/apache \
--with-apr=/web/server/lib/apr \
--with-apr-util=/web/server/lib/apr-util \
--with-pcre=/web/server/lib/pcre \
--enable-all \
--enable-rewrite \
--enable-so \
--enable-cache \
--enable-shared=yes \
--enable-modules=all \
--enable-static=no \
&&make && make install&& \
chown -R www:web /web/server/apache

#INSTALL MYSQL
cd /web/upload/&& \
wget https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/MySQL-5.6/mysql-5.6.36-linux-glibc2.5-x86_64.tar.gz&& \
tar -xzvf mysql-5.6.36-linux-glibc2.5-x86_64.tar.gz
cd mysql-5.6.36-linux-glibc2.5-x86_64&& \
\cp -rfv * /web/server/mysql/&& \

chown -R mysql:web /web/server/mysql&& \
./scripts/mysql_install_db \
--basedir=/web/server/mysql \
--datadir=/web/server/mysql/data \
--user=mysql 

rm -rf /etc/my.cnf
\cp -rfv /web/server/mysql/support-files/mysql.server /etc/init.d/mysql
ln -s /web/server/mysql/my.cnf /etc/my.cnf
chown -R mysql:web /web/server/mysql

#INSTALL PHP
cd /web/upload&& \
wget http://museum.php.net/php5/php-5.6.9.tar.gz&& \
tar -xzvf  php-5.6.9.tar.gz&& \
cd  php-5.6.9&& \
./configure --prefix=/web/server/php --with-mysql=/web/server/mysql --with-mysqli=/web/server/mysql/bin/mysql_config --with-apxs2=/web/server/apache/bin/apxs --with-config-file-path=/web/server/php/ --with-openssl --with-kerberos --with-zlib --with-bz2 --enable-calendar --enable-exif --enable-ftp --with-gd --with-zlib --enable-zip --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-mbstring --with-curl --with-freetype-dir=/usr --enable-mysqlnd&& \
make && make install

# ./configure \
# --prefix=/web/server/php \
# --with-mysql=/web/server/mysql&& \
# --with-mysqli=/web/server/mysql/bin/mysql_config \
# --with-apxs2=/web/server/apache/bin/apxs \
# --with-config-file-path=/web/server/php \
# --with-openssl \
# --with-kerberos \
# --with-zlib \
# --with-gd \
# --with-bz2 \
# --with-zlib \ 
# --with-curl \ 
# --with-freetype-dir=/usr \ 
# --enable-calendar \
# --enable-exif \
# --enable-ftp \
# --enable-zip \
# --enable-sysvmsg \
# --enable-sysvsem \ 
# --enable-sysvshm \ 
# --enable-mbstring \ 
# --enable-mysqlnd












