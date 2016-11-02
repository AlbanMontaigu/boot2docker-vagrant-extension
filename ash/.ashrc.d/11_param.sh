
# ============================================================
# Param generated for the environment and modifiable with
# param.sh system.
# ============================================================

# Docker toolbox (persistent to modify with vagrant file mechanism if requested)
export DKTB_VERSION=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/DKTB_VERSION")
export DKTB_EXTENSION_STATUS=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/DKTB_EXTENSION_STATUS")
export DKTB_EXTENSION_REPO=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/DKTB_EXTENSION_REPO")
export DKTB_EXTENSION_VERSION=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/DKTB_EXTENSION_VERSION")

# dk_proxyd daemon status
export DK_PROXYD_STATUS=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/DK_PROXYD_STATUS")

# Compose
export COMPOSE_PROJECT_NAME=$(cat "$BOOT2DOCKER_EXTENSION_PARAM_DIR/COMPOSE_PROJECT_NAME")
