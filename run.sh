#!/bin/bash

VERSION=18.0.3.450  # Specify the version of the 3CX image
USER=bbh02  # Your Docker username
HOSTNAME=pbx.yourdomain.com  # Set the hostname for the container
REPO=${USER}/3cx:${VERSION}  # Define the Docker image repository

docker run \
        -d \
        --name 3cx \
        --hostname ${HOSTNAME} \
        --memory 2g \                   # Limit container memory to 2GB
        --memory-swap 2g \              # Limit swap space to 2GB
        --network host \                # Use host network mode
        --restart unless-stopped \      # Restart the container unless explicitly stopped
        -v /sys/fs/cgroup:/sys/fs/cgroup:ro \  # Mount cgroup for proper systemd integration
        -v 3cx_backup:/srv/backup \     # Mount a volume for backup data
        -v 3cx_recordings:/srv/recordings \  # Mount a volume for recordings
        -v 3cx_log:/var/log \           # Mount a volume for log files
        --cap-add SYS_ADMIN \           # Add SYS_ADMIN capability
        --cap-add NET_ADMIN \           # Add NET_ADMIN capability
        ${REPO}  # Specify the Docker image to use and run the container
