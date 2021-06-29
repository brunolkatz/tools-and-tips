# Tools and Tips 

- Tools I used for development
- Methods I used for create protobuf files
- Backup docker images for all service I used
- and more..

# Topics

- [Mysql 5.7 docker image](#mysql)
- [Php 8.0.7 with asdf](#compiling-php-807-into-asdf)
- [SQL Server docker image](#sql-server-latest)
- [Stop nodes (pids) Script](#stop-nodes-pids)
- [Compiling Protobuf Files](#compiling-protobuf-files)
- [Export MySQl tables to Go struct](#export-mysql-tables-to-go-struct)
- [Git Credential Manager Core (create a secure way to store git username/passwords (ubuntu))](#git-credential-manager-core)
- [Curl message and data validation to Bash](#bash-data-validation-and-curl-messages)


# Mysql
-------------
- Archive: mysql57.yaml

- Image | Description
  ------|-----------
  mysql57.yaml | Create a mysql instance for version 5.7 (create a adminer image in localhost:9898 to connect into mysql database via php) |

- Create the folder: ```/home/[user]/dockers/mysql57/conf.d/```
    - In ```conf.d``` directory create a text file called ```my.conf``` with:
    - ```shell
      [mysqld] 
      max_connections=200
      ``` 
- Create the folder: ```/home/[user]/dockers/mysql57/db```

# Compiling php 8.0.7 into asdf
-------------------------------

Requirments:
[
- Install all necessary packages
```shell
sudo apt install -y pkg-config build-essential autoconf bison re2c \
                    libxml2-dev libsqlite3-dev libcurl4 libcurl4-openssl-dev \
                    libgd-dev libonig-dev libpq-dev libzip-dev
```

- Then install php 8.0.7

```shell
asdf plugin-add php
asdf install php 8.0.7
``` 

# SQL server (latest)
-------------------------------

- Start server with:

```shell
docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=bfd972@!' -p 1433:1433 -d mcr microsoft.com/mssql/server:2017-latest
```

# Stop Nodes PIDs
-------------------------------

- Create a stop_nodes.sh file with:

```shell
#!/bin/bash
# declare all ports are used
declare -a portsServices=("9000" "9001" "9002" "9003" "9004" "9005" "9006" "9007")

# get length of array
portArrayLength=${#portsServices[@]}

# Kill all ports if exists
for (( i=1; i<${portArrayLength}+1; i++ ));
do
  echo "Killing port: - "  $i " / " ${portArrayLength} " : " ${portsServices[$i-1]}
  echo "Killing PID: " $(lsof -t -i:${portsServices[$i-1]})
  lsof -n -i:${portsServices[$i-1]} | grep LISTEN | tr -s ' ' | cut -f 2 -d ' ' | xargs kill -9
done
```

- Make executable with ```chmod +x stop_node.sh``` 

# Compiling Protobuf Files
-------------------------------

- See protobuf folder [```readme.md```](./protobuf/README.md) file

# Export MySQl tables to Go struct
-------------------------------

- Clone the repository: ```https://github.com/xxjwxc/gormt```
- Compile
- Configure ```config.xml``` file to your database
- Execute ```./gormt```


# Git Credential Manager Core

- For remote repositories we don't have access to use ssh key

1. Download the last `.deb` release of credential manager core: [Here](https://github.com/microsoft/Git-Credential-Manager-Core/releases/tag/v2.0.475)
2. Install package ```sudo dpkg -i <path-to-package>```
3. Configure the gui (if have (in ubuntu, will open in terminal only))
  ```
  export GCM_CREDENTIAL_STORE=secretservice
  # or
  git config --global credential.credentialStore secretservice
  ``` 
  4. Finish, after the next time you needed to use the username/password, they will store your data encrypted saffely.

  # Bash data validation and curl messages

  - See [curlToVariable.sh](./curlToVariableBash.sh) archive in this directory
