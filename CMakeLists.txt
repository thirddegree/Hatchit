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

    include_directories("HatchitCore/include"
                        "HatchitCore/include/linux"
                        "HatchitCore/source/inline"
                        "HatchitGraphics/include"
                        "HatchitGraphics/include/vulkan"
                        "HatchitGame/include"
                        "HatchitGame/include/sdl"
                        SYSTEM
                        "ThirdParty/inih/"
                        "ThirdParty/cppformat/cppformat"
                        "ThirdParty/json/src/"
                        "ThirdParty/stb")

    # Collect all Hatchit Core source and include
    file(GLOB HT_CORE_INC HatchitCore/include/*.h)
    file(GLOB HT_CORE_SRC HatchitCore/source/*.cpp HatchitCore/source/linux/*.cpp ThirdParty/inih/*.c ThirdParty/cppformat/cppformat/*.cc)

    # Collect all Hatchit Graphics source and include
    file(GLOB HT_GRAPHICS_INC HatchitGraphics/include/*.h HatchitGraphics/include/vulkan/*.h)
    file(GLOB HT_GRAPHICS_SRC HatchitGraphics/source/*.cpp HatchitGraphics/source/vulkan/*.cpp)

    # Collect all Hatchit Game source and include
    file(GLOB HT_GAME_INC HatchitGame/include/*.h HatchitGame/include/sdl/*.h)
    file(GLOB HT_GAME_SRC HatchitGame/source/*.cpp HatchitGame/source/sdl/*.cpp)

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG")

    add_library(HatchitCore SHARED ${HT_CORE_INC} ${HT_CORE_SRC})
    add_library(HatchitGraphics SHARED ${HT_GRAPHICS_INC} ${HT_GRAPHICS_SRC})
    add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})

    target_compile_definitions(HatchitCore PRIVATE FMT_EXPORT)

    target_link_libraries(HatchitGame HatchitCore HatchitGraphics)

endif()

add_subdirectory(HatchitTest)
