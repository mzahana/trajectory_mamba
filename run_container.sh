#!/bin/bash

# Variables
IMAGE_NAME="s_mamba_image"
CONTAINER_NAME="s_mamba_container"
REPO_DIR="$(pwd)/pkgs"
APP_DIR="/home/ai/app"
USER=ai

# Ensure the pkgs directory exists and set appropriate ownership
mkdir -p $REPO_DIR
sudo chown -R $(id -u):$(id -g) $REPO_DIR  # Ensure current user owns the directory

# Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest .

# Run the Docker container
echo "Running Docker container..."
docker run --gpus all -it \
    --name $CONTAINER_NAME \
    -v $REPO_DIR:$APP_DIR/pkgs \
    -v "$(pwd)/requirements.txt":$APP_DIR/requirements.txt \
    --user $USER \
    $IMAGE_NAME:latest
