#!/bin/bash

# Variables
IMAGE_NAME="s_mamba_image_wsl2"
CONTAINER_NAME="s_mamba_container_wsl2"
REPO_DIR="$(pwd)/pkgs"
APP_DIR="/home/ai/app"
USER=ai
DOCKERFILE="Dockerfile.wsl2"

# Function to check if the container is already running
is_container_running() {
    docker ps -q -f name=$CONTAINER_NAME
}

# Function to check if the container exists (even if it's not running)
is_container_existing() {
    docker ps -a -q -f name=$CONTAINER_NAME
}

# Function to remove the existing container (if any)
remove_container() {
    echo "Removing existing container..."
    docker rm -f $CONTAINER_NAME
}

# Function to enter the running container
enter_container() {
    echo "Entering the running Docker container..."
    docker exec -it $CONTAINER_NAME /bin/bash
}

# Function to run the container (build if necessary)
run_container() {
    echo "Building Docker image from $DOCKERFILE..."
    docker build -f $DOCKERFILE -t $IMAGE_NAME:latest .

    echo "Running Docker container with GPU support..."
    docker run --gpus all -it \
        --name $CONTAINER_NAME \
        -v $REPO_DIR:$APP_DIR/pkgs \
        -v "$(pwd)/requirements.txt":$APP_DIR/requirements.txt \
        --user $USER \
        $IMAGE_NAME:latest
}

# Main script logic

# If the container is already running, enter it
if [ "$(is_container_running)" ]; then
    enter_container
# If the container exists but is not running, remove it and run a new one
elif [ "$(is_container_existing)" ]; then
    remove_container
    run_container
# If the container doesn't exist, run a new one
else
    run_container
fi
