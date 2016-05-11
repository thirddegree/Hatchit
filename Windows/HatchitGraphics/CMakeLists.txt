#If we've asked for Vulkan support
if(DEFINED ENV{VK_SDK_PATH} AND VK_SUPPORT)
set(VK_INCLUDES "$ENV{VK_SDK_PATH}/Include")
set(VK_LIB_DIR "$ENV{VK_SDK_PATH}/Source/lib")
set(VK_LIBS debug vulkan-1 optimized vulkan-1)
set(HT_VK_INCLUDES "../../HatchitGraphics/include/vulkan")

file(GLOB HT_GRAPHICS_VULKAN_INC ../../HatchitGraphics/include/vulkan/*.h)
file(GLOB HT_GRAPHICS_VULKAN_SRC ../../HatchitGraphics/source/vulkan/*.cpp)

source_group("Header Files\\vulkan" FILES ${HT_GRAPHICS_VULKAN_INC})
source_group("Source Files\\vulkan" FILES ${HT_GRAPHICS_VULKAN_SRC})
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

file(GLOB HT_GRAPHICS_OPENGL_INC ../../HatchitGraphics/include/opengl/*.h)
file(GLOB HT_GRAPHICS_OPENGL_SRC ../../HatchitGraphics/source/opengl/*.cpp)

source_group("Header Files\\opengl" FILES ${HT_GRAPHICS_OPENGL_INC})
source_group("Source Files\\opengl" FILES ${HT_GRAPHICS_OPENGL_SRC})
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

file(GLOB HT_GRAPHICS_D3D12_INC ../../HatchitGraphics/include/directx/dx12/*.h)
file(GLOB HT_GRAPHICS_D3D12_SRC ../../HatchitGraphics/source/directx/dx12/*.cpp)

source_group("Header Files\\directx\\dx12" FILES ${HT_GRAPHICS_D3D12_INC})
source_group("Source Files\\directx\\dx12" FILES ${HT_GRAPHICS_D3D12_SRC})
else()
set(DX12_LIBS "")
set(HT_DX12_INCLUDES "")
endif()

# If we've asked for DirectX 11 Support
if(DX11_SUPPORT)
set(DX11_LIBS debug d3d11 d3dcompiler optimized d3d11 d3dcompiler)
set(HT_DX11_INCLUDES "../../HatchitGraphics/include/directx/dx11")

file(GLOB HT_GRAPHICS_D3D11_INC ../../HatchitGraphics/include/directx/dx11/*.h)
file(GLOB HT_GRAPHICS_D3D11_SRC ../../HatchitGraphics/source/directx/dx11/*.cpp)

source_group("Header Files\\directx\\dx11" FILES ${HT_GRAPHICS_D3D11_INC})
source_group("Source Files\\directx\\dx11" FILES ${HT_GRAPHICS_D3D11_SRC})
else()
set(DX11_LIBS "")
set(HT_DX11_INCLUDES "")
endif()

# If we've asked for either DX11 or DX12 Support
if(DX11_SUPPORT OR DX12_SUPPORT)
set(HT_DX_INCLUDES "../../HatchitGraphics/include/directx")

file(GLOB HT_GRAPHICS_DIRECTX_INC ../../HatchitGraphics/include/directx/*.h)
file(GLOB HT_GRAPHICS_DIRECTX_SRC ../../HatchitGraphics/source/directx/*.cpp)

source_group("Header Files\\directx" FILES ${HT_GRAPHICS_DIRECTX_INC})
source_group("Source Files\\directx" FILES ${HT_GRAPHICS_DIRECTX_SRC})
else()
set(HT_DX_INCLUDES "")
endif()

set(D3D12_LIB_DIR "$(WindowsSDK_LibraryPath_x64)")

include_directories("../../HatchitCore/include"
                    "../../HatchitCore/source/inline"
                    "../../HatchitResource/include"
                    "../../HatchitResource/source/inline"
                    "../../HatchitMath/include"
                    "../../HatchitMath/source/inline"
                    "../../HatchitGraphics/include"
                    ${HT_DX_INCLUDES}
                    ${HT_DX11_INCLUDES}
                    ${HT_DX12_INCLUDES}
                    ${HT_GL_INCLUDES}
                    ${HT_VK_INCLUDES}
                    SYSTEM
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/inih/"
                    "../../ThirdParty/tinyxml2/"
                    "../../ThirdParty/json/src"
                    "../../ThirdParty/cppformat/cppformat"
                    "../../ThirdParty/stb/"
                    ${GLEW_INCLUDES}
                    ${VK_INCLUDES})
                    
file(GLOB HT_GRAPHICS_INC ../../HatchitGraphics/include/*.h)
file(GLOB HT_GRAPHICS_SRC ../../HatchitGraphics/source/*.cpp)

add_definitions(-D_UNICODE)

link_directories(${GLEW_LIB_DIR}
                 "../_build/dependencies/assimp/lib/$(Configuration)/"
                 ${D3D12_LIB_DIR}
                 ${VK_LIB_DIR})

add_library(HatchitGraphics SHARED 	${HT_GRAPHICS_INC}
									${HT_GRAPHICS_DIRECTX_INC} 
									${HT_GRAPHICS_OPENGL_INC}
									${HT_GRAPHICS_SRC} 
									${HT_GRAPHICS_DIRECTX_SRC} 
									${HT_GRAPHICS_OPENGL_SRC}
									${HT_GRAPHICS_VULKAN_INC}
									${HT_GRAPHICS_VULKAN_SRC} 
									${HT_GRAPHICS_D3D11_INC}
									${HT_GRAPHICS_D3D11_SRC}
									${HT_GRAPHICS_D3D12_INC}
									${HT_GRAPHICS_D3D12_SRC})

target_compile_definitions(HatchitGraphics PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitGraphics HatchitResource ${DX11_LIBS} ${DX12_LIBS} ${GLEW_LIBS} ${GL_LIBS} ${VK_LIBS})
