set ( engine_src Source/esShader.c 
                 Source/esShapes.c
                 Source/esTransform.c
                 Source/esUtil.c )


# Win32 Platform files
if(WIN32)
    set( engine_platform_src Source/Win32/esUtil_win32.c )
    add_library( Engine STATIC ${engine_src} ${engine_platform_src} )
    target_link_libraries( Engine ${OPENGLES3_LIBRARY} ${EGL_LIBRARY} )
	
elseif(ANDROID)

	include("${PROJECT_SOURCE_DIR}/CMake/android-cmake/AndroidNdkModules.cmake") # android_ndk_import_module_native_app_glue
	android_ndk_import_module_native_app_glue() # native_app_glue

	set( engine_platform_src Source/Android/esUtil_Android.c )
	add_library( Engine STATIC ${engine_src} ${engine_platform_src} )
    target_link_libraries( Engine native_app_glue ${OPENGLES3_LIBRARY} ${EGL_LIBRARY} android log )
else()
    find_package(X11)
    find_library(M_LIB m)
	set( engine_platform_src Source/LinuxX11/esUtil_X11.c )
	add_library( Engine STATIC ${engine_src} ${engine_platform_src} )
    target_link_libraries( Engine ${OPENGLES3_LIBRARY} ${EGL_LIBRARY} ${X11_LIBRARIES} ${M_LIB} )
endif()
