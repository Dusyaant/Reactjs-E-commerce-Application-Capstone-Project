#!/bin/bash
set -e

# Gather commit hash for tagging
COMMIT_SHA=$(git rev-parse --short HEAD)
IMAGE_NAME="dusyaant/dev"

echo "Building image $IMAGE_NAME:$COMMIT_SHA..."
docker build -t $IMAGE_NAME:$COMMIT_SHA .
docker tag $IMAGE_NAME:$COMMIT_SHA $IMAGE_NAME:latest

echo "Pushing image to Docker Hub..."
docker push $IMAGE_NAME:$COMMIT_SHA
docker push $IMAGE_NAME:latest

echo "Build and push complete."
