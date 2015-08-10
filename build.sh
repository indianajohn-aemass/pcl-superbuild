#!/bin/bash
# Script to compile PCL for the Android NDK
#
# Instructions: set ANDROID_SDK, ANDROID_NDK_NODETECT, and run.
# Disclaimer: this script is mainly written to be instructive. It will
# likely break as the Android NDK/SDK get updated and some fixing might
# become necessary over time.
#
#

# Define variables
#export ANDROID_SDK=/Users/aemass/Library/Android/sdk/
#export ANDROID_NDK_NODETECT=/Users/aemass/dev/android/android-ndk-r10e/
# We want the superbuild to use out android toolchain, and if we set
# ANDROID_NDK it will try (and probably fail) to make its own.
#export ANDROID_NDK=$ANDROID_NDK_NODETECT
unset ANDROID_NDK

# Make a standalone toolchain
if [-z "$ANDROID_NDK_TOOLCHAIN_ROOT" ]; then
    export ANDROID_NDK_TOOLCHAIN_ROOT=${PWD##*/}/android_toolchain/
    mkdir $ANDROID_NDK_TOOLCHAIN_ROOT;
fi
$ANDROID_NDK_NODETECT/build/tools/make-standalone-toolchain.sh --ndk-dir=$ANDROID_NDK_NODETECT --install_dir=$ANDROID_NDK_TOOLCHAIN_ROOT --platform="android-19" --toolchain=arm-linux-androideabi-4.9

# Make PCL Superbuild
mkdir build
cd build
cmake ../
make -j8