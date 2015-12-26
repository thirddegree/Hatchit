if(WIN32)
cmake_minimum_required (VERSION 3.1)
else()
cmake_minimum_required (VERSION 3.0)
endif()

project(ThirdPartyLibs)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)


add_subdirectory("${PROJECT_SOURCE_DIR}/../../ThirdParty/assimp" "${CMAKE_CURRENT_BINARY_DIR}/Assimp")

set_target_properties(assimp_cmd uninstall unit gtest UpdateAssimpLibsDebugSymbolsAndDLLs PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1)
set_target_properties(assimp
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/assimp/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/assimp/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/../_build/dependencies/assimp/bin")
                      