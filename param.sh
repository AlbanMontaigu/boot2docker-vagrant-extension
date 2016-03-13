#!/bin/sh

# ===================================================================
# Provisionning script executed during vagrant provision to
# change persistent param located in param dir.
# ===================================================================


# -------------------------------------------------------------------
# Parametrization (for all environment)
# -------------------------------------------------------------------
export BOOT2DOCKER_EXTENSION_DIR="/var/lib/boot2docker/extension"
export BOOT2DOCKER_EXTENSION_PARAM_DIR="$BOOT2DOCKER_EXTENSION_DIR/param.d"


# -------------------------------------------------------------------
# Change param values if possible
# -------------------------------------------------------------------
BOOT2DOCKER_EXTENSION_PARAM_FILE="$BOOT2DOCKER_EXTENSION_PARAM_DIR/$1"
if [ -f $BOOT2DOCKER_EXTENSION_PARAM_FILE ]; then
    echo "$2" > $BOOT2DOCKER_EXTENSION_PARAM_FILE
    echo "[INFO] $BOOT2DOCKER_EXTENSION_PARAM_FILE updated with value=$2"
else
    echo "[WARN] $BOOT2DOCKER_EXTENSION_PARAM_FILE not found so not updated"
fi
