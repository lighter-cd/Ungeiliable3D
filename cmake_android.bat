mkdir build_android && cd build_android
SET ANDROID_NDK=D:\Dev\Android\android-ndk-r10e-x64
cmake.exe -G"MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE=..\CMake\android-cmake\android.toolchain.cmake -DCMAKE_MAKE_PROGRAM="%ANDROID_NDK%\prebuilt\windows-x86_64\bin\make.exe" -DANDROID_NATIVE_API_LEVEL=android-18 ..