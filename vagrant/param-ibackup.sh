#!/bin/sh

# -------------------------------------------------
# Parametrization
# -------------------------------------------------
BOOT2DOCKER_EXTENSION_DIR="/var/lib/boot2docker/extension"
BOOT2DOCKER_EXTENSION_PARAM="$BOOT2DOCKER_EXTENSION_DIR/param.sh"
LOGFILE="/var/lib/boot2docker/log/vagrant-param-ibackup.log"


# -------------------------------------------------
# Execute param.sh if present to enable
# live customization
# -------------------------------------------------
if [ -f $BOOT2DOCKER_EXTENSION_PARAM ]; then
   echo "[INFO][PARAM-IBACKUP] Starting... ($(date))" | tee -a $LOGFILE
   $BOOT2DOCKER_EXTENSION_PARAM "B2D_DK_IMAGES_BACKUP" "$1" "--append" 2>&1 | tee -a $LOGFILE
   echo "[INFO][PARAM-IBACKUP] Ended ! ($(date))" | tee -a $LOGFILE
else
   echo "[WARN][PARAM-IBACKUP] Param not found, try PROVISION before !" | tee -a $LOGFILE
fi
