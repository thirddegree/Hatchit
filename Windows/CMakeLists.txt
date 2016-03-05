if(WIN32)
cmake_minimum_required (VERSION 3.5)
else()
cmake_minimum_required (VERSION 3.0)
endif()

project(HatchitEngine)

#If this is defined we want support for all possible graphics apis
if(ALL_GRAPHICS)
	add_definitions(-DVK_SUPPORT -DGL_SUPPORT -DDX11_SUPPORT -DDX12_SUPPORT)
	message("ALL_GRAPHICS defined")
else()
	if(VK_SUPPORT)
		add_definitions(-DVK_SUPPORT)
		message("Vulkan Support defined")
	endif()
	
	if(GL_SUPPORT)
		add_definitions(-DGL_SUPPORT)
		message("OpenGL Support defined")
	endif()
	
	if(DX12_SUPPORT)
		add_definitions(-DDX12_SUPPORT)
		message("DirectX12 Support defined")
	endif()
	
	if(DX11_SUPPORT)
		add_definitions(-DDX11_SUPPORT)
		message("DirectX11 Support defined")
	endif()
	
endif()

if(UNIVERSAL_APP)
    add_definitions(-DHT_WIN32_UNIVERSAL_APP)
    message("Windows Universal App defined")
elseif(DESKTOP_APP)
    add_definitions(-DHT_WIN32_DESKTOP_APP)
    message("Windows Desktop App defined")
endif()

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
#add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitScript")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitGraphics")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitGame")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitNetwork")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitTest")
