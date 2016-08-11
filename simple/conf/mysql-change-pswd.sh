#!/bin/sh
export newpswd=$1
mysql -u root -proot -e "set @newdbpswd='${newpswd}'; source \. /mysql-change-pswd.sql"