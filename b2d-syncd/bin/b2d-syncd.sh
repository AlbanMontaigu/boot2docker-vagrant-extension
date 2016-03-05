#!/bin/sh

# ============================================================
# B2D Sync binary for daemon
# ============================================================

# End of process management
trap "exit 0" INT QUIT TERM

# ------------------------------------------------------------
# Fix cache issue in boot2docker with vb guest additions
# @see https://forums.virtualbox.org/viewtopic.php?f=3&t=33201
# @see https://www.virtualbox.org/ticket/12597
# @see https://www.virtualbox.org/ticket/9069
# ------------------------------------------------------------
while true
do
    sleep 2
    sync 
    echo 3 > /proc/sys/vm/drop_caches
done
