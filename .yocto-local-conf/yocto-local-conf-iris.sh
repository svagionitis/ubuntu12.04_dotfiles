#!/bin/sh


export BB_NUMBER_THREADS="32"
export PARALLEL_MAKE="-j 32"

#export EXTRA_IMAGE_FEATURES="dbg-pkgs dev-pkgs tools-debug tools-profile tools-testapps debug-tweaks"

export DL_DIR="/media/part1/YoctoDownloadCommonArea/iris/downloads"
export SSTATE_DIR="/media/part1/YoctoDownloadCommonArea/iris/sstate-cache"
export IRIS_VERSION="0.0.0"
export DEPLOY_DIR_IMAGE="/media/part1/YoctoDownloadCommonArea/iris/deploy"

export MACHINE="ddigital-SIP9-HD-STICK-V4"

#export GIT_USERNAME="stavros"
