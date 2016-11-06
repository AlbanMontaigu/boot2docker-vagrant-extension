
# ------------------------------------------------------------
# Docker images backup
# ------------------------------------------------------------

# Configuration and preparation
set -e
BOOT2DOCKER_DK_IMAGES_SAVE_DIR="${1}"
echo "[INFO] Will save all your local b2d docker images to ${BOOT2DOCKER_DK_IMAGES_SAVE_DIR} !"
echo "[INFO] Cleaning previous backup"
rm -rvf "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}"
mkdir -p "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}"
echo "[INFO][$(date +"%T")] Starting save"

# Iterate each docker image
for b2d_dk_image in $(docker images --format "{{.Repository}}:{{.Tag}}") ; do

    # Do not operate <none> tags
    if echo $b2d_dk_image | grep -q "<none>"  ; then
        echo "[INFO][$(date +"%T")] Skipping ${b2d_dk_image}"
    else
        # Path without ':' char (replaced by '_')
        path_b2d_dk_image_saved="${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}/$(echo ${b2d_dk_image} | sed 's#[/:<>]#_#g').tgz"
        echo "[INFO][$(date +"%T")] Now saving ${b2d_dk_image} to ${path_b2d_dk_image_saved}"
        docker save "${b2d_dk_image}" | gzip -c > "${path_b2d_dk_image_saved}"
    fi
done

# Done !
echo "[INFO][$(date +"%T")] Save completed !"
set +e
