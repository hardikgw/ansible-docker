DROP DATABASE IF EXISTS demo;
CREATE DATABASE demo;
DROP USER IF EXISTS 'demo'@'%';
CREATE USER 'demo'@'%' IDENTIFIED BY 'demopw';
GRANT ALL PRIVILEGES ON *.* TO 'demo'@'%';