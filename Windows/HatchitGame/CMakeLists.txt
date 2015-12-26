
include_directories("../../HatchitCore/include"
                    "../../HatchitResource/include"
                    "../../HatchitGame/include"
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/inih/")
                    
file(GLOB HT_GAME_INC ../../HatchitGame/include/*.h)
file(GLOB HT_GAME_SRC ../../HatchitGame/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitGame SHARED ${HT_GAME_INC} ${HT_GAME_SRC})

target_compile_definitions(HatchitGame PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitGame)