
# ===================================================================
# Ash custom configuration
# ===================================================================


# -------------------------------------------------------------------
# ADD complements in .ashrc for docker user
# -------------------------------------------------------------------

# Backup original .ashrc and restores it when needed
echo "== Adding complements to $HOME_DOCKER_USER/.ashrc !"
HOME_DOCKER_USER_ASRC="$HOME_DOCKER_USER/.ashrc"
if [ -f $HOME_DOCKER_USER_ASRC.original ] ; then
    cp -f $HOME_DOCKER_USER_ASRC.original $HOME_DOCKER_USER_ASRC
else
    cp -f $HOME_DOCKER_USER_ASRC $HOME_DOCKER_USER_ASRC.original 
fi

# Customize .ashrc
cat $BOOT2DOCKER_EXTENSION_DIR/ash/.ashrc >> $HOME_DOCKER_USER_ASRC
echo "== Complements added to $HOME_DOCKER_USER/.ashrc !"
