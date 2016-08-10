#!/bin/sh
export newpswd=$1
mysql -u root -proot -e < "set @newpswd='${newpswd}';source mysql-changepswd.sql ;";
