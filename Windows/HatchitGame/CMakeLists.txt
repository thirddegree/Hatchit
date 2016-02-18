
if(DEFINED ENV{VK_SDK_PATH})
set(VK_INCLUDES "$ENV{VK_SDK_PATH}/Include")
set(VK_LIB_DIR "$ENV{VK_SDK_PATH}/Source/lib")
set(VK_LIBS debug vulkan-1 optimized vulkan-1)
else()
set(VK_INCLUDES "")
set(VK_LIB_DIR "")
set(VK_LIBS "")
endif()

include_directories("../../HatchitCore/include" "../../HatchitCore/include/windows"
                    "../../HatchitResource/include"
                    "../../HatchitMath/include"
                    "../../HatchitGraphics/include"
                    "../../HatchitGraphics/include/directx"
                    "../../HatchitGraphics/include/opengl"
		    "../../HatchitGraphics/include/vulkan"
                    "../../HatchitGame/include"
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/SDL2/include"
                    "../../ThirdParty/inih/"
                    "../../ThirdParty/tinyxml2/"
                    "../../ThirdParty/glew/include"
                    ${VK_INCLUDES})
                    
link_directories("../_build/dependencies/assimp/lib/$(Configuration)/"
                 "../_build/dependencies/SDL2/lib/$(Configuration)/"
                 "../_build/dependencies/tinyxml2/lib/$(Configuration)/"
                 "../_build/dependencies/glew/lib/$(Configuration)/"
                 ${VK_LIB_DIR})
                    
file(GLOB HT_GAME_INC ../../HatchitGame/include/*.h)
file(GLOB HT_GAME_SRC ../../HatchitGame/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})

target_compile_definitions(HatchitGame PRIVATE HT_NONCLIENT_BUILD)

set(ASSIMP_LIBS debug assimpd optimized assimp)
set(GLEW_LIBS debug glew32d optimized glew32)
set(TINYXML_LIBS debug tinyxml2d optimized tinyxml2)
set(BULLET_LIBS debug BulletCollisiond BulletDynamicsd BulletInverseDynamicsd BulletSoftBodyd LinearMathd optimized BulletCollision BulletDynamics BulletInverseDynamics BulletSoftBody LinearMath)
set(SDL_LIBS debug SDL2d optimized SDL2)
target_link_libraries(HatchitGame HatchitCore HatchitResource HatchitMath HatchitGraphics ${TINYXML_LIBS} opengl32 glu32 ${ASSIMP_LIBS} ${SDL_LIBS} ${GLEW_LIBS} d3d11 d3dcompiler ${VK_LIBS})
