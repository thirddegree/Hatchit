include_directories("../../HatchitNetwork/include"
                    "../../HatchitCore/include"
                    "../../ThirdParty/cppformat/cppformat")

file(GLOB HT_NETWORK_INC ../../HatchitNetwork/include/*.h)
file(GLOB HT_NETWORK_SRC ../../HatchitNetwork/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitNetwork SHARED ${HT_NETWORK_INC} ${HT_NETWORK_SRC})

target_compile_definitions(HatchitNetwork PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitNetwork HatchitCore Ws2_32)
