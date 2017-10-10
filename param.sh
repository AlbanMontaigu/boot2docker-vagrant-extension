#!/bin/sh

# ===================================================================
# Provisioning script executed during vagrant provision to
# change persistent param located in param dir.
# ===================================================================


# ------------------------------------------------------------
# Environment definition (params and so on)
# ------------------------------------------------------------
source /var/lib/boot2docker/extension/environment.sh


# -------------------------------------------------------------------
# Change param values if possible
# -------------------------------------------------------------------
BOOT2DOCKER_EXTENSION_PARAM_FILE="${BOOT2DOCKER_EXTENSION_PARAM_DIR}/${1}"
if [ -f $BOOT2DOCKER_EXTENSION_PARAM_FILE ]; then
    if [[ "${3}" == "--append" ]]; then
        echo "${2}" >> $BOOT2DOCKER_EXTENSION_PARAM_FILE
    else
        echo "${2}" > $BOOT2DOCKER_EXTENSION_PARAM_FILE
    fi
    echo "[INFO] ${BOOT2DOCKER_EXTENSION_PARAM_FILE} updated with value=${2}"
else
    echo "[WARN] ${BOOT2DOCKER_EXTENSION_PARAM_FILE} not found so not updated"
fi
