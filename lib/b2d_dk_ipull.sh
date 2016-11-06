
# ------------------------------------------------------------
# Docker images re pull
# ------------------------------------------------------------

# Configuration and preparation
echo "[INFO] Will pull again all your images to take eventual updates !"
echo "[INFO][$(date +"%T")] Starting pull"

# Iterate each docker image
for b2d_dk_image in $(docker images --format "{{.Repository}}:{{.Tag}}") ; do

    # Do not operate <none> tags
    if echo $b2d_dk_image | grep -q "<none>"  ; then
        echo "[INFO][$(date +"%T")] Skipping ${b2d_dk_image}"
    else
        # All right go pull image
       echo "[INFO][$(date +"%T")] Pulling ${b2d_dk_image}"
       docker pull "${b2d_dk_image}"
    fi
done

# Done !
echo "[INFO][$(date +"%T")] Pull completed !"
