
# ============================================================
# All environment definition is now located here to be
# available in a single location for all scripts.
# ============================================================


# -------------------------------------------------------------------
# Static parameters
# -------------------------------------------------------------------
export BOOT2DOCKER_EXTENSION_DIR="/var/lib/boot2docker/extension"
export BOOT2DOCKER_EXTENSION_LIB_DIR="$BOOT2DOCKER_EXTENSION_DIR/lib"
export BOOT2DOCKER_EXTENSION_PARAM_DIR="${BOOT2DOCKER_EXTENSION_DIR}/param.d"
export BOOT2DOCKER_DK_IMAGES_SAVE_DIR="/vagrant/.vagrant/b2d_dk_images_backup"
export HOME_DOCKER_USER="/home/docker"
export CRON_DK_IPULL_LOGFILE="/var/log/cron_dk_ipull.log"
export CRON_DK_IBACKUP_LOGFILE="/var/log/cron_dk_ibackup.log"


# -------------------------------------------------------------------
# Load of customizable parameters
# -------------------------------------------------------------------
for param_file in $BOOT2DOCKER_EXTENSION_PARAM_DIR/* ; do
    param_name=${param_file##*/}
    if [[ "${param_name}" != "README.md" ]]; then
        eval "export ${param_name}=$(cat $param_file)"
    fi
done
