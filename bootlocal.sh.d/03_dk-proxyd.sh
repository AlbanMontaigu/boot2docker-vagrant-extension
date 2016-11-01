
# ===================================================================
# dk-proxyd daemon lunching
# ===================================================================

# Get daemon status param
export DK_PROXYD_STATUS=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/DK_PROXYD_STATUS")

# Check if the daemon is enabled
if [[ "$DK_PROXYD_STATUS" == "ON" ]]; then
    echo "== Starting dk-proxyd daemon !"
    $BOOT2DOCKER_EXTENSION_DIR/daemons/dk-proxyd/init.d/dk-proxyd.sh start
else
    echo "== dk-proxyd daemon not started !"
fi
