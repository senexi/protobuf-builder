#!/bin/bash
REPO=${1:-"senexi"}

TARGET="go-protobuf-builder"
BUILDER="docker"

if ! command -v $BUILDER &> /dev/null
then
    BUILDER="podman"
fi
IMAGE=$TARGET:latest

$BUILDER push $IMAGE $REPO/$IMAGE
