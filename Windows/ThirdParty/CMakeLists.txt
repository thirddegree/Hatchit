if(WIN32)
cmake_minimum_required (VERSION 3.1)
else()
cmake_minimum_required (VERSION 3.0)
endif()

project(ThirdPartyLibs)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

#HANDLE ASSIMP THIRD PARTY LIBRARY
add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/assimp" "${CMAKE_CURRENT_BINARY_DIR}/Assimp")

set_target_properties(uninstall unit gtest UpdateAssimpLibsDebugSymbolsAndDLLs PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1)
set_target_properties(assimp uninstall unit gtest UpdateAssimpLibsDebugSymbolsAndDLLs zlibstatic PROPERTIES FOLDER Assimp)
set_target_properties(assimp
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/assimp/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/assimp/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/assimp/bin"
                      OUTPUT_NAME "assimp")
                      
#HANDLE SDL2 THIRD PARTY LIBRARY

add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/SDL2" "${CMAKE_CURRENT_BINARY_DIR}/SDL2")
set_target_properties(SDL2 SDL2main SDL2-static PROPERTIES FOLDER SDL)
set_target_properties(SDL2
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/SDL2/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/SDL2/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/SDL2/bin")
                      
set_target_properties(SDL2main
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/SDL2/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/SDL2/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/SDL2/bin")
                      
#HANDLE TINYXML2 THIRD PARTY LIBRARY
add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/tinyxml2" "${CMAKE_CURRENT_BINARY_DIR}/tinyxml2")
set_target_properties(tinyxml2 xmltest DATA_COPY PROPERTIES FOLDER tinyxml2)
set_target_properties(tinyxml2
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/tinyxml2/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/tinyxml2/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/tinyxml2/bin"
                      OUTPUT_NAME "tinyxml2")
                      
#HANDLE GLEW THIRD PARTY LIBRARY
add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/glew/build/cmake" "${CMAKE_CURRENT_BINARY_DIR}/glew")
set_target_properties(glew glew_s glewinfo glewmx glewmx_s visualinfo PROPERTIES FOLDER glew)
set_target_properties(glew
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/glew/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/glew/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/glew/bin"
                      OUTPUT_NAME "glew32")

#HANDLE BULLET-PHYSICS THIRD PARTY LIBRARY
add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/bullet3/" "${CMAKE_CURRENT_BINARY_DIR}/bullet3")
set_target_properties(BulletCollision BulletSoftBody BulletDynamics BulletInverseDynamics LinearMath PROPERTIES FOLDER bullet)
set_target_properties(BulletCollision BulletSoftBody BulletDynamics BulletInverseDynamics LinearMath
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/bullet/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/bullet/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/bullet/bin")

#HANDLE CPPFORMAT THIRD PARTY LIBRARY
add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/cppformat/" "${CMAKE_CURRENT_BINARY_DIR}/cppformat")
set_target_properties(cppformat PROPERTIES FOLDER cppformat)
set_target_properties(cppformat
		      PROPERTIES
		      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/cppformat/lib"
		      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/cppformat/lib"
		      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/cppformat/bin")

#HANDLE OPENAL-SOFT THIRD PARTY LIBRARY
add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/openal-soft/" "${CMAKE_CURRENT_BINARY_DIR}/openal-soft")
set_target_properties(altonegen bsincgen common makehrtf OpenAL32 openal-info test-common PROPERTIES FOLDER openal-soft)
set_target_properties(altonegen bsincgen common makehrtf OpenAL32 openal-info test-common
		      PROPERTIES
		      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/openal-soft/lib"
		      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/openal-soft/lib"
		      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/openal-soft/bin")
              
