#!/usr/bin/env bash

docker exec -ti $1 sh -c "export COMPOSER_MEMORY_LIMIT=-1"
docker exec -ti $1 sh -c "php -d memory_limit=-1 /usr/local/bin/composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=$3 /var/www/html/temp --ignore-platform-reqs"
docker exec -ti $1 sh -c 'mv /var/www/html/temp/* /var/www/html'
docker exec -ti $1 sh -c 'rm -rf /var/www/html/temp'
docker exec -ti $2 mysql "-e create database magento"
docker exec -ti $1 sh -c "php bin/magento setup:install --base-url=http://localhost/ --db-host=db --db-name=magento --db-user=$4 --db-password=$5 --admin-firstname=Admin --admin-lastname=User --admin-email=user@example.com --admin-user=admin --admin-password=admin123 --language=es_AR --currency=USD --timezone=America/Argentina/Buenos_Aires --use-rewrites=1"
docker exec -ti $2 mysql "-e use magento; insert into core_config_data (config_id, scope, scope_id, path, value) values (null, 'default', 0, 'dev/static/sign', 0);"