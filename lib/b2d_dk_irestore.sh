
# ------------------------------------------------------------
# Docker images restore
# ------------------------------------------------------------

# Configuration and preparation
set -e
# Note: env var are defined twice I know since they are in environment.sh too but cron execution may not
#       give the right user context with .ashrc and environment preload. To find an other way to centralize
#       this
B2D_DK_IMAGES_SAVE_DIR="${1}"
B2D_DK_IMAGES_BACKUP_DEFINITION="/var/lib/boot2docker/extension/param.d/B2D_DK_IMAGES_BACKUP"
B2D_DK_IMAGES_BACKUP_USER_DEFINITION="/vagrant/boot2docker/dk_images_backup.txt"

# Start message
echo "[INFO] Will restore all your b2d docker images from ${B2D_DK_IMAGES_SAVE_DIR} according to your boot2docker/dk_images_backup.txt !"

# Check if backup dir and config file exist
#
# Note: BACKUP_USER_DEFINITION is optional and will be concatenated if any with BACKUP_DEFINITION file.
#       Cat will produce an error if optional file not present but it's redirected to /dev/null
#       to avoid perturbations in the process. A quick and simple way to avoid tons of tests.
if [ -d "${B2D_DK_IMAGES_SAVE_DIR}" ] && [ -f "${B2D_DK_IMAGES_BACKUP_DEFINITION}" ] ; then

    # Starting restore
    echo "[INFO][$(date +"%T")] Starting docker images restore..."
    while read -r image_to_restore || [[ -n "${image_to_restore}" ]]; do
        echo "[INFO][$(date +"%T")] Searching images matching with: ${image_to_restore}..."
        find "${B2D_DK_IMAGES_SAVE_DIR}" -name "${image_to_restore}" -exec sh -c "echo '[INFO][$(date +"%T")] Now restoring {}' && gunzip -c {} | docker load" \;
    done < cat "${B2D_DK_IMAGES_BACKUP_DEFINITION}" "${B2D_DK_IMAGES_BACKUP_USER_DEFINITION}" 2>/dev/null

    # Done !
    echo "[INFO][$(date +"%T")] Docker images restore completed !"
else
    echo "[INFO] No docker images backup to restore !"
fi
set +e
