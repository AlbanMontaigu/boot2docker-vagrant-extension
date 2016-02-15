#!/bin/sh

# ---------------------------------------------------------------------------
# Parametrization
#
# NOTE : Change the configuration 1.2.3.4 3128 to your correct proxy
# ---------------------------------------------------------------------------
BOOT2DOCKER_CONFIG_DIR="/var/lib/boot2docker/config"
BOOT2DOCKER_PROXY_DIR="$BOOT2DOCKER_CONFIG_DIR/proxy"
DK_REDSOCKS_PROXY_IP="$(b2d_proxy_host)"
DK_REDSOCKS_PROXY_PORT="$(b2d_proxy_port)"


# ---------------------------------------------------------------------------
# Redsocks container to avoid proxy definition for containers
#
# @see https://registry.hub.docker.com/u/ncarlier/redsocks/ 
# ---------------------------------------------------------------------------

# Start dk-resocks container
dk_redsocks_start(){

    echo "== Starting docker redsocks"
    docker run --privileged=true --net=host \
                -v $BOOT2DOCKER_PROXY_DIR/dk-resocks-whitelist.txt:/etc/redsocks-whitelist.txt \
                --name="dk-redsocks" -d \
                amontaigu/redsocks $DK_REDSOCKS_PROXY_IP $DK_REDSOCKS_PROXY_PORT
    echo "== Docker redsocks started !"
}

# Stop docker redsocks cointainer
dk_redsocks_stop(){

    echo "== Stoping docker redsocks"

    # Stops and remove container
    docker stop dk-redsocks
    docker rm dk-redsocks

    # Reverse iptable configuration to initial state
    iptables-save | grep -v REDSOCKS | iptables-restore

    echo "== Docker redsocks stoped !"
}

# ---------------------------------------------------------------------------
# Script and commands management
# ---------------------------------------------------------------------------
option="${1}" 
case ${option} in 
   start) dk_redsocks_start
      ;; 
  stop) dk_redsocks_stop
      ;; 
   *)  
      echo "`basename ${0}`:usage: START/STOP" 
      exit 1 # Command to come out of the program with status 1
      ;; 
esac 
