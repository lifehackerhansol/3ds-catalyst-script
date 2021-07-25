#!/bin/bash

## THIS IS USED FOR PUSHING UPDATES TO MY ROM! NOT MEANT FOR OTHER USE

today=$(date "+%Y%m%d")

echo "Updating ROM source" #TODO: FUCKING MAKE THIS CLEANER YOU FUCKING DUMMY
cd /opt/android/Bliss/r/
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune

echo "Building rom with latest changes"
. build/envsetup.sh
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 100G
blissify -g sunfish

echo "Pushing updates to update server"
cp $OUT/bliss_sunfish-ota-eng-mia.zip /var/www/ota/builds/bliss-14.5-$today-nightly-sunfish.zip
cp $OUT/system/build.prop /var/www/LineageOTA/builds/full/bliss-14.5-$today-nightly-sunfish.zip.prop
