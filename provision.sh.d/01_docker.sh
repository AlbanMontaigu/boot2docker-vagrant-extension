
# ===================================================================
# Docker custom configuration
# ===================================================================

# -------------------------------------------------------------------
# No TLS mode by default since it may cause issue for communications
# between windows and boot2docker with docker client on windows
# without additional configuration for TLS.
# -------------------------------------------------------------------
if grep -q DOCKER_TLS /var/lib/boot2docker/profile; then
    echo "[INFO] Nothing todo in boot2docker/profile for DOCKER_TLS !"
else
    echo 'export DOCKER_TLS=no' >> /var/lib/boot2docker/profile
    echo "[INFO] Boot2docker/profile updated with DOCKER_TLS=no !"
fi

# -------------------------------------------------------------------
# Solves insecure registry (example)
# -------------------------------------------------------------------
#if grep -q my.inscure.registry.url /var/lib/boot2docker/profile; then
#    echo "[INFO] Nothing todo in boot2docker/profile !"
#else
#    echo 'EXTRA_ARGS="--insecure-registry my.insecure.registry.url"' >> /var/lib/boot2docker/profile
#    echo "[INFO] Boot2docker/profile updated with registry !"
#fi


# -------------------------------------------------------------------
# Docker profile customization (example)
# -------------------------------------------------------------------
#if grep -q my_option /var/lib/boot2docker/profile; then
#    echo "[INFO] Nothing todo in boot2docker/profile for my_key_command !"
#else
#    echo -e '\nDOCKER_OPTS=my_option\n' >> /var/lib/boot2docker/profile
#    echo "[INFO] Boot2docker/profile updated with my_option !"
#fi
