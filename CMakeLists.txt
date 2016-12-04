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
        find_package(Vulkan REQUIRED)

        include_directories("HatchitCore/include"
                            "HatchitCore/include/windows"
                            "HatchitCore/source/inline"
                            "HatchitResource/include"
                            "HatchitResource/source/inline"
                            "HatchitGraphics/include"
                            "HatchitGraphics/include/vulkan"
                            "HatchitNetwork/include"
			                "HatchitGame/include"
			                "HatchitGame/include/glfw"
			                "HatchitGame/source/inline"
                            SYSTEM
                            "ThirdParty/inih"
                            "ThirdParty/cppformat/cppformat"
                            "ThirdParty/json/src"
                            "ThirdParty/stb"
                            "ThirdParty/assimp/include"
                            "ThirdParty/glfw/include"
                            "ThirdParty/glm"
			    ${VULKAN_INCLUDE_DIR})

	    link_directories("ThirdParty/lib/glfw/lib/$(Configuration)")

        # Collect all Hatchit Core source and include
        file(GLOB HT_CORE_INC HatchitCore/include/*.h)
		file(GLOB HT_CORE_INL HatchitCore/source/inline/*.inl)
        file(GLOB HT_CORE_SRC HatchitCore/source/*.cpp HatchitCore/source/windows/*.cpp ThirdParty/inih/*.c ThirdParty/cppformat/cppformat/*.cc)

			#Create source groups
			source_group("Source Files\\inline" FILES ${HT_CORE_INL})

        # Collect all Hatchit Graphics source and include
        file(GLOB HT_GRAPHICS_INC HatchitGraphics/include/*.h)
        file(GLOB HT_GRAPHICS_SRC HatchitGraphics/source/*.cpp)
        file(GLOB HT_GRAPHICS_VULKAN_INC HatchitGraphics/include/vulkan/*.h)
        file(GLOB HT_GRAPHICS_VULKAN_SRC HatchitGraphics/source/vulkan/*.cpp)

            #Create source groups
            source_group("Header Files\\vulkan" FILES ${HT_GRAPHICS_VULKAN_INC})
            source_group("Source Files\\vulkan" FILES ${HT_GRAPHICS_VULKAN_SRC})

        set(HT_GRAPHICS_INC_GLOB ${HT_GRAPHICS_INC} ${HT_GRAPHICS_VULKAN_INC})
        set(HT_GRAPHICS_SRC_GLOB ${HT_GRAPHICS_SRC} ${HT_GRAPHICS_VULKAN_SRC})

        # Collect all Hatchit Resource source and include
        file(GLOB HT_RESOURCE_INC HatchitResource/include/*.h)
        file(GLOB HT_RESOURCE_SRC HatchitResource/source/*.cpp)
        file(GLOB HT_RESOURCE_INL HatchitResource/source/inline/*.inl)

            #Create source groups
            source_group("Source Files\\inline" FILES ${HT_RESOURCE_INL})
        

        # Collect all Hatchit Game source and include
        file(GLOB HT_GAME_INC HatchitGame/include/*.h)
        file(GLOB HT_GAME_SRC HatchitGame/source/*.cpp)
        file(GLOB HT_GAME_GLFW_INC HatchitGame/include/glfw/*.h)
        file(GLOB HT_GAME_GLFW_SRC HatchitGame/source/glfw/*.cpp)

            #Create source groups
            source_group("Header Files\\glfw" FILES ${HT_GAME_GLFW_INC})
            source_group("Source Files\\glfw" FILES ${HT_GAME_GLFW_SRC})
        
        set(HT_GAME_INC_GLOB ${HT_GAME_INC} ${HT_GAME_GLFW_INC})
        set(HT_GAME_SRC_GLOB ${HT_GAME_SRC} ${HT_GAME_GLFW_SRC})

        #Collect all Hatchit Network source and include
        file(GLOB HT_NETWORK_INC HatchitNetwork/include/*.h)
        file(GLOB HT_NETWORK_SRC HatchitNetwork/source/*.cpp)

        

        add_library(HatchitCore SHARED ${HT_CORE_INC} ${HT_CORE_SRC} ${HT_CORE_INL})
        add_library(HatchitGraphics SHARED ${HT_GRAPHICS_INC_GLOB} ${HT_GRAPHICS_SRC_GLOB})
	    add_library(HatchitGame SHARED ${HT_GAME_INC_GLOB} ${HT_GAME_SRC_GLOB})
	    add_library(HatchitNetwork SHARED ${HT_NETWORK_INC} ${HT_NETWORK_SRC})
        add_library(HatchitResource SHARED ${HT_RESOURCE_INC} ${HT_RESOURCE_SRC} ${HT_RESOURCE_INL})
        target_link_libraries(HatchitResource HatchitCore)
        target_link_libraries(HatchitGraphics HatchitCore ${VULKAN_LIBRARY})
	    target_link_libraries(HatchitNetwork HatchitCore Ws2_32)
	    target_link_libraries(HatchitGame HatchitCore HatchitGraphics HatchitNetwork glfw ${VULKAN_LIBRARY})
        target_compile_definitions(HatchitCore PRIVATE FMT_EXPORT)

        add_definitions(-DHT_NONCLIENT_BUILD)

        set_target_properties(HatchitCore HatchitResource HatchitGraphics HatchitGame HatchitNetwork
            PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

	    add_subdirectory(HatchitTest)

    else()
        message( FATAL_ERROR "Please run setup.bat to build required dependencies and initialize build system." )
    endif()

elseif(UNIX)

    find_package(PkgConfig REQUIRED)
    pkg_check_modules(GLFW REQUIRED glfw3)

    find_package(Vulkan REQUIRED)

    include_directories("HatchitCore/include"
                        "HatchitCore/include/linux"
                        "HatchitCore/source/inline"
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
                        ${GLFW_INCLUDE_DIRS})

    link_directories(${GLFW_LIBRARY_DIRS})

    # Collect all Hatchit Core source and include
    file(GLOB HT_CORE_INC HatchitCore/include/*.h)
    file(GLOB HT_CORE_SRC HatchitCore/source/*.cpp HatchitCore/source/linux/*.cpp ThirdParty/inih/*.c ThirdParty/cppformat/cppformat/*.cc)

    # Collect all Hatchit Graphics source and include
    file(GLOB HT_GRAPHICS_INC HatchitGraphics/include/*.h HatchitGraphics/include/vulkan/*.h)
    file(GLOB HT_GRAPHICS_SRC HatchitGraphics/source/*.cpp HatchitGraphics/source/vulkan/*.cpp)

    # Collect all Hatchit Game source and include
    file(GLOB HT_GAME_INC HatchitGame/include/*.h HatchitGame/include/glfw/*.h)
    file(GLOB HT_GAME_SRC HatchitGame/source/*.cpp HatchitGame/source/glfw/*.cpp)

    #Collect all Hatchit Network source and include
    file(GLOB HT_NETWORK_INC HatchitNetwork/include/*.h)
    file(GLOB HT_NETWORK_SRC HatchitNetwork/source/*.cpp)

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG")

    add_library(HatchitCore SHARED ${HT_CORE_INC} ${HT_CORE_SRC})
    add_library(HatchitGraphics SHARED ${HT_GRAPHICS_INC} ${HT_GRAPHICS_SRC})
    add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})
    add_library(HatchitNetwork SHARED ${HT_NETWORK_INC} ${HT_NETWORK_SRC})
    target_compile_definitions(HatchitCore PRIVATE FMT_EXPORT)
    target_link_libraries(HatchitCore pthread)
    target_link_libraries(HatchitGraphics HatchitCore ${VULKAN_LIBRARY})
    target_link_libraries(HatchitGame HatchitCore HatchitGraphics ${GLFW_LIBRARIES})

    
    add_subdirectory(HatchitTest)

    install (TARGETS HatchitCore HatchitGraphics HatchitGame HatchitNetwork DESTINATION lib)

endif()

