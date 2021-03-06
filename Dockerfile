FROM centos:centos6
LABEL author="airgull<airgull@sina.com>"
RUN yum -y groupinstall development
RUN yum -y install wget tar  crontabs curl-devel expat-devel gettext-devel devel zlib-devel perl-devel
# Install php rpm
RUN rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6 && \
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
# Install Git need package
RUN yum -y install curl-devel expat-devel gettext-devel devel zlib-devel perl-devel
# Install php-fpm (https://webtatic.com/packages/php56/
RUN yum -y install php56w php56w-fpm php56w-mbstring php56w-xml php56w-mysql php56w-pdo php56w-gd php56w-pecl-imagick php56w-opcache php56w-pecl-memcache php56w-pecl-xdebug php56w-bcmath
# Install php-mssql,mcrypt
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && \
    yum -y install php56w-mssql php56w-mcrypt
# Install Freetds(MSSQL)
RUN cd ~/ && \
    wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-0.95.87.tar.gz && \
    tar zxf ./freetds-0.95.87.tar.gz && \
    cd ./freetds-0.95.87 && \
    ./configure --prefix=/usr/local/freetds && \
    gmake && \
    gmake install && \
    rm -rf ~/freetds-0.95.87*
