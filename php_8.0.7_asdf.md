# Compiling php 8.0.7 into asdf


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