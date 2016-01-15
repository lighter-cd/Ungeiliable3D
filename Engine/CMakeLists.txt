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
	find_library(ANDROID_LOG log)
	find_library(ANDROID_LIB android)
	set( engine_platform_src Source/Android/esUtil_Android.c 
							 Source/Android/android_native_app_glue.c )
	add_library( Engine STATIC ${engine_src} ${engine_platform_src} )
    target_link_libraries( Engine ${OPENGLES3_LIBRARY} ${EGL_LIBRARY} ${ANDROID_LIB} ${ANDROID_LOG} )
else()
    find_package(X11)
    find_library(M_LIB m)
	set( engine_platform_src Source/LinuxX11/esUtil_X11.c )
	add_library( Engine STATIC ${engine_src} ${engine_platform_src} )
    target_link_libraries( Engine ${OPENGLES3_LIBRARY} ${EGL_LIBRARY} ${X11_LIBRARIES} ${M_LIB} )
endif()

             


