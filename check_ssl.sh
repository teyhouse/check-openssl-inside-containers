#!/bin/bash

# get all container
containers=$(sudo docker ps | awk '{if(NR>1) print $NF}')
host=$(hostname)

# loop through all containers
for container in $containers
do
  verssl=$(docker exec $container openssl version)

  if [[ $verssl =~ "OCI" ]]; then
   echo "$container: No OpenSSL found."
  else
   if [[ $verssl =~ "3." ]]; then
    echo -e "\e[1m\e[91mDocker container $container has potential vulnerable OpenSSL-Version: $verssl"
   else
    echo -e "\033[0mDocker container $container has OpenSSL-Version: $verssl "
   fi
  fi

  echo ================================
done