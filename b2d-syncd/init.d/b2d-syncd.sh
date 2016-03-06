#!/bin/sh

# ============================================================
# B2D Sync daemon
# ============================================================

# Configuration
DAEMON_DIR="/var/lib/boot2docker/extension/b2d-syncd"
DAEMON_BIN="$DAEMON_DIR/bin/b2d-syncd.sh"
DAEMON_USER="root"
DAEMON_NAME="b2d-syncd"
DAEMON_PID_FILE="/var/run/b2d-sync.pid"

# Test binary existence
test -x $DAEMON_BIN || exit 1

# Checks daemon
b2d_syncd_check() {
    [ -f $DAEMON_PID_FILE ] && ps -A -o pid | grep "^\s*$(cat $DAEMON_PID_FILE)$" > /dev/null 2>&1
}

# Daemon start
b2d_syncd_start () {
    if b2d_syncd_check; then
        echo "$DAEMON_NAME is already running!"
    else
        echo "Starting system $DAEMON_NAME daemon..."
        $DAEMON_BIN &
        echo "$!" > $DAEMON_PID_FILE
    fi
}

# Daemon stop
b2d_syncd_stop () {
    if b2d_syncd_check; then
        echo "Stopping system $DAEMON_NAME daemon.."
        kill $(cat $DAEMON_PID_FILE)
        rm -f $DAEMON_PID_FILE
    else
        echo "$DAEMON_NAME is already stopped!"
    fi
}

# Show daemon status
b2d_syncd_status() {
    if b2d_syncd_check; then
        echo "$DAEMON_NAME daemon is running"
        exit 0
    else
        echo "$DAEMON_NAME daemon is not running"
        exit 1
    fi
}

# Help on usage
b2d_syncd_usage(){
    echo "Usage: $DAEMON_BIN start/stop/status"
    echo
    echo "Starts or stop a small b2d sync daemon that sync every 2 seconds."
}

# Sub commands management
case "$1" in
    start) b2d_syncd_start
        ;;
    stop) b2d_syncd_stop
        ;;
    status) b2d_syncd_status
        ;;
    *) b2d_syncd_usage
        ;;
esac
exit 0
