
include_directories("../../HatchitCore/include"
                    "../../HatchitGraphics/include"
                    "../../ThirdParty/inih/")
                    
file(GLOB HT_GRAPHICS_INC ../../HatchitGraphics/include/*.h)
file(GLOB HT_GRAPHICS_SRC ../../HatchitGraphics/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitGraphics SHARED ${HT_GRAPHICS_INC} ${HT_GRAPHICS_SRC})

target_compile_definitions(HatchitGraphics PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitGraphics)