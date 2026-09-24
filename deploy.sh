#!/bin/bash
set -e

echo "Tearing down old environment..."
docker-compose down || true

echo "Spinning up new container..."
docker-compose up -d

echo "Deployment complete!"
