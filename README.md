# Docker images for development
-------------------------------

- Backup docker images for all service I used

Image | Description
------|-----------
mysql57.yaml | Create a mysql instance for version 5.7 (create a adminer in localhost:8080 to connect into database via php) |

## Indice

- [Mysql](#mysql)
- [Php 8.0.7](#compiling-php-807-into-asdf)

# Mysql
-------------
- Archive: mysql57.yaml
- Create the folder: /home/[user]/dockers/mysql57/conf.d/
    - In conf.d create a text file called ```my.conf``` with:
    - ```shell
      [mysqld] 
      max_connections=200
      ``` 
- Create the folder: /home/[user]/dockers/mysql57/db

# Compiling php 8.0.7 into asdf
-------------------------------

- Requirments:

```shell
sudo apt install -y pkg-config build-essential autoconf bison re2c \
                    libxml2-dev libsqlite3-dev libcurl4 libcurl4-openssl-dev \
                    libgd-dev libonig-dev libpq-dev libzip-dev \
```

- Then

```shell
asdf plugin-add php
asdf install php 8.0.7
``` 