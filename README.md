--------
Overview
--------

CMake build scripts for cross compiling PCL and its dependencies for Android and iOS. This
will create a collection of static libraries that you can link into mobile apps.

------------
Instructions
------------

* Install Android SDK and NDK.

* Tell your environment where to find the Android NDK/SDK. (NODETECT prevents
  the custom toolchain script for CMake from trying to create its own independent
  toolchain rather than using the one you provide).

  ~~~~bash
  export ANDROID_SDK=/path/to/android/sdk/root
  export ANDROID_NDK_NODETECT=/path/to/android/ndk/root
  ~~~~

* Optional: provide the path to your custom toolchain. (If you do not do this, the
  script in the next step will create a custom toolchain for you).
  
  ~~~~bash
  export ANDROID_NDK_TOOLCHAIN_ROOT=/path/to/custom/toolchain/root
  ~~~~

* Build the superbuild.

  ~~~~bash
  ./build.sh
  ~~~~

----------
What Next?
----------
Each .a file can be linked to a native library using something like this in an Android.mk file.

~~~~
include $(CLEAR_VARS)
LOCAL_MODULE := mystaticlib
LOCAL_SRC_FILES := /path/to/mystaticlib.a
LOCAL_EXPORT_C_INCLUDES :=  /path/to/relevant/includes
include $(PREBUILT_STATIC_LIBRARY)

...

include $(CLEAR_VARS)

...

LOCAL_STATIC_LIBRARIES :=   mystaticlib

...

include $(BUILD_SHARED_LIBRARY)
~~~~

----------
References
----------

1. Overview. https://github.com/PointCloudLibrary/pcl/wiki/Android
2. Choose a toolchain.  http://stackoverflow.com/questions/29444079/unable-to-auto-config-arch-from-toolchain
3. https://github.com/patmarion/pcl-superbuild
4. https://github.com/Itseez/opencv/blob/master/platforms/android/android.toolchain.cmake
5.https://github.com/patmarion/boost-build
6. https://github.com/emileb/Boost-for-Android-Prebuilt