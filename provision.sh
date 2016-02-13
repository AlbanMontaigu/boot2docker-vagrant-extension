#!/bin/sh

# ===================================================================
# Provisionning script executed during vagrant provision
# ===================================================================


# -------------------------------------------------------------------
# Parametrization (for all environment)
# -------------------------------------------------------------------
export BOOT2DOCKER_CONFIG_DIR="/var/lib/boot2docker/config"


# -------------------------------------------------------------------
# Import custom configurations in a dynamic way
#
# NOTE: prefix the files with a number to manage order
# -------------------------------------------------------------------
for provision_file in $BOOT2DOCKER_CONFIG_DIR/provision.sh.d/* ; do
    if [ -f $provision_file ]; then 
        source $provision_file
    fi
done
