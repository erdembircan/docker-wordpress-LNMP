#!/usr/bin/env bash

#error wall
set -e

#user input
read -p "project name: " -r project_name
read -p "server port: " -r server_port
read -p "database root password: " -r db_password
read -p "database name: " -r db_name
read -p "database table prefix: " -r db_prefix
read -p "phpmyadmin port: " -r dbadmin_port

#empty argument check
if [[ -z "$project_name" ]] || [[ -z "$server_port" ]]
then
    echo "all fields are required"
    exit 1
fi

project_prefix=${project_name//[ ]/-}

cp docker-compose_template.yml docker-compose.yml

#rewrite the file with user arguments
sed -i "s/{server_port}/$server_port/g" docker-compose.yml
sed -i "s/{project_prefix}/$project_prefix/g" docker-compose.yml
sed -i "s/{db_password}/$db_password/g" docker-compose.yml
sed -i "s/{dbadmin_port}/$dbadmin_port/g" docker-compose.yml
sed -i "s/{db_name}/$db_name/g" docker-compose.yml
sed -i "s/{db_prefix}/$db_prefix/g" docker-compose.yml

