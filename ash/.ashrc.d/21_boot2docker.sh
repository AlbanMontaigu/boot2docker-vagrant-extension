#@IgnoreInspection BashAddShebang

# ============================================================
# Boot2docker custom commands
# ============================================================


# ------------------------------------------------------------
# Fix cache issue in boot2docker with vb guest additions
# @see https://forums.virtualbox.org/viewtopic.php?f=3&t=33201
# @see https://www.virtualbox.org/ticket/12597
# @see https://www.virtualbox.org/ticket/9069
# ------------------------------------------------------------
b2d_sync(){
    sudo sh -c "sync && echo 3 > /proc/sys/vm/drop_caches"
}

# Sync command help
b2d_sync_help(){
    echo "Usage: b2d sync"
    echo
    echo "In case of virtualbox guest additions sync bug, force synchronization beetween host and boot2docker"
}


# ------------------------------------------------------------
# syncd daemon management
# ------------------------------------------------------------

# syncd daemon wrapper in a b2d subcommand
b2d_syncd(){
    sudo $BOOT2DOCKER_EXTENSION_DIR/daemons/syncd/init.d/b2d-syncd.sh "$1"
}

# Syncd command help
b2d_syncd_help(){
    echo "Usage: b2d syncd start/stop/status"
    echo
    echo "Similar to b2d sync but in a daemon way that lunches regulary the command"
}

# ------------------------------------------------------------
# Proxy helper commands
# ------------------------------------------------------------

# Extract host from boot2docker http_proxy env var
b2d_proxy_host(){
  echo "$http_proxy" | sed 's|^.\+://\(.\+\):[0-9]\+$|\1|g'
}

# Extract port from boot2docker http_proxy env var
b2d_proxy_port(){
  echo "$http_proxy" | sed 's|^.\+://.\+:\([0-9]\+\)$|\1|g'
}

# Change proxy with a specific profile stored in :
b2d_proxy_change(){
    
    if [[ "$1" == "" ]]; then
        echo "[ERROR] Please specify the proxy profile you want to set"
        return 1
    fi
    
    proxy_profile_file="$BOOT2DOCKER_EXTENSION_DIR/proxy/$1"
    if [ -f "$proxy_profile_file" ]; then
        source $proxy_profile_file
        echo "[INFO] Proxy change done with $1"
    else
        echo "[ERROR] Proxy profile file not found for $1"
    fi
}

# Restory proxy configuration with initial values comming from /etc/env
b2d_proxy_restore(){
    source /etc/environment
    echo "[INFO] Proxy vars restored from /etc/environment"
}

# Proxy command switch
b2d_proxy(){
    case "$1" in
        host) b2d_proxy_host
            ;;
        port) b2d_proxy_port
            ;;
        change) b2d_proxy_change "$2"
            ;;
        restore) b2d_proxy_restore
            ;;
        *) b2d_proxy_help
            ;;
    esac
}

# Proxy command help
b2d_proxy_help(){
    echo
    echo "b2d proxy = commands helper to manage proxy concerns boot2docker environment."
    echo
    echo "b2d proxy commands:"
    echo "    host      Get host part in http_proxy env variable"
    echo "    port      Get port part in http_proxy env variable"
    echo "    change    Changes current proxy env vars with specific profile specified"
    echo "    restore   Restore proxy env vars with /etc/environment"
}


# ------------------------------------------------------------
# Transparent proxy for the containers
# ------------------------------------------------------------

# dk-proxyd daemon wrapper in a b2d subcommand
b2d_dk_proxyd(){
    sudo $BOOT2DOCKER_EXTENSION_DIR/daemons/dk-proxyd/init.d/dk-proxyd.sh "$1"
}

# dk proxyd command help
b2d_dk_proxyd_help(){
    echo "Usage: b2d dk proxyd start/stop/status"
    echo
    echo "Start or stop transparent proxy in a container for your containers"
}


# ------------------------------------------------------------
# Docker images backup
# @ see https://stackoverflow.com/questions/26707542/how-to-backup-restore-docker-image-for-deployment
# ------------------------------------------------------------

