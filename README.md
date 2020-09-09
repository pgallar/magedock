# MageDock

Created: Sep 9, 2020 9:20 AM
Created By: Pablo Gallar
Last Edited By: Pablo Gallar
Last Edited Time: Sep 9, 2020 10:01 AM

# What is?

MageDock initialize and create any project in Magento 2.x with docker.

MageDock install docker and docker compose if your system need to install it and initialize all containers required to run magento 2.x projects.

## Services and docker containers

MageDock start and initialize some services in docker containers:

- PHP (with xdebug included)
- Nginx
- Elasticsearch
- MySQL
- PHPMyAdmin

You can configure any settings for services (user/password for MySQL, xdebug ports, ports, etc.) editting docker-compose file and Dockerfile.

## Commands / actions

MageDock can run a lot of commands without connect to docker containers.

- **install**:
Install action run all commands to pull all containers required and configure them and install magento 2.x from composer or initialize the project if you have magento files into main directory.

    ```bash
    ./magedock install 2.3.5-p1
    ```

- **start**:
Start action run all docker containers:

    ```bash
    ./magedock start
    ```

- connect:
Connect action connect to php and composer docker container:

    ```bash
    ./magedock connect
    ```

- **stop**:
Stop action stop all docker containers:

    ```bash
    ./magedock stop
    ```

- **update**:
Update action build all changes in Dockerfile o docker-compose:

    ```bash
    ./magedock update
    ```

- **magento**:
Magento action run any magento 2.x command into project without need to connect directly to docker container:

    ```bash
    ./magedock magento se:up
    ./magedock magento se:di:compile
    ./magedock magento se:static-content:deploy -f
    ```

- **composer**:
Composer action run any php  composer command into project without need to connect directly to docker container:

    ```bash
    ./magedock composer install
    ./magedock composer update
    ```

- **mysql**:
MySQL action run any mysql command without need to connect directly to docker container:

    ```bash
    ./magedock mysql -proot magento -e 'show tables;'
    ```

- **dump**:
Dump action generate dump file from magento database and copy root project folder, the file is generated with today date on filename (yyyy-mm-dd.sql):

    ```bash
    ./magedock dump
    ```

- **refresh**:
Reresh action run magento commands to update and generate static files and content.
The magento commands that run are:
**se:up
se:di:compile
se:static-content:deploy -f**

    ```bash
    ./magedock refresh
    ```

## XDebug

PHP xdebug is configurated by 9090 port, you can change this port editting (and other settings) .docker/php/conf.d/docker-php-ext-xdebug.ini and .docker/docker-compose.yml file for export the xdebug port

```bash
[xdebug]
zend_extension = "/usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so"
xdebug.remote_enable= 1
xdebug.remote_port=9090
xdebug.remote_handler=dbgp
xdebug.remote_connect_back=0
xdebug.remote_host=host.docker.internal
xdebug.idekey=VSCODE
xdebug.remote_autostart=1
xdebug.remote_log=/usr/local/etc/php/xdebug.log
```

## FAQs

- **Elastisearch issue "max virtual memory areas vm.max_map_count [65530] is too low, increase to at least"**
You need to run this command:

    ```bash
    sudo sysctl -w vm.max_map_count=262144
    ```

    Or edit the file /etc/sysctl.conf adding this line:

    ```bash
    vm.max_map_count=262144
    ```