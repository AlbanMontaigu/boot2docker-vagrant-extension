#!/bin/sh

# -------------------------------------------------
# Parametrization
# -------------------------------------------------
BOOT2DOCKER_CONFIG_DIR="/var/lib/boot2docker/config"
BOOT2DOCKER_PROVISIONING_DIR="$BOOT2DOCKER_CONFIG_DIR/provisioning"
HOME_DOCKER_USER="/home/docker"
BOOT2DOCKER_PROVISIONING_HOME_DOCKER_USER_DIR="$BOOT2DOCKER_PROVISIONING_DIR$HOME_DOCKER_USER"

# ----------------------------------------------------
# COPY alias file for docker user
# ----------------------------------------------------
echo "== Adding .alias to $HOME_DOCKER_USER !"
sudo cp -vf $BOOT2DOCKER_PROVISIONING_HOME_DOCKER_USER_DIR/.alias $HOME_DOCKER_USER/.alias
chown -v docker:staff $HOME_DOCKER_USER/.alias
echo "== .alias added to $HOME_DOCKER_USER !"

# ----------------------------------------------------
# ADD complements in .ashrc for docker user
# ----------------------------------------------------
echo "== Adding complements to $HOME_DOCKER_USER/.ashrc !"
cat $BOOT2DOCKER_PROVISIONING_HOME_DOCKER_USER_DIR/.ashrc >> $HOME_DOCKER_USER/.ashrc
chmod 777 /home/docker/.ashrc
echo "== Complements added to $HOME_DOCKER_USER/.ashrc !"
