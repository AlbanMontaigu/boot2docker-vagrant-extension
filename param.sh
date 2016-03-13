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
if [ -f "$BOOT2DOCKER_EXTENSION_PARAM_DIR/$1" ]; then
    echo "$2" > "$1"
fi
