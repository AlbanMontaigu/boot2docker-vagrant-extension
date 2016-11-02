
# ===================================================================
# dk_proxyd daemon lunching
# ===================================================================

# Get daemon status param
export DK_PROXYD_STATUS=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/DK_PROXYD_STATUS")

# Check if the daemon is enabled
if [[ "$DK_PROXYD_STATUS" == "ON" ]]; then
    echo "[INFO] Starting dk_proxyd daemon !"
    $BOOT2DOCKER_EXTENSION_DIR/daemons/dk_proxyd/init.d/dk_proxyd.sh start
else
    echo "[INFO] dk_proxyd daemon not started !"
fi
