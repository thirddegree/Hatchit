set (HatchitTest_TITLE "HatchitTest")
configure_file (
    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/HatchitTest.h.in"
    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/HatchitTest.h"
)

#If we've asked for Vulkan support
if(DEFINED ENV{VK_SDK_PATH} AND VK_SUPPORT)
set(VK_INCLUDES "$ENV{VK_SDK_PATH}/Include")
set(VK_LIB_DIR "$ENV{VK_SDK_PATH}/Source/lib")
set(VK_LIBS debug vulkan-1 optimized vulkan-1)
set(HT_VK_INCLUDES "${PROJECT_SOURCE_DIR}../HatchitGraphics/include/vulkan")
else()
set(VK_INCLUDES "")
set(VK_LIB_DIR "")
set(VK_LIBS "")
set(HT_VK_INCLUDES "")
endif()

# If we've asked for OpenGL support
if(GL_SUPPORT)
set(GL_LIBS debug opengl32 glu32 optimized opengl32 glu32)
set(GLEW_LIBS debug glew32d optimized glew32)
set(GLEW_INCLUDES "${PROJECT_SOURCE_DIR}../ThirdParty/glew/include")
set(GLEW_LIB_DIR "${PROJECT_SOURCE_DIR}/_build/dependencies/glew/lib/$(Configuration)/")
set(HT_GL_INCLUDES "${PROJECT_SOURCE_DIR}../HatchitGraphics/include/opengl")
else()
set(GL_LIBS "")
set(GLEW_LIBS "")
set(GLEW_INCLUDES "")
set(HT_GL_INCLUDES "")
endif()

# If we've asked for DirectX 12 Support
if(DX12_SUPPORT)
set(DX12_LIBS debug d3d12 d3dcompiler dxgi optimized d3d12 d3dcompiler dxgi)
set(HT_DX12_INCLUDES "${PROJECT_SOURCE_DIR}../HatchitGraphics/include/directx/dx12")
else()
set(DX12_LIBS "")
set(HT_DX12_INCLUDES "")
endif()

# If we've asked for DirectX 11 Support
if(DX11_SUPPORT)
set(DX11_LIBS debug d3d11 d3dcompiler optimized d3d11 d3dcompiler)
set(HT_DX11_INCLUDES "${PROJECT_SOURCE_DIR}../HatchitGraphics/include/directx/dx11")
else()
set(DX11_LIBS "")
set(HT_DX11_INCLUDES "")
endif()

# If we've asked for either DX11 or DX12 Support
if(DX11_SUPPORT OR DX12_SUPPORT)
set(HT_DX_INCLUDES "${PROJECT_SOURCE_DIR}../HatchitGraphics/include/directx")
else()
set(HT_DX_INCLUDES "")
endif()

