#!/bin/bash
# Skrypt do obsługi bazy MYSQL 

#set -x

read -p "Podaj użytkownika MySQL: " user_name
read -sp "Podaj hasło MySQL: " mysql_pwd
echo
read -p "Podaj komendę: " mysql_cmd
read -p "Na jakiej baize wykonać komendę:  mysql_db
mysql -u"$use_name" -p$mysql_pwd $mysql_db -Be"$mysql_cmd"

#set +x

