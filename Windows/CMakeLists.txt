if(WIN32)
cmake_minimum_required (VERSION 3.5)
else()
cmake_minimum_required (VERSION 3.0)
endif()

set(ALL_GRAPHICS FALSE CACHE BOOL "Build with all available graphics languages")
set(VK_SUPPORT FALSE CACHE BOOL "Build with Vulkan")
set(GL_SUPPORT FALSE CACHE BOOL "Build with OpenGL")
set(DX12_SUPPORT FALSE CACHE BOOL "Build with Direct X 12")
set(DX11_SUPPORT FALSE CACHE BOOL "Build with Direct X 11")

#If this is defined we want support for all possible graphics apis
if(ALL_GRAPHICS)
	add_definitions(-DVK_SUPPORT -DGL_SUPPORT -DDX11_SUPPORT -DDX12_SUPPORT)
	message("ALL_GRAPHICS defined")
else()
	if(VK_SUPPORT)
		add_definitions(-DVK_SUPPORT)
	endif()
	
	if(GL_SUPPORT)
		add_definitions(-DGL_SUPPORT)
	endif()
	
	if(DX12_SUPPORT)
		add_definitions(-DDX12_SUPPORT)
	endif()
	
	if(DX11_SUPPORT)
		add_definitions(-DDX11_SUPPORT)
	endif()
	
endif()

project(HatchitEngine)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Version info
set (HatchitEngine_VERSION_MAJOR 0)
set (HatchitEngine_VERSION_MINOR 1)
set (HatchitEngine_VERSION_BUILD 1)


#configure header file to pass
#CMake settings to source code
configure_file (
    "${PROJECT_SOURCE_DIR}/../HatchitCore/include/ht_version.h.in"
    "${PROJECT_SOURCE_DIR}/../HatchitCore/include/ht_version.h"
)

add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitCore")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitMath")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitResource")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitScript")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitGraphics")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitGame")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitNetwork")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitTest")
