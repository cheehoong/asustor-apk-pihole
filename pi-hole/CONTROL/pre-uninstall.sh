#!/bin/sh

echo "pre-uninstall"

container=$(docker ps -a | grep pihole | awk '{print $1}')
im=$(docker images | grep pihole | awk '{print $3}' )
echo $container
echo $im
if [ -z $container ]; then 
 echo
else
  docker kill $container
fi
if [ -z $container ]; then 
  echo
else
  docker rm  $container
fi
if [ -z $im ]; then 
  echo
else
  docker rmi $im
fi



