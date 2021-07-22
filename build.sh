#!/bin/bash

ARCH=${1:-"amd64"}
PB_ARCH=${2:-"linux-x86_64"}
TARGET="protobuf-builder"
BUILDER="docker"

if ! command -v $BUILDER &> /dev/null
then
    BUILDER="podman"
fi


$BUILDER build --build-arg ARCH=$ARCH --build-arg PB_ARCH=$ARCH2 -t $TARGET:$ARCH-latest -f ./Dockerfile .
