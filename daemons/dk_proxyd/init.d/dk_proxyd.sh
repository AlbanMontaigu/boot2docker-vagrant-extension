#!/bin/sh

# ============================================================
# B2D docker transparent proxy daemon
# ============================================================

# Configuration
BOOT2DOCKER_EXTENSION_DIR="/var/lib/boot2docker/extension"
DAEMON_DIR="${BOOT2DOCKER_EXTENSION_DIR}/daemons/dk_proxyd"
DAEMON_START_BIN="$DAEMON_DIR/bin/start_transparent_proxy.sh"
DAEMON_STOP_BIN="$DAEMON_DIR/bin/stop_transparent_proxy.sh"
DAEMON_USER="root"
DAEMON_NAME="dk_proxyd"
DAEMON_DK_CONTAINER="transparent-proxy"

# Test binary existence
test -x $DAEMON_START_BIN || exit 1
test -x $DAEMON_STOP_BIN || exit 1

# Checks daemon
dk_proxyd_check() {
    RUNNING=$(docker inspect --format="{{ .State.Running }}" $DAEMON_DK_CONTAINER 2> /dev/null)
    [ "$RUNNING" == "true" ]
}

# Daemon start
dk_proxyd_start () {
    if dk_proxyd_check; then
        echo "[WARN] $DAEMON_NAME is already running!"
    else
        echo "[INFO] Starting system $DAEMON_NAME daemon..."
        $DAEMON_START_BIN
    fi
}

# Daemon stop
dk_proxyd_stop () {
    if dk_proxyd_check; then
        echo "[INFO] Stopping system $DAEMON_NAME daemon..."
        $DAEMON_STOP_BIN
    else
        echo "[WARN] $DAEMON_NAME is already stopped!"
    fi
}

# Show daemon status
dk_proxyd_status() {
    if dk_proxyd_check; then
        echo "[INFO] $DAEMON_NAME daemon is running"
        exit 0
    else
        echo "[INFO] $DAEMON_NAME daemon is not running"
        exit 1
    fi
}

# Help on usage
dk_proxyd_usage(){
    echo "Usage: $DAEMON_BIN start/stop/status"
    echo
    echo "Starts or stop a small docker transparent proxy daemon."
}

# Sub commands management
case "$1" in
    start) dk_proxyd_start
        ;;
    stop) dk_proxyd_stop
        ;;
    status) dk_proxyd_status
        ;;
    *) dk_proxyd_usage
        ;;
esac
exit 0
