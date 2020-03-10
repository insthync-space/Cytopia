#!/bin/sh

set -eu

#if [ "${TRAVIS_PULL_REQUEST}" = "false" ] && [ "${TRAVIS_BRANCH}" = "master" ]
#then
  if [ "${TRAVIS_OS_NAME}" = "linux" ]
  then
    # Get butler
    wget https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default -O butler.zip
    7z x butler.zip
    sudo chmod a+x ./butler
  
    # Setup redist folder and push it to itch
    ninja install
    ./butler push redist cytopia/cytopia:linux-ci --userversion 0.2-CIBuild-${TRAVIS_JOB_NUMBER}
  elif [ "${TRAVIS_OS_NAME}" = "osx" ]
  then
    # Get butler
    curl -JOL https://broth.itch.ovh/butler/darwin-amd64/LATEST/archive/default
    mkdir redist
    mv bin/Cytopia.app/ redist/
    unzip butler-darwin-amd64.zip
    ./butler push redist cytopia/cytopia:macos-ci --userversion 0.2-CIBuild-${TRAVIS_JOB_NUMBER}
  fi
#fi
