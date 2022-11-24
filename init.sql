CREATE USER 'repluser'@'x.x.x.x' IDENTIFIED BY '*****';
GRANT REPLICATION SLAVE ON *.* TO 'repluser'@'x.x.x.x';
FLUSH PRIVILEGES;
