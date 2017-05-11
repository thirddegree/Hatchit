cmake_minimum_required(VERSION 3.5)
project(ThirdPartyLibs)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


if(BUILD_WINRT)

#HANDLE FMT WINRT BUILD
add_subdirectory("${CMAKE_SOURCE_DIR}/cppformat" "${CMAKE_CURRENT_BINDARY_DIR}/cppformat")
set_target_properties(fmt
                PROPERTIES
                OUTPUT_NAME fmt_uwp
                ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/cppformat/lib"
                LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/cppformat/lib"
                RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib/cppformat/bin")

else()


endif()