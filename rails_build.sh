#!/bin/sh

# サーバプログラムをアップデート
sudo yum -y update

# 環境構築に必要なパッケージ諸々インストール
sudo yum -y install gcc-c++ openssl-devel readline-devel

# rbenv(Rubyのバージョン管理)のインストール
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# Rubyとbundlerのインストール
rbenv install 3.1.2
rbenv global 3.1.2
rbenv rehash
rbenv exec gem install bundler

# Railsインストールに必要なパッケージをインストール
sudo yum -y install patch libyaml-devel zlib zlib-devel libffi-devel make autoconf automake libcurl-devel sqlite-devel mysql-devel

# Node.jsをインストール(rails6の動作に必要)
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# yarnをインストール
sudo npm install -g yarn

# railsをインストール
gem install rails -v 6.1.4

# DBのインストール(SQLite)
wget https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz
tar xzvf sqlite-autoconf-3360000.tar.gz
cd sqlite-autoconf-3360000/
./configure --prefix=/opt/sqlite/sqlite3
make
sudo make install
/opt/sqlite/sqlite3/bin/sqlite3 --version
gem pristine --all
gem install sqlite3 -- --with-sqlite3-include=/opt/sqlite/sqlite3/include --with-sqlite3-lib=/opt/sqlite/sqlite3/lib
echo 'export LD_LIBRARY_PATH="/opt/sqlite/sqlite3/lib"' >> .bash_profile

echo "環境構築終了"