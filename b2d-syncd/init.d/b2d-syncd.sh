#!/bin/sh

# ============================================================
# B2D Sync daemon
# ============================================================

# Configuration
DAEMON_DIR="/var/lib/boot2docker/config/b2d_syncd"
DAEMON_BIN="$DAEMON_DIR/bin/b2d_syncd.sh"
DAEMON_USER="root"
DAEMON_NAME="b2d-syncd"

# Test binary existence
test -x $DAEMON_BIN || exit 0

# Daemon start
b2d_syncd_start () {
    echo "Starting system $DAEMON_NAME daemon"
    start-stop-daemon --background --name $DAEMON_NAME --start --quiet --chuid $DAEMON_USER --startas $DAEMON_BIN
}

# Daemon stop
b2d_syncd_stop () {
    echo "Stopping system $DAEMON_NAME daemon"
    start-stop-daemon --name $DAEMON_NAME --stop --retry 5 --quiet --name $DAEMON_NAME
}

# Help on usage
b2d_syncd_usage(){
    echo "Usage: $DAEMON_BIN start/stop"
    echo
    echo "Starts or stop a small b2d sync daemon that sync every 2 seconds."
}

# Sub commands management
case "$1" in
    start) b2d_syncd_start
        ;;
    stop) b2d_syncd_stop
        ;;
    *) b2d_syncd_usage
        ;;
esac
exit 0
