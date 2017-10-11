#!/bin/sh

# ================================================================
# Provision end (provision step to be done after any others)
#
#   - Basically execute any provision.sh.d script in b2d ext
#   - Allow to pass param.sh before provision-end.sh part
# ================================================================

# -------------------------------------------------
# Parametrization
# -------------------------------------------------
BOOT2DOCKER_EXTENSION_DIR="/var/lib/boot2docker/extension"
LOGFILE="/var/lib/boot2docker/log/vagrant-provision-end.log"

# General information
echo "[INFO][PROVISIONING-END] Starting... ($(date))" | tee -a $LOGFILE

# -------------------------------------------------
# Running local b2d ext provisioning file
# -------------------------------------------------
echo "[INFO] Now starting sub scripts..." | tee -a $LOGFILE
source $BOOT2DOCKER_EXTENSION_DIR/provision.sh 2>&1 | tee -a $LOGFILE


# General information
echo "[INFO][PROVISIONING-END] Ended ! ($(date))" | tee -a $LOGFILE
