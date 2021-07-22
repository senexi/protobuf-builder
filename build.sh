#!/bin/bash

ACTION=${1:-"build"}
REPO=${2:-"senexi"}
TARGET="protobuf-builder"
BUILDER="docker"

if ! command -v $BUILDER &> /dev/null
then
    BUILDER="podman"
fi


if [ "$ACTION" = "build" ]; then
    $BUILDER build -t $TARGET:latest -f ./Dockerfile .
else
    IMAGE=$TARGET:latest
    $BUILDER push $IMAGE $REPO/$IMAGE
fi
