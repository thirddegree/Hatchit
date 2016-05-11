

cmake_minimum_required (VERSION 3.0)

project(HatchitEngine)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Version info
set (HatchitEngine_VERSION_MAJOR 0)
set (HatchitEngine_VERSION_MINOR 1)
set (HatchitEngine_VERSION_BUILD 1)

# Compiler flag
include (CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++1y" COMPILER_SUPPORTS_CXX14)
if(COMPILER_SUPPORTS_CXX14)
    if(CMAKE_BUILD_TYPE MATCHES DEBUG)
        set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y -Wall -g -msse")
    else()
        set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y -Wall -msse")
    endif()
else()
    message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

if(ALL_GRAPHICS)
	message("All Graphics defined")
	add_definitions(-DVK_SUPPORT -DGL_SUPPORT)
endif()

#Graphics specific files
if(VK_SUPPORT)

message("Vulkan Support defined")

set(VK_INCLUDES "/usr/include/vulkan")
set(VK_LIBS vulkan)

set(HT_VK_INCLUDES "../HatchitGraphics/include/vulkan")
file(GLOB HT_VK_SRC ../HatchitGraphics/source/vulkan/*.cpp)

else()

set(VK_INCLUDES "")
set(VK_LIBS "")

set(HT_VK_INCLUDES "")

endif()

if(GL_SUPPORT)

message("OpenGL Support defined")

set(GL_LIBS GL GLEW GLU )

set(HT_GL_INCLUDES "../HatchitGraphics/include/opengl")
file(GLOB HT_GL_SRC ../HatchitGraphics/source/opengl/*.cpp)

else()

set(GL_LIBS "")

set(HT_GL_INCLUDES "")

endif()

set(WINDOW_LIBS SDL2)
set(HT_WINDOW_INCLUDES ../HatchitGame/include/sdl/)

file(GLOB HT_WINDOW_SRC ../HatchitGame/source/sdl/*.cpp)

#configure header file to pass
#CMake settings to source code
configure_file (
    "${PROJECT_SOURCE_DIR}/../HatchitCore/include/ht_version.h.in"
    "${PROJECT_SOURCE_DIR}/../HatchitCore/include/ht_version.h"
)

include_directories("../HatchitCore/include" 
		            "../HatchitCore/include/linux"
                    "../HatchitResource/include"
    		        "../HatchitCore/source/inline"
                    "../HatchitResource/source/inline"
                    "../HatchitMath/include"
                    "../HatchitGraphics/include"
                    "../HatchitNetwork/include"
		            "../HatchitMath/source/inline"
                    "../HatchitGame/include"
		            ${HT_VK_INCLUDES}
		            ${HT_GL_INCLUDES}
                    ${HT_WINDOW_INCLUDES}
                    "../HatchitTest/include"
                    SYSTEM
                    "../ThirdParty/inih/"
                    "../ThirdParty/cppformat/cppformat"
                    "../ThirdParty/json/src/"
                    "../ThirdParty/stb")

file(GLOB HT_CORE_SRC ../HatchitCore/source/*.cpp ../HatchitCore/source/linux/*.cpp ../ThirdParty/inih/*.c ../ThirdParty/cppformat/cppformat/*.cc)
file(GLOB HT_RESOURCE_SRC ../HatchitResource/source/*.cpp ../HatchitResource/source/*.c)
file(GLOB HT_MATH_SRC ../HatchitMath/source/*.cpp)
file(GLOB HT_GRAPHICS_SRC ../HatchitGraphics/source/*.cpp)
#file(GLOB HT_SCRIPT_SRC ../HatchitScript/source/*.cpp)
file(GLOB HT_NETWORK_SRC ../HatchitNetwork/source/*cpp)
file(GLOB HT_GAME_SRC ../HatchitGame/source/*.cpp)
file(GLOB HT_TEST_SRC ../HatchitTest/source/main.cpp)
file(GLOB HT_CLIENT_SRC ../HatchitTest/source/client.cpp)
file(GLOB HT_SERVER_SRC ../HatchitTest/source/server.cpp)


add_library(HatchitCore SHARED ${HT_CORE_SRC})
add_library(HatchitMath SHARED ${HT_MATH_SRC})
add_library(HatchitResource SHARED ${HT_RESOURCE_SRC})
#add_library(HatchitScript SHARED ${HT_SCRIPT_SRC})
add_library(HatchitGraphics SHARED ${HT_GRAPHICS_SRC} ${HT_VK_SRC} ${HT_GL_SRC})
add_library(HatchitNetwork SHARED ${HT_NETWORK_SRC})
add_library(HatchitGame SHARED ${HT_GAME_SRC} ${HT_WINDOW_SRC})

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG")

target_compile_definitions(HatchitResource PRIVATE STB_IMAGE_IMPLEMENTATION)
target_compile_definitions(HatchitCore PRIVATE FMT_EXPORT)
if(GL_SUPPORT)
	target_compile_definitions(HatchitGame PRIVATE GL_SUPPORT)
    target_compile_definitions(HatchitGraphics PRIVATE GL_SUPPORT)
endif()

if(VK_SUPPORT)
	target_compile_definitions(HatchitGame PRIVATE VK_SUPPORT)
    target_compile_definitions(HatchitGraphics PRIVATE VK_SUPPORT)
endif()

add_executable(ht_test ${HT_TEST_SRC})
add_executable(ht_client ${HT_CLIENT_SRC})
add_executable(ht_server ${HT_SERVER_SRC})
add_custom_command(TARGET ht_test PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   ${PROJECT_SOURCE_DIR}/../HatchitTest/HatchitTest.ini $<TARGET_FILE_DIR:ht_test>)

#target_link_libraries(HatchitCore cppformat)
target_link_libraries(HatchitResource assimp)
target_link_libraries(HatchitGraphics HatchitCore HatchitResource HatchitMath)
target_link_libraries(HatchitNetwork HatchitCore)
target_link_libraries(HatchitGame HatchitCore HatchitResource HatchitMath HatchitGraphics HatchitNetwork assimp SDL2 ${GL_LIBS} ${VK_LIBS} ${WINDOW_LIBS} )
target_link_libraries(ht_test HatchitCore HatchitResource HatchitMath HatchitGraphics HatchitNetwork HatchitGame assimp SDL2 ${GL_LIBS} ${VK_LIBS} pthread)
target_link_libraries(ht_client HatchitCore HatchitNetwork pthread)
target_link_libraries(ht_server HatchitCore HatchitNetwork pthread)


#install

install (TARGETS HatchitCore HatchitResource HatchitMath HatchitGraphics HatchitNetwork HatchitGame DESTINATION lib)
install (TARGETS ht_test ht_client ht_server DESTINATION bin)

