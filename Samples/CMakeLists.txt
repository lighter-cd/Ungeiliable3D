
if(NOT ANDROID)
	add_executable( Samples Sample.c )
else()
	# android 下，只能编译成 so 文件	
	add_library(Samples SHARED Sample.c)
endif()
target_link_libraries( Samples Engine )
