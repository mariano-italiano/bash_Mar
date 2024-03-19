#!/bin/bash

dnf install -y mysql-server
systemctl enable --now mysqld.service
mysql_secure_installation

#mysql -u root -p
