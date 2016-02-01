premake4 --os=android android

copy Samples\Android\AndroidManifest.xml build\android

cd build\android\jni
call ndk-build
cd ..

call android.bat update project -n Ungeiliable3D -p . -t android-21

call ant debug
