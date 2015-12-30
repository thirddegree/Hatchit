
if(WIN32)
cmake_minimum_required (VERSION 3.1)
else()
cmake_minimum_required (VERSION 3.0)
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
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitImage")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitResource")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitGraphics")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitGame")
add_subdirectory("${PROJECT_SOURCE_DIR}/HatchitTest")



