
# ------------------------------------------------------------
# Docker images restore
# ------------------------------------------------------------

# Configuration and preparation
set -e
BOOT2DOCKER_DK_IMAGES_SAVE_DIR="${1}"
B2D_DK_IMAGES_BACKUP_FILE="/vagrant/boot2docker/dk_images_backup.txt"

# Start message
echo "[INFO] Will restore all your b2d docker images from ${BOOT2DOCKER_DK_IMAGES_SAVE_DIR} according to your boot2docker/dk_images_backup.txt !"

# Check if backup dir and config file exist
if [ -d "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}" ] && [ -f "${B2D_DK_IMAGES_BACKUP_FILE}" ] ; then

    # Starting restore
    echo "[INFO][$(date +"%T")] Starting docker images restore..."
    while read -r image_to_restore || [[ -n "${image_to_restore}" ]]; do
        echo "[INFO][$(date +"%T")] Searching images matching with: ${image_to_restore}..."
        find "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}" -name "${image_to_restore}" -exec sh -c "echo '[INFO][$(date +"%T")] Now restoring {}' && gunzip -c {} | docker load" \;
    done < "${B2D_DK_IMAGES_BACKUP_FILE}"

    # Done !
    echo "[INFO][$(date +"%T")] Docker images restore completed !"
else
    echo "[INFO] No docker images backup to restore !"
fi
set +e
