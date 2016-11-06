#!/bin/sh

# ===================================================================
# Bootlocal script executed during each vagrant up
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
for bootlocal_file in $BOOT2DOCKER_EXTENSION_DIR/bootlocal.sh.d/* ; do
    echo "[INFO] Running ${bootlocal_file}"
    if [ -f $bootlocal_file ]; then 
        source $bootlocal_file
    fi
done
