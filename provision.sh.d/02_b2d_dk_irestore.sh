
# ===================================================================
# Autoload b2d backups if any
#
# Note: okay its a copy past from .ashrc.d/21_boot2docker.sh but
#       this is not loaded at provisioning time so... Need to find
#       a way to improve this later.
# ===================================================================

# Configuration and preparation
BOOT2DOCKER_DK_IMAGES_SAVE_DIR="/vagrant/.vagrant/b2d_dk_images_backup"
echo "== Will restore all your b2d docker images from ${BOOT2DOCKER_DK_IMAGES_SAVE_DIR} !"

# Check if backup dir is present
if [ -d "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}" ]; then
    echo "[$(date +"%T")] Starting restore"

    # For each saved image
    for b2d_dk_image_saved in $BOOT2DOCKER_DK_IMAGES_SAVE_DIR/*.tgz ; do
        echo "[$(date +"%T")] Now restoring ${b2d_dk_image_saved}"
        gunzip -c "${b2d_dk_image_saved}" | docker load
    done

    # Done !
    echo "[$(date +"%T")] Restore completed completed !"
else
    echo "[INFO] No backup to restore !"
fi
