# MariaDB Replication Master-Master Cluster in Docker Containers

This repository maintains the scripts to build MariaDB Replication Master-Master Cluster in Docker Containers.

## What does it do

docker-compose.yml : 

    1. Replace the parameters in environment variables as your actual
    2. Using first-host.cnf for node 1 and second-host.cnf for node 2 in volumes mount

init.sh :

    1. Create user and grant permission for replication user
    2. Get the log position and name in master node
    3. Connect slave to master and start replication
    
## Example

You can test with command:

    docker-compose -f docker-compose.yml up -d

If it does not work, please download latest docker-compose and try again.

    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

When all containsers are running.

    # docker ps
    CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS     NAMES
    174b1c551e2a   mariadb          "docker-entrypoint.s…"   28 minutes ago   Up 28 minutes             mariadb
    
Initialize the relational cluster

    # docker exec -it mariadb sh /init.sh
    
Check the relational cluster status

    # docker exec mariadb mysql -uroot -p***** -e "show slave status\G;"
    *************************** 1. row ***************************
                Slave_IO_State: Waiting for master to send event
                   Master_Host: x.x.x.x
                   Master_User: repluser
                   Master_Port: 3306
                 Connect_Retry: 60
               Master_Log_File: mysqld-bin.000002
           Read_Master_Log_Pos: 343
                Relay_Log_File: mysqld-relay-bin.000006
                 Relay_Log_Pos: 643
         Relay_Master_Log_File: mysqld-bin.000002
              Slave_IO_Running: Yes
             Slave_SQL_Running: Yes
             ...
