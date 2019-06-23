#!/bin/bash
set -e

echo "#################################################"
echo "Starting the Hugo Action"

git submodule init
git submodule update
sh -c "GIT_COMMIT_SHA=`git rev-parse --verify HEAD` GIT_COMMIT_SHA_SHORT=`git rev-parse --short HEAD` hugo $*"

echo "#################################################"
echo "Completed the Hugo Action"
