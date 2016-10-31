#!/bin/sh

# ============================================================
# B2D docker transparent proxy daemon
# ============================================================

# Configuration
DAEMON_DIR="/var/lib/boot2docker/extension/b2d-dk-proxyd"
DAEMON_START_BIN="$DAEMON_DIR/bin/start_transparent_proxy.sh"
DAEMON_STOP_BIN="$DAEMON_DIR/bin/stop_transparent_proxy.sh"
DAEMON_USER="root"
DAEMON_NAME="b2d-dk-proxyd"
DAEMON_PID_FILE="/var/run/2d-dk-proxyd.pid"

# Test binary existence
test -x $DAEMON_START_BIN || exit 1
test -x $DAEMON_STOP_BIN || exit 1

# Checks daemon
b2d_dk_proxyd_check() {
    [ -f $DAEMON_PID_FILE ] && ps -A -o pid | grep "^\s*$(cat $DAEMON_PID_FILE)$" > /dev/null 2>&1
}

# Daemon start
b2d_dk_proxyd_start () {
    if b2d_dk_proxyd_check; then
        echo "$DAEMON_NAME is already running!"
    else
        echo "Starting system $DAEMON_NAME daemon..."
        $DAEMON_START_BIN
        echo "$!" > $DAEMON_PID_FILE
    fi
}

# Daemon stop
b2d_dk_proxyd_stop () {
    if b2d_dk_proxyd_check; then
        echo "Stopping system $DAEMON_NAME daemon..."
        $DAEMON_STOP_BIN
        rm -f $DAEMON_PID_FILE
    else
        echo "$DAEMON_NAME is already stopped!"
    fi
}

# Show daemon status
b2d_dk_proxyd_status() {
    if b2d_dk_proxyd_check; then
        echo "$DAEMON_NAME daemon is running"
        exit 0
    else
        echo "$DAEMON_NAME daemon is not running"
        exit 1
    fi
}

# Help on usage
b2d_dk_proxyd_usage(){
    echo "Usage: $DAEMON_BIN start/stop/status"
    echo
    echo "Starts or stop a small b2d docker transparent proxy daemon."
}

# Sub commands management
case "$1" in
    start) b2d_dk_proxyd_start
        ;;
    stop) b2d_dk_proxyd_stop
        ;;
    status) b2d_dk_proxyd_status
        ;;
    *) b2d_dk_proxyd_usage
        ;;
esac
exit 0
