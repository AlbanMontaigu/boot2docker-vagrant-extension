
# ===================================================================
# Docker custom configuration
# ===================================================================


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
