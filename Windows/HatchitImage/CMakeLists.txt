
include_directories("../../HatchitCore/include"
                    "../../HatchitImage/include"
                    "../../HatchitImage/stb/"
                    "../../ThirdParty/inih/")
                    
file(GLOB HT_IMAGE_INC ../../HatchitImage/include/*.h)
file(GLOB HT_IMAGE_SRC ../../HatchitImage/source/*.cpp ../../HatchitImage/source/*.c)
file(GLOB STB_INC ../../HatchitImage/stb/stb_image*.h)

add_definitions(-D_UNICODE)


source_group("Header Files\\stb" FILES ${STB_INC})

add_library(HatchitImage SHARED ${HT_IMAGE_INC} ${HT_IMAGE_SRC} ${STB_INC})

target_compile_definitions(HatchitImage PRIVATE HT_NONCLIENT_BUILD STB_IMAGE_IMPLEMENTATION)

target_link_libraries(HatchitImage HatchitCore)