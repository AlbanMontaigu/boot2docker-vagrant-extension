#!/bin/sh

# Error handling
set -e

# Stop and delete existing container
echo "[INFO] Deleting existing transparent proxy container..."
docker rm -f transparent-proxy 2>/dev/null || true

echo "[INFO] Restoring network rules..."
/usr/local/sbin/iptables-save | grep -v TRANSPROXY | /usr/local/sbin/iptables-restore

# End of error handling
set +e
