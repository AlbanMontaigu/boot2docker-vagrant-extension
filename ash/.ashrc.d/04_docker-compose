
# ============================================================
# Docker compose custom commands
# ============================================================


# ------------------------------------------------------------
# Shows or changes compose app prefix
# ------------------------------------------------------------
dc_prefix(){
    if [[ "$1" == "" ]] ; then
        echo $COMPOSE_PROJECT_NAME
    else
        export COMPOSE_PROJECT_NAME="$1"
    fi
}

dc_prefix_help(){
    echo "Usage: dc prefix [NEW_PREFIX]"
    echo
    echo "Shows or changes (if NEW_PREFIX is specified) compose app prefix."
}


# ------------------------------------------------------------
# Show compose usage + information about custom commands
# ------------------------------------------------------------
dc_custom_usage(){
    echo
    echo "dc = docker-compose utilities for your boot2docker environment."
    echo
    echo "Custom dc commands:"
    echo "  prefix             Shows or changes compose app prefix"
}


# ------------------------------------------------------------
# Help complements
# ------------------------------------------------------------
dc_help(){
    case "$1" in
        prefix) dc_prefix_help
            ;;
        "") dc_custom_usage
            ;;
        *) dc_custom_usage
            ;;
    esac
}


# ------------------------------------------------------------
# Docker compose utilities
# ------------------------------------------------------------
dc(){
    case "$1" in
        prefix) dc_prefix "$2"
            ;;
        help) dc_help "$2"
            ;;
        "") dc_custom_usage
            ;;
        *) dc_custom_usage
            ;;
    esac
}
