local action = _ACTION or ""

solution "Ungeiliable3D"
	location ( "Build/" .. action )
	configurations { "Debug", "Release" }
	
	configuration "vs*"
		defines { "_CRT_SECURE_NO_WARNINGS" }	
		
	configuration "Debug"
		targetdir ( "Build/" .. action .. "/bin/Debug" )
		flags { "Symbols" }

	configuration "Release"
		targetdir ( "Build/" .. action .. "/bin/Release" )
		defines { "NDEBUG" }
		flags { "Optimize" }
		
	configuration "android"
		ndkplatform "android-21"
	
	project "Engine"
		kind "StaticLib"
		language "C"
		files { "Engine/Include/**.h", "Engine/Source/*.c" }
		-- vpaths { [""] = "Engine" }
		includedirs { "Engine/Include" }	

		configuration "windows"
			files { "Engine/Source/Win32/**.c" }
		configuration "linux"
			files { "Engine/Source/LinuxX11/**.c" }
		configuration "windows or linux"
			includedirs { "$(GLES3_EMU)/include"}
		configuration "android"
			files { "Engine/Source/Android/**.c" }
			includedirs { "$(ANDROID_NDK)/sources/android/native_app_glue"}
			defines { "ANDROID" }
		configuration "ios"
			files { "Engine/Source/iOS/**.h",  "Engine/Source/iOS/**.m"}	

	project "Samples"
		language "C"
		files { "Samples/Sample.c" }
		-- vpaths { [""] = "Samples" }
		includedirs { "Engine/Include" }	

		configuration "windows or linux"
			kind "ConsoleApp"
			includedirs { "$(GLES3_EMU)/include"}
			libdirs {"$(GLES3_EMU)"}
			links { "Engine", "libEGL", "libGLESv2" }

		configuration "android"
			kind "SharedLib"
			links { "Engine", "log", "android", "EGL", "GLESv3" }
			defines { "ANDROID" }
			ndkmodule_imports { "android/native_app_glue" }
            ndkmodule_staticlinks { "android_native_app_glue" }
			
		configuration "linux"
			links { "X11" }
			
		configuration "ios"
			kind "WindowedApp"
			xcodebuildoptions {
				"TARGETED_DEVICE_FAMILY = \"1,2\";",
				"INFOPLIST_FILE = samples.plist;"
			}
			links { "Engine" }
			linkoptions { "-framework Foundation", "-framework CoreGraphics", "-framework UIKit", "-framework GLKit", "-framework OpenGLES" }