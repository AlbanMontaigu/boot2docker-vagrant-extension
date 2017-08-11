
# ------------------------------------------------------------
# Docker images restore
# ------------------------------------------------------------

# Configuration and preparation
set -e
BOOT2DOCKER_DK_IMAGES_SAVE_DIR="${1}"
echo "[INFO] Will restore all your b2d docker images from ${BOOT2DOCKER_DK_IMAGES_SAVE_DIR} !"

# Check if backup dir is present
if [ -d "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}" ]; then
    echo "[INFO][$(date +"%T")] Starting restore"

    # For each saved image
    for b2d_dk_image_saved in $BOOT2DOCKER_DK_IMAGES_SAVE_DIR/*.tgz ; do
        echo "[INFO][$(date +"%T")] Now restoring ${b2d_dk_image_saved}"
        gunzip -c "${b2d_dk_image_saved}" | docker load
    done

    # Done !
    echo "[INFO][$(date +"%T")] Restore completed completed !"
else
    echo "[INFO] No backup to restore !"
fi
set +e
