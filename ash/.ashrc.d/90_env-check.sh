
# =====================================================
# Various check regarding environment
#
# NOTE: need to occur lately in the bootstrap process
# =====================================================


# ------------------------------------------------------------
# Display information regarding versions
# ------------------------------------------------------------
version_check(){

# To gain visibility for the message
cat << EOF
 __     __            _                ____ _               _
 \ \   / /__ _ __ ___(_) ___  _ __    / ___| |__   ___  ___| | __
  \ \ / / _ \ '__/ __| |/ _ \| '_ \  | |   | '_ \ / _ \/ __| |/ /
   \ V /  __/ |  \__ \ | (_) | | | | | |___| | | |  __/ (__|   <
    \_/ \___|_|  |___/_|\___/|_| |_|  \____|_| |_|\___|\___|_|\_\

EOF

    # Get remote version (latest)
    B2D_EXT_LATEST_VERSION=$(curl -m15 -skL https://raw.githubusercontent.com/AlbanMontaigu/boot2docker-vagrant-extension/latest/VERSION)

    # Error management
    if [ $? != 0 ]; then
        return 1
    fi

    # Display information
    if ([[ "${B2D_EXT_LATEST_VERSION}" == "${B2D_EXTENSION_VERSION}" ]]); then
        echo -e "[INFO] Congratulations ! You have the last version of boot2docker extension (${B2D_EXTENSION_VERSION})\n\n"
        return 0
    else
        echo -e "[INFO] You may consider checking your boot2docker extension version (yours=${B2D_EXTENSION_VERSION}, latest=${B2D_EXT_LATEST_VERSION})\n\n"
        return 2
    fi
}

# Do the check but not blocking and only once
if [ -z "${B2D_VERSION_CHECK}" ]; then
    version_check
    export B2D_VERSION_CHECK=1
fi