# Backup creation for boot2docker images
b2d_dk_ibackup(){

    # Configuration and preparation
    set -e
    echo "[INFO] Will save all your local b2d docker images to ${BOOT2DOCKER_DK_IMAGES_SAVE_DIR} !"
    rm -rvf "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}"
    mkdir -p "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}"
    echo "[INFO] [$(date +"%T")] Starting save"

    # Iterate each docker image
    for b2d_dk_image in $(docker images --format "{{.Repository}}:{{.Tag}}") ; do
        # Path without ':' char (replaced by '_')
        path_b2d_dk_image_saved="${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}/$(echo ${b2d_dk_image} | sed 's#[/:]#_#g').tgz"
        echo "[INFO] [$(date +"%T")] Now saving ${b2d_dk_image} to ${path_b2d_dk_image_saved}"
        docker save "${b2d_dk_image}" | gzip -c > "${path_b2d_dk_image_saved}"
    done

    # Done !
    echo "[INFO] [$(date +"%T")] Save completed !"
    set +e
}

# Backup restoration for boot2docker images
b2d_dk_irestore(){

    # Configuration and preparation
    set -e
    echo "[INFO] Will restore all your b2d docker images from ${BOOT2DOCKER_DK_IMAGES_SAVE_DIR} !"
    echo "[INFO] [$(date +"%T")] Starting restore"

    # For each saved image
    for b2d_dk_image_saved in $BOOT2DOCKER_DK_IMAGES_SAVE_DIR/*.tgz ; do
        echo "[INFO] [$(date +"%T")] Now restoring ${b2d_dk_image_saved}"
        gunzip -c "${b2d_dk_image_saved}" | docker load
    done

    # Done !
    echo "[INFO] [$(date +"%T")] Restore completed completed !"
    echo "[INFO] [$(date +"%T")] Removing images backups !"
    rm -rvf "${BOOT2DOCKER_DK_IMAGES_SAVE_DIR}"
    set +e
}


# ------------------------------------------------------------
# Docker all images remove
# ------------------------------------------------------------

b2d_dk_iremove(){

    # Done !
    echo "[INFO] [$(date +"%T")] Will remove all your images !"

    # Iterate each docker image
    for b2d_dk_image in $(docker images --format "{{.Repository}}:{{.Tag}}") ; do
        echo "[INFO] [$(date +"%T")] Now removing ${b2d_dk_image}"
        docker rmi "${b2d_dk_image}"
    done

    # Done !
    echo "[INFO] [$(date +"%T")] Remove completed !"
}


# ------------------------------------------------------------
# Boot2docker dk subcommand
# ------------------------------------------------------------
b2d_dk(){
    case "$1" in
        ibackup) b2d_dk_ibackup
            ;;
        irestore) b2d_dk_irestore
            ;;
        iremove) b2d_dk_iremove
            ;;
        proxyd) b2d_dk_proxyd "$2"
            ;;
        *) b2d_dk_custom_usage
            ;;
    esac
}

# Command usage
b2d_dk_custom_usage(){
    echo
    echo "b2d dk = commands to manage your docker daemon in your boot2docker environment."
    echo
    echo "b2d dk commands:"
    echo "    ibackup     Backup all your b2d docker images to a folder in your project"
    echo "    irestore    Restore all your b2d docker images from a folder in your project"
    echo "    iremove     Remove all your b2d docker images (dk rmi on all dk images)"
    echo "    proxyd      Start or stop transparent proxy in a container for your containers"
    echo "    proxyd      Start or stop transparent proxy in a container for your containers"
}


# ------------------------------------------------------------
# Show boot2docker usage + information about custom commands
# ------------------------------------------------------------
b2d_custom_usage(){
    echo
    echo "b2d = commands to manage your boot2docker environment."
    echo
    echo "b2d commands:"
    echo "    sync      In case of virtualbox guest additions sync bug, force synchronization beetween host and boot2docker"
    echo "    syncd     Similar to b2d sync but in a daemon way that lunches regulary the command"
    echo "    dk        Commands to manage your docker daemon in your boot2docker environment"
    echo "    proxy     Helper commands for proxy management"
    echo "    help      Give help including a subcommand"
}


# ------------------------------------------------------------
# Help complements
# ------------------------------------------------------------
b2d_help(){
    case "$1" in
        sync) b2d_sync_help
            ;;
        syncd) b2d_syncd_help
            ;;
        proxy) b2d_proxy_help
            ;;
        dk) b2d_dk_custom_usage
            ;;
        *) b2d_custom_usage
            ;;
    esac
}


# ------------------------------------------------------------
# Docker command plus new features for it
# ------------------------------------------------------------
b2d(){
    case "$1" in
        sync) b2d_sync
            ;;
        syncd) b2d_syncd "$2"
            ;;
        dk) b2d_dk "$2" "$3"
            ;;
        proxy) b2d_proxy "$2" "$3"
            ;;
        help) b2d_help "$2"
            ;;
        *) b2d_custom_usage
            ;;
    esac
}
