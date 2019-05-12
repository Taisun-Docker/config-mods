#! /bin/bash

# Login to Dockerhub
echo $DOCKERPASS | docker login -u $DOCKERUSER --password-stdin

# Loop through and build/push all mods regardless of changes
for MODNAME in */; do
  MODNAME="${MODNAME%/}"
  cd ${MODNAME}
  docker build --no-cache --pull -t ${DOCKERHUB_LIVE}:${TRAVIS_COMMIT}-${MODNAME} .
  docker tag ${DOCKERHUB_LIVE}:${TRAVIS_COMMIT}-${MODNAME} ${DOCKERHUB_LIVE}:${MODNAME}
  docker push ${DOCKERHUB_LIVE}:${TRAVIS_COMMIT}-${MODNAME}
  docker push ${DOCKERHUB_LIVE}:${MODNAME}
  cd ..
done
