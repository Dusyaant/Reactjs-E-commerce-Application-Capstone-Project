#!/bin/bash

# 1. Gather git branch and commit hash for tagging
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
COMMIT_SHA=$(git rev-parse --short HEAD)
DOCKER_USER="prospendeo" # <-- UPDATE THIS!

# 2. Determine target repository based on branch
if [ "$BRANCH_NAME" == "master" ] || [ "$BRANCH_NAME" == "main" ]; then
    REPO_NAME="devops-app-prod"
else
    REPO_NAME="devops-app-dev"
fi

IMAGE_NAME="$DOCKER_USER/$REPO_NAME"

# 3. Build and Tag the image
echo "Building image $IMAGE_NAME:$COMMIT_SHA..."
docker build -t $IMAGE_NAME:$COMMIT_SHA .

# Tag it as latest for easy reference
docker tag $IMAGE_NAME:$COMMIT_SHA $IMAGE_NAME:latest

echo "Build complete."