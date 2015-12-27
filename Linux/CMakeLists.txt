

cmake_minimum_required (VERSION 3.0)

project(HatchitEngine)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Version info
set (HatchitEngine_VERSION_MAJOR 0)
set (HatchitEngine_VERSION_MINOR 1)
set (HatchitEngine_VERSION_BUILD 1)

# Compiler flag
include (CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
if(COMPILER_SUPPORTS_CXX11)
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -g")
else()
    message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()


#configure header file to pass
#CMake settings to source code
configure_file (
    "${PROJECT_SOURCE_DIR}/../HatchitCore/include/ht_version.h.in"
    "${PROJECT_SOURCE_DIR}/../HatchitCore/include/ht_version.h"
)

include_directories("../HatchitCore/include"
                    "../HatchitResource/include"
                    "../HatchitGame/include"
                    "../ThirdParty/inih"
                    "../HatchitTest/include")

file(GLOB HT_CORE_SRC ../HatchitCore/source/*.cpp ../ThirdParty/inih/*.c)
file(GLOB HT_RESOURCE_SRC ../HatchitResource/source/*.cpp)
file(GLOB HT_GAME_SRC ../HatchitGame/source/*.cpp)
file(GLOB HT_TEST_SRC ../HatchitTest/source/main.cpp)

add_library(HatchitCore SHARED ${HT_CORE_SRC})
add_library(HatchitResource SHARED ${HT_RESOURCE_SRC})
add_library(HatchitGame SHARED ${HT_GAME_SRC})

add_executable(ht_test ${HT_TEST_SRC})

target_link_libraries(ht_test HatchitCore HatchitResource HatchitGame assimp SDL2)

#install

install (TARGETS HatchitCore HatchitResource HatchitGame DESTINATION lib)
install (TARGETS ht_test DESTINATION bin)
