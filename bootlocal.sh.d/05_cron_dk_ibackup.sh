#!/bin/sh

# ===================================================================
# Regular docker backup command
# ===================================================================

# Check if the service is enabled
if [[ "$CRON_DK_IBACKUP_STATUS" == "ON" ]]; then
    echo "[INFO] Enabling CRON for regular docker image backup !"
    (crontab -l 2>/dev/null; echo "${CRON_DK_IBACKUP_TIME} ${BOOT2DOCKER_EXTENSION_LIB_DIR}/b2d_dk_ibackup.sh ${BOOT2DOCKER_DK_IMAGES_SAVE_DIR} 2>&1 | tee -a ${CRON_DK_IBACKUP_LOGFILE}") | crontab -
else
    echo "[INFO] CRON for regular docker image backup is not enabled !"
fi
