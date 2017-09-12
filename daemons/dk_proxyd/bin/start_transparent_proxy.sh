#!/bin/sh

# Error handling
set -e

# Stop and delete existing container
echo "[INFO] Deleting existing transparent proxy container and network rules ..."
docker rm -f transparent-proxy 2>/dev/null || true

# First we added a new chain called 'TRANSPROXY' to the 'nat' table.
echo "[INFO] Set networking rules ..."
/usr/local/sbin/iptables -t nat -N TRANSPROXY 2>/dev/null || true

# We then told iptables to redirect all port 80 connections to the http-relay port
/usr/local/sbin/iptables -t nat -C TRANSPROXY -p tcp --dport 80 -j REDIRECT --to-ports 3128 -w 2>/dev/null || \
/usr/local/sbin/iptables -t nat -A TRANSPROXY -p tcp --dport 80 -j REDIRECT --to-ports 3128 -w

# and all other connections to the http-connect port.
/usr/local/sbin/iptables -t nat -C TRANSPROXY -p tcp -j REDIRECT --to-ports 12345 -w 2>/dev/null || \
/usr/local/sbin/iptables -t nat -A TRANSPROXY -p tcp -j REDIRECT --to-ports 12345 -w

# Finally we tell iptables to use the ‘TRANSPROXY’ chain for all outgoing connection in docker containers
/usr/local/sbin/iptables -t nat -C PREROUTING -p tcp -j TRANSPROXY -m addrtype --dst-type UNICAST ! --dst 172.0.0.0/8 2>/dev/null || \
/usr/local/sbin/iptables -t nat -A PREROUTING -p tcp -j TRANSPROXY -m addrtype --dst-type UNICAST ! --dst 172.0.0.0/8

# Try to auto detect region profile by checking proxy value
PROXY_FILE=$(grep -l -m 1 $BOOT2DOCKER_EXTENSION_DIR/proxy/* -e "${http_proxy:-_NA_}" | head -1)
PROXY_PREFIX=$(basename "${PROXY_FILE}" | cut -d '_' -f1)

# Now starting transparent proxy service in a container
echo "[INFO] Launching transparent proxy service ..."

# In order of priority, specific conf may come either from user proxy pac in project, proxy pac in
# b2d extension or specific URL
USER_PROXY_PAC="/vagrant/boot2docker/proxy/${PROXY_PREFIX}_proxy.pac"
CUSTOM_PROXY_PAC="${BOOT2DOCKER_EXTENSION_DIR}/proxy/${PROXY_PREFIX}_proxy.pac"
CUSTOM_PROXY_PAC_URL_FILE="${CUSTOM_PROXY_PAC}.url"

# Testing cases
if [ -f "${USER_PROXY_PAC}" ]; then
    # run transparent with user config
    echo "[INFO] Use your ${USER_PROXY_PAC}"
    docker run --name=transparent-proxy --net=host -v $USER_PROXY_PAC:/mnt/proxy.pac -d amontaigu/transparent-proxy:latest file:///mnt/proxy.pac
elif [ -f "${CUSTOM_PROXY_PAC}" ]; then
    # run transparent with custom config
    echo "[INFO] Use your ${CUSTOM_PROXY_PAC}"
    docker run --name=transparent-proxy --net=host -v $CUSTOM_PROXY_PAC:/mnt/proxy.pac -d amontaigu/transparent-proxy:latest file:///mnt/proxy.pac
elif [ -f "${CUSTOM_PROXY_PAC_URL}" ]; then
    echo "[INFO] Use your ${CUSTOM_PROXY_PAC_URL_FILE}"
    CUSTOM_PROXY_PAC_URL="$(cat $CUSTOM_PROXY_PAC_URL_FILE)"
    docker run --name=transparent-proxy --net=host -d amontaigu/transparent-proxy:latest "${CUSTOM_PROXY_PAC_URL}"
else
    # run transparent proxy using wpad
    echo "[INFO] Use proxy set in default auto detected proxy pac"
    docker run --name=transparent-proxy --net=host -d amontaigu/transparent-proxy:latest http://wpad/wpad.dat
fi
echo "[INFO] OK, transparent proxy is started"

# End of error handling
set +e
