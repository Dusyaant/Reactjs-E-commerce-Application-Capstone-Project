#!/bin/bash

echo "Tearing down old environment..."
# The || true ensures the script doesn't fail if no container is currently running
docker-compose down || true

echo "Spinning up new container..."
# -d runs it in detached mode (in the background)
docker-compose up -d

echo "Deployment complete! Application is running on Port 80."