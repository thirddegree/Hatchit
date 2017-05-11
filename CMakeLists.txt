cmake_minimum_required(VERSION 3.5)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")
project(Hatchit)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Version info
set (HatchitEngine_VERSION_MAJOR 0)
set (HatchitEngine_VERSION_MINOR 1)
set (HatchitEngine_VERSION_BUILD 1)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(WIN32)
    if(IS_DIRECTORY "${CMAKE_SOURCE_DIR}/build/")

        if(BUILD_WINRT)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /ZW")
            set(RUNTIME_OUTPUT_FOLDER AppX)

            link_directories("ThirdParty/lib/cppformat/lib/$(Configuration)")

            ##### CORE LIBRARY ####

            file(GLOB HT_CORE_INC HatchitCore/include/*.h)
            file(GLOB HT_CORE_INL HatchitCore/source/inline/*.inl)
            file(GLOB HT_CORE_SRC HatchitCore/source/*.cpp ThirdParty/inih/*.c HatchitCore/source/windows/*.cpp)
            file(GLOB HT_CORE_WINRT_INC HatchitCore/include/winrt/*.h)
            file(GLOB HT_CORE_WINRT_SRC HatchitCore/source/winrt/*.cpp)

            # Create source groups
            source_group("Header Files\\winrt" FILES ${HT_CORE_WINRT_INC})
            source_group("Source Files\\inline" FILES ${HT_CORE_INL})
            source_group("Source Files\\winrt" FILES ${HT_CORE_WINRT_SRC})

            add_library(HatchitCore SHARED ${HT_CORE_INC} ${HT_CORE_SRC} ${HT_CORE_INL} ${HT_CORE_WINRT_INC} ${HT_CORE_WINRT_SRC})
            target_include_directories(HatchitCore 
                PUBLIC
                "HatchitCore/include"
                "HatchitCore/include/windows"
                "HatchitCore/include/winrt"
                "HatchitCore/source/inline"
                SYSTEM
                "ThirdParty/inih"
                "ThirdParty/cppformat")
            target_link_libraries(HatchitCore fmt_uwp)
            

            add_definitions(-DHT_NONCLIENT_BUILD)

            set_target_properties(HatchitCore 
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_SOURCE_DIR}/bin/Debug/${RUNTIME_OUTPUT_FOLDER}"
                RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_SOURCE_DIR}/bin/Release/${RUNTIME_OUTPUT_FOLDER}")

            add_subdirectory(HatchitTest)

        else()

        endif()
    else()
        message( FATAL_ERROR "Please run setup.bat to build required dependencies and initialize build system." )
    endif()

endif()