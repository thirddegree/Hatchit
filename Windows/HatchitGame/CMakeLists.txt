
include_directories("../../HatchitCore/include"
                    "../../HatchitResource/include"
                    "../../HatchitGame/include"
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/SDL2/include"
                    "../../ThirdParty/inih/")
                    
link_directories("${PROJECT_SOURCE_DIR}/_build/dependencies/assimp/lib/Release/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/SDL2/lib/Release/")
                    
file(GLOB HT_GAME_INC ../../HatchitGame/include/*.h)
file(GLOB HT_GAME_SRC ../../HatchitGame/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})

target_compile_definitions(HatchitGame PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitGame HatchitCore HatchitResource assimp SDL2)