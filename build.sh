#!/bin/bash

# Version 2.0.4

# We don't allow scrollback buffer
echo -e '\0033\0143'
clear

# Get current path
DIR="$(cd `dirname $0`; pwd)"
OUT="$(readlink $DIR/out)"
[ -z "${OUT}" ] && OUT="${DIR}/out"

# Local defaults, can be overriden by environment
: ${THREADS:="$(cat /proc/cpuinfo | grep "^processor" | wc -l)"}

# Import command line parameters
DEVICE="$1"
EXTRAS="$2"

# Get build version
#MAJOR=$(cat $DIR/vendor/mk/vendor.mk | grep 'ROM_VERSION_MAJOR := *' | sed  's/ROM_VERSION_MAJOR := //g')
#MINOR=$(cat $DIR/vendor/mk/vendor.mk | grep 'ROM_VERSION_MINOR := *' | sed  's/ROM_VERSION_MINOR := //g')
#MAINTENANCE=$(cat $DIR/vendor/mk/vendor.mk | grep 'ROM_VERSION_MAINTENANCE := *' | sed  's/ROM_VERSION_MAINTENANCE := //g')

#VERSION=$MAJOR.$MINOR$MAINTENANCE

# If there is no extra parameter, reduce parameters index by 1
if [ "$EXTRAS" == "true" ] || [ "$EXTRAS" == "false" ]; then
        SYNC="$2"
        UPLOAD="$3"
else
        SYNC="$3"
        UPLOAD="$4"
fi

echo -e "Building MASTAKAT for $DEVICE";

# Decide what command to execute
case "$EXTRAS" in
        threads)
                echo -e "Please enter desired building/syncing threads number followed by [ENTER]"
                read threads
                THREADS=$threads
        ;;
        clean|cclean)
                echo -e "Cleaning intermediates and output files"
                export CLEAN_BUILD="true"
                [ -d "${DIR}/out" ] && rm -Rf ${DIR}/out/*
        ;;
esac

echo -e ""

# Fetch latest sources
if [ "$SYNC" == "true" ]; then
        echo -e ""
        echo -e "$Fetching latest sources"
        repo sync -j"$THREADS"
        echo -e ""
fi

# Setup environment
echo -e ""
echo -e "Setting up environment"
. build/envsetup.sh
echo -e ""

# lunch/brunch device
echo -e "Lunching device [$DEVICE]"
lunch "mk_$DEVICE-userdebug";
echo -e "Starting compilation"
mka bacon

echo -e ""
