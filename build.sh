#!/bin/bash
set -e

# 1. Gather git branch and commit hash for tagging
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
COMMIT_SHA=$(git rev-parse --short HEAD)
DOCKER_USER="dusyaant"

# 2. Determine target repository based on branch
if [ "$BRANCH_NAME" = "master" ] || [ "$BRANCH_NAME" = "main" ]; then
    REPO_NAME="prod"
else
    REPO_NAME="dev"
fi

IMAGE_NAME="$DOCKER_USER/$REPO_NAME"

# 3. Build and tag the image
echo "Building image $IMAGE_NAME:$COMMIT_SHA..."
docker build -t $IMAGE_NAME:$COMMIT_SHA .
docker tag $IMAGE_NAME:$COMMIT_SHA $IMAGE_NAME:latest

# 4. Push to Docker Hub
echo "Pushing image to Docker Hub..."
docker push $IMAGE_NAME:$COMMIT_SHA
docker push $IMAGE_NAME:latest

echo "Build and push complete."
