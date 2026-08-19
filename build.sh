#!/bin/bash
set -e

# Login to Docker Hub
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Stop and remove old container if it exists
docker stop react || true
docker rm react || true

# Build Docker image
docker build -t react-ci/cd .

# Run container
docker run -d --name react -p 80:80 react-ci/cd

# Tag image
docker tag react-ci/cd pavipalsamy7/react-app:ci-cd

# Push image
docker push pavipalsamy7/react-app:ci-cd