set(SDL_LIBS "")
# If we've asked to build a Universal Windows App
if(UNIVERSAL_APP)
    set(HT_WINDOW_INCLUDE ${PROJECT_SOURCE_DIR}/../HatchitGame/include/uwa)
    file(GLOB HT_WINDOW_HEADERS ${PROJECT_SOURCE_DIR}/../HatchitGame/include/uwa/*.h)
    file(GLOB HT_WINDOW_SOURCE ${PROJECT_SOURCE_DIR}/../HatchitGame/source/uwa/*.cpp)
    source_group("Header Files\\uwa" FILES ${HT_WINDOW_HEADERS})
    source_group("Source Files\\uwa" FILES ${HT_WINDOW_SOURCE})
elseif(DESKTOP_APP)
    set(HT_WINDOW_INCLUDE ${PROJECT_SOURCE_DIR}/../ThirdParty/SDL2/include ${PROJECT_SOURCE_DIR}/../HatchitGame/include/sdl)
    file(GLOB HT_WINDOW_HEADERS ${PROJECT_SOURCE_DIR}/../HatchitGame/include/sdl/*.h)
    file(GLOB HT_WINDOW_SOURCE ${PROJECT_SOURCE_DIR}/../HatchitGame/source/sdl/*.cpp)
    source_group("Header Files\\sdl" FILES ${HT_WINDOW_HEADERS})
    source_group("Source Files\\sdl" FILES ${HT_WINDOW_SOURCE})
    set(SDL_LIBS debug SDL2d optimized SDL2)
endif()

#Get build assets (icons etc)
file(GLOB HT_BUILD_RESOURCES ${PROJECT_SOURCE_DIR}/../Assets/Build/*)
file(GLOB HT_BUILD_ICONS ${PROJECT_SOURCE_DIR}/../Assets/Build/*.ico)

include_directories("${PROJECT_SOURCE_DIR}/../HatchitCore/include/" 
                    "${PROJECT_SOURCE_DIR}/../HatchitCore/include/windows"
                    "${PROJECT_SOURCE_DIR}/../HatchitCore/source/inline"
                    "${PROJECT_SOURCE_DIR}/../HatchitResource/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitResource/source/inline"
                    "${PROJECT_SOURCE_DIR}/../HatchitMath/include"
                    "${PROJECT_SOURCE_DIR}/../HatchitMath/source/inline"
                    "${PROJECT_SOURCE_DIR}/../HatchitGraphics/include"
                    ${HT_GL_INCLUDES}
                    ${HT_DX_INCLUDES}
                    ${HT_DX11_INCLUDES}
                    ${HT_DX12_INCLUDES}
                    ${HT_VK_INCLUDES}
                    ${HT_WINDOW_INCLUDE}
                    "${PROJECT_SOURCE_DIR}/../HatchitGame/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitNetwork/include/"
                    SYSTEM
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/assimp/include"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/stb"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/inih/"
                     ${HT_GLEW_INCLUDES}
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/tinyxml2/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/cppformat/cppformat"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/Python/include/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/Python/PC/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/json/src"
                    ${VK_INCLUDES})



link_directories("${PROJECT_SOURCE_DIR}/_build/dependencies/assimp/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/SDL2/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/tinyxml2/lib/$(Configuration)/"
                 ${GLEW_LIB_DIR}
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/Python/lib/$(Configuration)/"
                 ${VK_LIB_DIR})


add_definitions(-D_UNICODE)

add_executable(HatchitTest ${PROJECT_SOURCE_DIR}/../HatchitTest/source/main.cpp ${HT_BUILD_RESOURCES})
add_executable(HatchitClient ${PROJECT_SOURCE_DIR}/../HatchitTest/source/client.cpp)
add_executable(HatchitServer ${PROJECT_SOURCE_DIR}/../HatchitTest/source/server.cpp)

add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   ${PROJECT_SOURCE_DIR}/../HatchitTest/HatchitTest.ini $<TARGET_FILE_DIR:HatchitTest>)
                   
#Call script to compile VK shaders to SPIR-V if we have Vulkan support defined
if(VK_SUPPORT)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND "call"
                   ${PROJECT_SOURCE_DIR}/../Assets/Shaders/compileSPV.bat)
endif()

#Call script to compile HLSL shaders to CSO if we have DirectX12 support defined
if(DX12_SUPPORT)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND "call"
                   ${PROJECT_SOURCE_DIR}/../Assets/Shaders/compileCSO.bat)
endif()

#Copy command to bring icon next to exe
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   ${HT_BUILD_ICONS} $<TARGET_FILE_DIR:HatchitTest>)

#set(PYTHON_LIBS debug python34_d optimized python34 python3)
set(ASSIMP_LIBS debug assimpd optimized assimp)
set(TINYXML_LIBS debug tinyxml2d optimized tinyxml2)
set(BULLET_LIBS debug BulletCollisiond BulletDynamicsd BulletInverseDynamicsd BulletSoftBodyd LinearMathd optimized BulletCollision BulletDynamics BulletInverseDynamics BulletSoftBody LinearMath)

target_link_libraries(HatchitTest HatchitCore HatchitResource HatchitNetwork HatchitGraphics HatchitGame
                       ${TINYXML_LIBS} ${ASSIMP_LIBS} ${SDL_LIBS} ${D3D11_LIBS} ${D3D12_LIBS} ${GLEW_LIBS} ${GL_LIBS} Ws2_32 ${VK_LIBS})
target_link_libraries(HatchitClient HatchitCore HatchitNetwork Ws2_32)
target_link_libraries(HatchitServer HatchitCore HatchitNetwork Ws2_32)
