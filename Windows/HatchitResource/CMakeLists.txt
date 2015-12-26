
include_directories("../../HatchitCore/include"
                    "../../HatchitResource/include"
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/inih/")
                    
file(GLOB HT_RESOURCE_INC ../../HatchitResource/include/*.h)
file(GLOB HT_RESOURCE_SRC ../../HatchitResource/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitResource SHARED ${HT_RESOURCE_INC} ${HT_RESOURCE_SRC})

target_compile_definitions(HatchitResource PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitResource)