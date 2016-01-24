
include_directories("../../HatchitCore/include" "../../HatchitCore/include/windows"
                    "../../HatchitResource/include"
                    "../../HatchitMath/include"
                    "../../HatchitGraphics/include"
                    "../../HatchitGraphics/include/directx"
                    "../../HatchitGraphics/include/opengl"
                    "../../HatchitGame/include"
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/SDL2/include"
                    "../../ThirdParty/inih/"
                    "../../ThirdParty/tinyxml2/"
                    "../../ThirdParty/glew/include")
                    
link_directories("../_build/dependencies/assimp/lib/$(Configuration)/"
                 "../_build/dependencies/SDL2/lib/$(Configuration)/"
                 "../_build/dependencies/tinyxml2/lib/$(Configuration)/"
                 "../_build/dependencies/glew/lib/$(Configuration)/")
                    
file(GLOB HT_GAME_INC ../../HatchitGame/include/*.h)
file(GLOB HT_GAME_SRC ../../HatchitGame/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})

target_compile_definitions(HatchitGame PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitGame HatchitCore HatchitResource HatchitMath HatchitGraphics tinyxml2 opengl32 glu32 assimp SDL2 glew32 d3d11 d3dcompiler)