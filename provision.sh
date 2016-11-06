#!/bin/sh

# ===================================================================
# Provisioning script executed during vagrant provision
# ===================================================================


# ------------------------------------------------------------
# Environment definition (params and so on)
# ------------------------------------------------------------
source /var/lib/boot2docker/extension/environment.sh


# -------------------------------------------------------------------
# Import custom elements in a dynamic way
#
# NOTE: prefix the files with a number to manage order
# -------------------------------------------------------------------
for provision_file in $BOOT2DOCKER_EXTENSION_DIR/provision.sh.d/* ; do
    echo "[INFO] Running ${provision_file}"
    if [ -f $provision_file ]; then 
        source $provision_file
    fi
done
