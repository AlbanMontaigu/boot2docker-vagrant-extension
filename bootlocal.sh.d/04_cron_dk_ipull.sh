#!/bin/sh

# ===================================================================
# Regular docker pull command
# ===================================================================

# Check if the service is enabled
if [[ "$CRON_DK_IPULL_STATUS" == "ON" ]]; then
    echo "[INFO] Enabling CRON for regular docker pull !"
    (crontab -l 2>/dev/null; echo "${CRON_DK_IPULL_TIME} ${BOOT2DOCKER_EXTENSION_LIB_DIR}/b2d_dk_ipull.sh 2>&1 | tee -a ${CRON_DK_IPULL_LOGFILE}") | crontab -
else
    echo "[INFO] CRON for regular docker pull is not enabled !"
fi
