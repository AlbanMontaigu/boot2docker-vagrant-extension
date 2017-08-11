
# ------------------------------------------------------------
# Docker images backup
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
echo "[INFO] Will save all your local b2d docker images to ${B2D_DK_IMAGES_SAVE_DIR} according to your boot2docker/dk_images_backup.txt !"

# Creating backup dir in case of
mkdir -p "${B2D_DK_IMAGES_SAVE_DIR}"

# Iterate each docker image available in the environment
for b2d_dk_image in $(docker images --format "{{.Repository}}:{{.Tag}}") ; do

    # Do not operate <none> tags
    if echo $b2d_dk_image | grep -q "<none>"  ; then
        echo "[INFO][$(date +"%T")] Skipping ${b2d_dk_image}"
    else
        # Path without ':' char (replaced by '_')
        path_b2d_dk_image_saved="${B2D_DK_IMAGES_SAVE_DIR}/$(echo ${b2d_dk_image} | sed 's#[/:<>]#_#g').tgz"

        # Decide if this image need to be saved according to configuration
        cat "${B2D_DK_IMAGES_BACKUP_DEFINITION}" "${B2D_DK_IMAGES_BACKUP_USER_DEFINITION}" 2>/dev/null | while read -r image_to_save || [[ -n "${image_to_save}" ]]; do
            if (echo "${path_b2d_dk_image_saved}" | grep -Eq "^${image_to_save}$"); then
                echo "[INFO][$(date +"%T")] Now saving ${b2d_dk_image} to ${path_b2d_dk_image_saved}"
                docker save "${b2d_dk_image}" | gzip -c > "${path_b2d_dk_image_saved}"
                break
            fi
        done
    fi
done

# Done !
echo "[INFO][$(date +"%T")] Save completed !"
set +e
