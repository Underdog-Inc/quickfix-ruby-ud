#!/bin/bash

set -e

IMAGE_NAME="quickfix_ruby_ud"
CONTAINER_NAME="quickfix_ruby_ud"
FOLDER_PATH="/build/pkg"
DESTINATION_FOLDER="./output"

# Step 1: Build Docker image
echo "Building Docker image..."
docker build -t "$IMAGE_NAME" . --no-cache

# Step 2: Create and start container
echo "Creating container..."
docker create --name "$CONTAINER_NAME" "$IMAGE_NAME"

# Step 3: Copy file from container to host
echo "Copying file from container to host..."
docker cp "$CONTAINER_NAME:FOLDER_PATH" "DESTINATION_FOLDER"

# Step 4: Cleanup
echo "Cleaning up..."
#docker rm "$CONTAINER_NAME"
#docker rmi "$IMAGE_NAME"

echo "Done! File copied to DESTINATION_FOLDER"