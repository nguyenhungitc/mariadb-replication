#!/bin/bash

# Get the log position and name.
master_result=$(mysql -u root --password=$MARIADB_ROOT_PASSWORD --execute="reset master; show master status;")
master_log=$(echo $master_result | awk '{print $5}')
master_position=$(echo $master_result | awk '{print $6}')

# Connect slave to master.
mysql -u root --password=$MARIADB_ROOT_PASSWORD --execute="stop slave; reset slave; \
CHANGE MASTER TO MASTER_HOST='$MASTER_HOST_ADDRESS', MASTER_USER='$MARIADB_REPL_USER', \
MASTER_PASSWORD='$MARIADB_REPL_PASSWORD', MASTER_LOG_FILE='$master_log', MASTER_LOG_POS=$master_position; \
start slave; SHOW SLAVE STATUS\G;"
