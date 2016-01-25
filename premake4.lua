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
		
	
	project "Engine"
		kind "StaticLib"
		language "C"
		files { "Engine/Include/**.h", "Engine/Source/*.c" }
		configuration "windows"
			files { "Engine/Source/Win32/**.c" }
		configuration "linux"
			files { "Engine/Source/LinuxX11/**.c" }
		vpaths { [""] = "Engine" }
		includedirs { "Engine/Include", "$(GLES3_EMU)/include" }	

	project "Samples"
		kind "ConsoleApp"
		language "C"
		files { "Samples/Sample.c" }
		vpaths { [""] = "Samples" }
		includedirs { ".", "Engine/Include", "$(GLES3_EMU)/include" }
		libdirs {"$(GLES3_EMU)"}
		links { "Engine", "libEGL", "libGLESv2" }