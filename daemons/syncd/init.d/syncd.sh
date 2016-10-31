#!/bin/sh

# ============================================================
# B2D Sync daemon
# ============================================================

# Configuration
DAEMON_DIR="/var/lib/boot2docker/extension/daemons/syncd"
DAEMON_BIN="$DAEMON_DIR/bin/syncd.sh"
DAEMON_USER="root"
DAEMON_NAME="syncd"
DAEMON_PID_FILE="/var/run/syncd.pid"

# Test binary existence
test -x $DAEMON_BIN || exit 1

# Checks daemon
syncd_check() {
    [ -f $DAEMON_PID_FILE ] && ps -A -o pid | grep "^\s*$(cat $DAEMON_PID_FILE)$" > /dev/null 2>&1
}

# Daemon start
syncd_start () {
    if syncd_check; then
        echo "$DAEMON_NAME is already running!"
    else
        echo "Starting system $DAEMON_NAME daemon..."
        $DAEMON_BIN &
        echo "$!" > $DAEMON_PID_FILE
    fi
}

# Daemon stop
syncd_stop () {
    if syncd_check; then
        echo "Stopping system $DAEMON_NAME daemon..."
        kill $(cat $DAEMON_PID_FILE)
        rm -f $DAEMON_PID_FILE
    else
        echo "$DAEMON_NAME is already stopped!"
    fi
}

# Show daemon status
syncd_status() {
    if syncd_check; then
        echo "$DAEMON_NAME daemon is running"
        exit 0
    else
        echo "$DAEMON_NAME daemon is not running"
        exit 1
    fi
}

# Help on usage
syncd_usage(){
    echo "Usage: $DAEMON_BIN start/stop/status"
    echo
    echo "Starts or stop a small b2d sync daemon that sync every 2 seconds."
}

# Sub commands management
case "$1" in
    start) syncd_start
        ;;
    stop) syncd_stop
        ;;
    status) syncd_status
        ;;
    *) syncd_usage
        ;;
esac
exit 0
