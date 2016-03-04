#If we've asked for Vulkan support
if(DEFINED ENV{VK_SDK_PATH} AND VK_SUPPORT)
set(VK_INCLUDES "$ENV{VK_SDK_PATH}/Include")
set(VK_LIB_DIR "$ENV{VK_SDK_PATH}/Source/lib")
set(VK_LIBS debug vulkan-1 optimized vulkan-1)
set(HT_VK_INCLUDES "../../HatchitGraphics/include/vulkan")
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
set(GLEW_INCLUDES "../../ThirdParty/glew/include")
set(GLEW_LIB_DIR "../_build/dependencies/glew/lib/$(Configuration)/")
set(HT_GL_INCLUDES "../../HatchitGraphics/include/opengl")
else()
set(GL_LIBS "")
set(GLEW_LIBS "")
set(GLEW_INCLUDES "")
set(GLEW_LIB_DIR "")
set(HT_GL_INCLUDES "")
endif()

# If we've asked for DirectX 12 Support
if(DX12_SUPPORT)
set(DX12_LIBS debug d3d12 d3dcompiler dxgi optimized d3d12 d3dcompiler dxgi)
set(HT_DX12_INCLUDES "../../HatchitGraphics/include/directx/dx12")
else()
set(DX12_LIBS "")
set(HT_DX12_INCLUDES "")
endif()

# If we've asked for DirectX 11 Support
if(DX11_SUPPORT)
set(DX11_LIBS debug d3d11 d3dcompiler optimized d3d11 d3dcompiler)
set(HT_DX11_INCLUDES "../../HatchitGraphics/include/directx/dx11")
else()
set(DX11_LIBS "")
set(HT_DX11_INCLUDES "")
endif()

# If we've asked for either DX11 or DX12 Support
if(DX11_SUPPORT OR DX12_SUPPORT)
set(HT_DX_INCLUDES "../../HatchitGraphics/include/directx")
else()
set(HT_DX_INCLUDES "")
endif()

include_directories("../../HatchitCore/include" "../../HatchitCore/include/windows"
                    "../../HatchitResource/include"
                    "../../HatchitMath/include"
                    "../../HatchitMath/source/inline"
                    "../../HatchitGraphics/include"
                    ${HT_DX_INCLUDES}
                    ${HT_DX11_INCLUDES}
                    ${HT_DX12_INCLUDES}
                    ${HT_GL_INCLUDES}
		    ${HT_VK_INCLUDES}
                    "../../HatchitGame/include"
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/SDL2/include"
                    "../../ThirdParty/inih/"
                    "../../ThirdParty/tinyxml2/"
		    "../../ThirdParty/json/src"
		    "../../ThirdParty/cppformat/cppformat"
                    ${GLEW_INCLUDES}
                    ${VK_INCLUDES})
                    
link_directories("../_build/dependencies/assimp/lib/$(Configuration)/"
                 "../_build/dependencies/SDL2/lib/$(Configuration)/"
                 "../_build/dependencies/tinyxml2/lib/$(Configuration)/"
                 ${GLEW_LIB_DIR}
                 ${VK_LIB_DIR})
                    
file(GLOB HT_GAME_INC ../../HatchitGame/include/*.h)
file(GLOB HT_GAME_SRC ../../HatchitGame/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})

target_compile_definitions(HatchitGame PRIVATE HT_NONCLIENT_BUILD)

set(ASSIMP_LIBS debug assimpd optimized assimp)
set(TINYXML_LIBS debug tinyxml2d optimized tinyxml2)
set(BULLET_LIBS debug BulletCollisiond BulletDynamicsd BulletInverseDynamicsd BulletSoftBodyd LinearMathd optimized BulletCollision BulletDynamics BulletInverseDynamics BulletSoftBody LinearMath)
set(SDL_LIBS debug SDL2d optimized SDL2)

target_link_libraries(HatchitGame HatchitCore HatchitResource HatchitGraphics ${TINYXML_LIBS} ${GL_LIBS} ${ASSIMP_LIBS} ${SDL_LIBS} ${GLEW_LIBS} ${DX11_LIBS} ${DX12_LIBS} ${VK_LIBS})
