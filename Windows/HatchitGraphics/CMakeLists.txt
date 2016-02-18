
if(DEFINED ENV{VK_SDK_PATH})
    set(VK_INCLUDES "$ENV{VK_SDK_PATH}/Include")
    set(VK_LIB_DIR "$ENV{VK_SDK_PATH}/Source/lib")
    set(VK_LIBS debug vulkan-1 optimized vulkan-1)
else()
    set(VK_INCLUDES "")
    set(VK_LIB_DIR "")
    set(VK_LIBS "")
endif()

include_directories("../../HatchitCore/include"
                    "../../HatchitGraphics/include"
                    "../../HatchitGraphics/include/directx"
                    "../../HatchitGraphics/include/directx/dx11"
                    "../../HatchitGraphics/include/directx/dx12"
                    "../../HatchitGraphics/include/opengl"
                    "../../HatchitGraphics/include/vulkan"
                    "../../HatchitResource/include"
                    "../../HatchitMath/include"
                    "../../ThirdParty/inih/"
                    "../../ThirdParty/glew/include"
		            "../../ThirdParty/assimp/include"
                    ${VK_INCLUDES})
                    
file(GLOB HT_GRAPHICS_INC ../../HatchitGraphics/include/*.h)
file(GLOB HT_GRAPHICS_SRC ../../HatchitGraphics/source/*.cpp)
file(GLOB HT_GRAPHICS_OPENGL_INC ../../HatchitGraphics/include/opengl/*.h)
file(GLOB HT_GRAPHICS_OPENGL_SRC ../../HatchitGraphics/source/opengl/*.cpp)
file(GLOB HT_GRAPHICS_DIRECTX_INC ../../HatchitGraphics/include/directx/*.h)
file(GLOB HT_GRAPHICS_DIRECTX_SRC ../../HatchitGraphics/source/directx/*.cpp)
file(GLOB HT_GRAPHICS_D3D11_INC ../../HatchitGraphics/include/directx/dx11/*.h)
file(GLOB HT_GRAPHICS_D3D11_SRC ../../HatchitGraphics/source/directx/dx11/*.cpp)
file(GLOB HT_GRAPHICS_D3D12_INC ../../HatchitGraphics/include/directx/dx12/*.h)
file(GLOB HT_GRAPHICS_D3D12_SRC ../../HatchitGraphics/source/directx/dx12/*.cpp)
file(GLOB HT_GRAPHICS_VULKAN_INC ../../HatchitGraphics/include/vulkan/*.h)
file(GLOB HT_GRAPHICS_VULKAN_SRC ../../HatchitGraphics/source/vulkan/*.cpp)

source_group("Header Files\\directx" FILES ${HT_GRAPHICS_DIRECTX_INC})
source_group("Source Files\\directx" FILES ${HT_GRAPHICS_DIRECTX_SRC})
source_group("Header Files\\directx\\dx11" FILES ${HT_GRAPHICS_D3D11_INC})
source_group("Source Files\\directx\\dx11" FILES ${HT_GRAPHICS_D3D11_SRC})
source_group("Header Files\\opengl" FILES ${HT_GRAPHICS_OPENGL_INC})
source_group("Source Files\\opengl" FILES ${HT_GRAPHICS_OPENGL_SRC})
source_group("Header Files\\vulkan" FILES ${HT_GRAPHICS_VULKAN_INC})
source_group("Source Files\\vulkan" FILES ${HT_GRAPHICS_VULKAN_SRC})

add_definitions(-D_UNICODE)


link_directories("../_build/dependencies/glew/lib/$(Configuration)/"
                 "../_build/dependencies/assimp/lib/$(Configuration)/"
                 ${VK_LIB_DIR})

add_library(HatchitGraphics SHARED ${HT_GRAPHICS_INC} ${HT_GRAPHICS_DIRECTX_INC} ${HT_GRAPHICS_OPENGL_INC}  ${HT_GRAPHICS_SRC} ${HT_GRAPHICS_DIRECTX_SRC} 
                                   ${HT_GRAPHICS_OPENGL_SRC} ${HT_GRAPHICS_VULKAN_INC} ${HT_GRAPHICS_VULKAN_SRC} ${HT_GRAPHICS_D3D11_INC} ${HT_GRAPHICS_D3D11_SRC} ${HT_GRAPHICS_D3D12_INC} ${HT_GRAPHICS_D3D12_SRC})

target_compile_definitions(HatchitGraphics PRIVATE HT_NONCLIENT_BUILD)

set(GLEW_LIBS debug glew32d optimized glew32)
set(D3D11_LIBS debug d3d11 d3dcompiler optimized d3d11 d3dcompiler)
set(D3D12_LIBS debug d3d12 d3dcompiler optimized d3d12 d3dcompiler)
set(OPENGL_LIBS debug opengl32 glu32 optimized opengl32 glu32)

target_link_libraries(HatchitGraphics HatchitResource HatchitMath ${D3D11_LIBS} ${D3D12_LIBS} ${GLEW_LIBS} ${OPENGL_LIBS} ${VK_LIBS})
