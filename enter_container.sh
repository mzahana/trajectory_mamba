#!/bin/bash

# Variables
CONTAINER_NAME="s_mamba_container"

# Check if container is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Entering the running container..."
    docker exec -it $CONTAINER_NAME /bin/bash
else
    echo "Container '$CONTAINER_NAME' is not running. Starting the container..."
    docker start -ai $CONTAINER_NAME
fi
