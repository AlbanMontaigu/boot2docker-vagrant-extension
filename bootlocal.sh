#!/bin/sh

# -------------------------------------------------------------------
# Parametrization (for all environment)
# -------------------------------------------------------------------
export BOOT2DOCKER_CONFIG_DIR="/var/lib/boot2docker/config"
export HOME_DOCKER_USER="/home/docker"


# -------------------------------------------------------------------
# ADD complements in .ashrc for docker user
# -------------------------------------------------------------------
echo "== Adding complements to $HOME_DOCKER_USER/.ashrc !"
cat $BOOT2DOCKER_CONFIG_DIR/ash/.ashrc >> $HOME_DOCKER_USER/.ashrc
echo "== Complements added to $HOME_DOCKER_USER/.ashrc !"
