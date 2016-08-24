cmake_minimum_required(VERSION 3.5)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")
project(Hatchit)

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

if(WIN32)

elseif(UNIX)
    find_package(OpenAL REQUIRED)
    find_library(Vulkan REQUIRED)
    find_package(Bullet REQUIRED)

    include_directories("HatchitCore/include"
                        "HatchitCore/include/linux"
                        "HatchitCore/source/inline"
                        "HatchitGraphics/include"
                        "HatchitGraphics/include/vulkan"
                        SYSTEM
                        "ThirdParty/inih/"
                        "ThirdParty/cppformat/cppformat"
                        "ThirdParty/json/src/"
                        "ThirdParty/stb")

    file(GLOB HT_CORE_SRC HatchitCore/source/*.cpp HatchitCore/source/linux/*.cpp ThirdParty/inih/*.c ThirdParty/cppformat/cppformat/*.cc)
    #file(GLOB HT_GRAPHICS_SRC HatchitGraphics/source/*.cpp)

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG")

    add_library(HatchitCore SHARED ${HT_CORE_SRC})
    #add_library(HatchitGraphics SHARED ${HT_GRAPHICS_SRC})
    target_compile_definitions(HatchitCore PRIVATE FMT_EXPORT)

endif()

add_subdirectory(HatchitTest)
