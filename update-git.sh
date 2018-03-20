#!/usr/bin/env bash
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel -y
yum install gcc perl-ExtUtils-MakeMaker -y
yum remove git
wget https://www.kernel.org/pub/software/scm/git/git-2.7.2.tar.gz
tar xzvf git-2.7.2.tar.gz
cd git-2.7.2
make prefix=/usr/local/git all
make prefix=/usr/local/git install
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/profile
git config --global http.sslversion tlsv1
cd .. && rm -rf git-2.7*
source /etc/profile