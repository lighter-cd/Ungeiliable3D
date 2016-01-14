cmake_minimum_required( VERSION 3.0 )
project( Ungeiliable3D )

include_directories( Engine/Include )

if(WIN32)
	include_directories( External/Include )
	find_library( OPENGLES3_LIBRARY GLESv2 "OpenGL ES v3.0 library")
	find_library( EGL_LIBRARY EGL "EGL 1.4 library" )
endif()
 
SUBDIRS( Engine
         Samples )	