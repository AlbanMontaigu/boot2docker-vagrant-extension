#!/bin/sh

# ===================================================================
# Regular docker backup command
# ===================================================================

# Get ibackup param
export CRON_DK_IBACKUP_STATUS=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/CRON_DK_IBACKUP_STATUS")
export CRON_DK_IBACKUP_TIME=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/CRON_DK_IBACKUP_TIME")
export CRON_DK_IBACKUP_LOGFILE="/var/log/cron_dk_ibackup.log"

# Check if the service is enabled
if [[ "$CRON_DK_IBACKUP_STATUS" == "ON" ]]; then
    echo "[INFO] Enabling CRON for regular docker image backup !"
    (crontab -l 2>/dev/null; echo "${CRON_DK_IBACKUP_TIME} ${BOOT2DOCKER_EXTENSION_LIB_DIR}/b2d_dk_ibackup.sh 2>&1 | tee -a ${CRON_DK_IBACKUP_LOGFILE}") | crontab -
else
    echo "[INFO] CRON for regular docker image backup is not enabled !"
fi
