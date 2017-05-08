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
        endif()

        include_directories("HatchitCore/include"
                            "HatchitCore/include/windows"
                            "HatchitCore/include/winrt"
                            "HatchitCore/source/inline"
                            "HatchitResource/include"
                            "HatchitResource/source/inline"
                            "HatchitGraphics/include"
                            "HatchitGraphics/include/vulkan"
                            "HatchitNetwork/include"
                            "HatchitAudio/include"
			                "HatchitGame/include"
			                "HatchitGame/include/sdl"
			                "HatchitGame/source/inline"
                            SYSTEM
                            "ThirdParty/inih"
                            "ThirdParty/cppformat"
                            "ThirdParty/json/src"
                            "ThirdParty/stb"
                            "ThirdParty/assimp/include"
                            "ThirdParty/SDL2/include"
                            "ThirdParty/glm"
                            "ThirdParty/openal-soft/include"
                            "ThirdParty/vorbis/dependencies/ogg/include"
                            "ThirdParty/vorbis/include")

	    link_directories("ThirdParty/lib/SDL2/lib/$(Configuration)"
                         "ThirdParty/lib/openal-soft/lib/$(Configuration)"
                         "ThirdParty/lib/vorbis/lib/$(Configuration)"
                         "ThirdParty/lib/ogg/lib/$(Configuration)"
                         "ThirdParty/lib/cppformat/lib/$(Configuration)")

        ##### CORE LIBRARY ####

        file(GLOB HT_CORE_INC HatchitCore/include/*.h)
		file(GLOB HT_CORE_INL HatchitCore/source/inline/*.inl)
        file(GLOB HT_CORE_SRC HatchitCore/source/*.cpp ThirdParty/inih/*.c HatchitCore/source/windows/*.cpp)

        if(BUILD_WINRT)
            file(GLOB HT_CORE_WINRT_INC HatchitCore/include/winrt/*.h)
            file(GLOB HT_CORE_WINRT_SRC HatchitCore/source/winrt/*.cpp)
        endif()

        # Create source groups
        source_group("Header Files\\winrt" FILES ${HT_CORE_WINRT_INC})
        source_group("Source Files\\inline" FILES ${HT_CORE_INL})
        source_group("Source Files\\winrt" FILES ${HT_CORE_WINRT_SRC})
        
        if(BUILD_WINRT)
            set(HT_CORE_LIBS fmt_uwp)
        else()
            set(HT_CORE_LIBS fmt)
        endif()

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
        target_link_libraries(HatchitCore ${HT_CORE_LIBS})
        

        add_definitions(-DHT_NONCLIENT_BUILD)

        set_target_properties(HatchitCore 
            PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_SOURCE_DIR}/bin/Debug/${RUNTIME_OUTPUT_FOLDER}"
            RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_SOURCE_DIR}/bin/Release/${RUNTIME_OUTPUT_FOLDER}")

	    add_subdirectory(HatchitTest)

    else()
        message( FATAL_ERROR "Please run setup.bat to build required dependencies and initialize build system." )
    endif()

elseif(UNIX)

    find_package(PkgConfig REQUIRED)
    pkg_check_modules(GLFW REQUIRED glfw3)
    pkg_check_modules(ASSIMP REQUIRED assimp)

    find_package(Vulkan REQUIRED)

    include_directories("HatchitCore/include"
                        "HatchitCore/include/linux"
                        "HatchitCore/source/inline"
                        "HatchitResource/include"
                        "HatchitResource/source/inline"
                        "HatchitGraphics/include"
                        "HatchitGraphics/include/vulkan"
                        "HatchitGame/include"
                        "HatchitGame/include/glfw"
                        "HatchitNetwork/include"
                        SYSTEM
                        "ThirdParty/inih/"
                        "ThirdParty/cppformat/cppformat"
                        "ThirdParty/json/src"
                        "ThirdParty/stb"
                        ${VULKAN_INCLUDE_DIR}
                        ${GLFW_INCLUDE_DIRS}
                        ${ASSIMP_INCLUDE_DIRS})

    link_directories(${GLFW_LIBRARY_DIRS})

    # Collect all Hatchit Core source and include
    file(GLOB HT_CORE_INC HatchitCore/include/*.h)
    file(GLOB HT_CORE_SRC HatchitCore/source/*.cpp HatchitCore/source/linux/*.cpp ThirdParty/inih/*.c ThirdParty/cppformat/cppformat/*.cc)

    # Collect all Hatchit Graphics source and include
    file(GLOB HT_GRAPHICS_INC HatchitGraphics/include/*.h HatchitGraphics/include/vulkan/*.h)
    file(GLOB HT_GRAPHICS_SRC HatchitGraphics/source/*.cpp HatchitGraphics/source/vulkan/*.cpp)

    # Collect all Hatchit Resource souce and include
    file(GLOB HT_RESOURCE_INC HatchitResource/include/*.h)
    file(GLOB HT_RESOURCE_SRC HatchitResource/source/*.cpp)
    file(GLOB HT_RESOURCE_INL HatchitResource/source/inline/*.inl)

    # Collect all Hatchit Game source and include
    file(GLOB HT_GAME_INC HatchitGame/include/*.h HatchitGame/include/glfw/*.h)
    file(GLOB HT_GAME_SRC HatchitGame/source/*.cpp HatchitGame/source/glfw/*.cpp)

    #Collect all Hatchit Network source and include
    file(GLOB HT_NETWORK_INC HatchitNetwork/include/*.h)
    file(GLOB HT_NETWORK_SRC HatchitNetwork/source/*.cpp)

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG")

    add_library(HatchitCore SHARED ${HT_CORE_INC} ${HT_CORE_SRC})
    add_library(HatchitResource SHARED ${HT_RESOURCE_INC} ${HT_RESOURCE_SRC} ${HT_RESOURCE_INL})
    add_library(HatchitGraphics SHARED ${HT_GRAPHICS_INC} ${HT_GRAPHICS_SRC})
    add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})
    add_library(HatchitNetwork SHARED ${HT_NETWORK_INC} ${HT_NETWORK_SRC})
    target_compile_definitions(HatchitCore PRIVATE FMT_EXPORT)
    target_compile_definitions(HatchitResource PRIVATE STB_IMAGE_IMPLEMENTATION)
    target_link_libraries(HatchitCore pthread)
    target_link_libraries(HatchitResource HatchitCore ${ASSIMP_LIBRARIES})
    target_link_libraries(HatchitGraphics HatchitCore HatchitResource ${VULKAN_LIBRARY})
    target_link_libraries(HatchitGame HatchitCore HatchitGraphics ${GLFW_LIBRARIES})

    
    add_subdirectory(HatchitTest)

    install (TARGETS HatchitCore HatchitGraphics HatchitGame HatchitNetwork DESTINATION lib)

endif()

