cmake_minimum_required(VERSION 3.5)
project(ThirdPartyLibs)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#HANDLE GLFW THIRD PARTY LIBRARY
add_subdirectory("${CMAKE_SOURCE_DIR}/glfw" "${CMAKE_CURRENT_BINARY_DIR}/glfw")
set_target_properties(glfw docs PROPERTIES FOLDER glfw)
set_target_properties(glfw
	PROPERTIES
	ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/glfw/lib"
	LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/glfw/lib"
	RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/glfw/bin"
	OUTPUT_NAME "glfw")

#HANDLE ASSIMP THIRD PARTY LIBRARY
add_subdirectory("${CMAKE_SOURCE_DIR}/assimp" "${CMAKE_CURRENT_BINARY_DIR}/Assimp")
set_target_properties(uninstall unit UpdateAssimpLibsDebugSymbolsAndDLLs PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1)
set_target_properties(assimp uninstall unit UpdateAssimpLibsDebugSymbolsAndDLLs zlibstatic PROPERTIES FOLDER Assimp)
set_target_properties(assimp
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/assimp/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/assimp/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/assimp/bin"
        OUTPUT_NAME "assimp")

#HANDLE TINYXML2 THIRD PARTY LIBRARY
add_subdirectory("${CMAKE_SOURCE_DIR}/tinyxml2" "${CMAKE_CURRENT_BINARY_DIR}/tinyxml2")
set_target_properties(tinyxml2 xmltest DATA_COPY PROPERTIES FOLDER tinyxml2)
set_target_properties(tinyxml2
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/tinyxml2/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/tinyxml2/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/tinyxml2/bin"
        OUTPUT_NAME "tinyxml2")

#HANDLE BULLET-PHYSICS THIRD PARTY LIBRARY
add_subdirectory("${CMAKE_SOURCE_DIR}/bullet3/" "${CMAKE_CURRENT_BINARY_DIR}/bullet3")
set_target_properties(BulletCollision BulletSoftBody BulletDynamics BulletInverseDynamics LinearMath PROPERTIES FOLDER bullet)
set_target_properties(BulletCollision BulletSoftBody BulletDynamics BulletInverseDynamics LinearMath
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/bullet/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/bullet/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/bullet/bin")

#HANDLE OPENAL-SOFT THIRD PARTY LIBRARY
add_subdirectory("${CMAKE_SOURCE_DIR}/openal-soft/" "${CMAKE_CURRENT_BINARY_DIR}/openal-soft")
set_target_properties(altonegen bsincgen common makehrtf OpenAL32 openal-info test-common PROPERTIES FOLDER openal-soft)
set_target_properties(altonegen bsincgen common makehrtf OpenAL32 openal-info test-common
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/openal-soft/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/openal-soft/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/openal-soft/bin")

#HANDLE VORBIS THIRD PARTY LIBRARY
add_subdirectory("${CMAKE_SOURCE_DIR}/vorbis" "${CMAKE_CURRENT_BINARY_DIR}/vorbis")
set_target_properties(ogg vorbis vorbisenc vorbisfile PROPERTIES FOLDER vorbis)
set_target_properties(ogg
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/ogg/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/ogg/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/ogg/bin")
set_target_properties(vorbis vorbisenc vorbisfile
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/vorbis/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/vorbis/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/vorbis/bin")
