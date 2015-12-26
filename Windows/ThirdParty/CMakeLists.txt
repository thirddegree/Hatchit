if(WIN32)
cmake_minimum_required (VERSION 3.1)
else()
cmake_minimum_required (VERSION 3.0)
endif()

project(ThirdPartyLibs)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)


set(CMAKE_DEBUG_POSTFIX "")


#HANDLE ASSIMP THIRD PARTY LIBRARY
add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/assimp" "${CMAKE_CURRENT_BINARY_DIR}/Assimp")

set_target_properties(assimp_cmd uninstall unit gtest UpdateAssimpLibsDebugSymbolsAndDLLs PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1)
set_target_properties(assimp assimp_viewer assimp_cmd uninstall unit gtest UpdateAssimpLibsDebugSymbolsAndDLLs zlibstatic PROPERTIES FOLDER Assimp)
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
#add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/tinyxml2" "${CMAKE_CURRENT_BINARY_DIR}/tinyxml2")
