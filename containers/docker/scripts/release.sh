#!/bin/bash
###################################################################################
# Used for Docker releases                                                        #
# Inspired from: https://github.com/treeder/dockers/blob/master/bump/release.sh   #
###################################################################################

set -e
set -x

source docker_script.env

# Get latest
git pull

# bump version
docker run --rm -v "$PWD":/app ${DOCKER_HUB_REPOSITORY_NAME} "$(git log -1 --pretty=%B)"
version=`cat ../VERSION` | echo "version: $version"

echo '# +x ./containers/docker/scripts/build.sh'
./build.sh

# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags

docker tag ${DOCKER_HUB_REPOSITORY_NAME}:${DOCKER_HUB_IMAGE_TAG} ${DOCKER_HUB_REPOSITORY_NAME}:$version

# push it
docker push ${DOCKER_HUB_REPOSITORY_NAME}:${DOCKER_HUB_IMAGE_TAG}
docker push ${DOCKER_HUB_REPOSITORY_NAME}:$version