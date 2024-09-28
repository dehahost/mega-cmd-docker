#!/bin/bash

IMG_NAME="dehahost/megacmd"
IMG_VERSION="1.6.3"
IMG_ARCHS=(
    "linux/amd64"
    "linux/arm64/v8"
)

###

set -e
unset arg_push arg_nocache arg_gitlab

if [[ $1 == "--push" ]]; then
    arg_push="--push"; shift
fi

if [[ $1 == "--no-cache" ]]; then
    arg_nocache="--no-cache"; shift
fi

# - Build for each platform

docker buildx build \
    ${arg_push} ${arg_nocache} \
    --platform="$(echo "${IMG_ARCHS[@]}" | tr ' ' ',')" \
    -t "${IMG_NAME}:latest" \
    -t "${IMG_NAME}:${IMG_VERSION}" \
.
