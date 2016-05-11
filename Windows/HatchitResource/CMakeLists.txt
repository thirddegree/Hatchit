include_directories("../../HatchitCore/include"
                    "../../HatchitCore/source/inline"
                    "../../HatchitMath/include"
                    "../../HatchitMath/source/inline"
                    "../../HatchitResource/include"
                    "../../HatchitResource/source/inline"
                    SYSTEM
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/stb/"
                    "../../ThirdParty/inih/"
                    "../../ThirdParty/json/src"
                    "../../ThirdParty/cppformat/cppformat")
                    
link_directories("../_build/dependencies/assimp/lib/$(Configuration)/")
                    
file(GLOB HT_RESOURCE_INC ../../HatchitResource/include/*.h)
file(GLOB HT_RESOURCE_SRC ../../HatchitResource/source/*.cpp ../../HatchitResource/source/*.c)
file(GLOB HT_RESOURCE_INL ../../HatchitResource/source/inline/*.inl)

source_group("Source Files\\inline" FILES ${HT_RESOURCE_INL})

add_definitions(-D_UNICODE)

add_library(HatchitResource SHARED ${HT_RESOURCE_INC} ${HT_RESOURCE_SRC} ${HT_RESOURCE_INL})

target_compile_definitions(HatchitResource PRIVATE HT_NONCLIENT_BUILD STB_IMAGE_IMPLEMENTATION)

set(ASSIMP_LIBS debug assimpd optimized assimp)
target_link_libraries(HatchitResource HatchitCore ${ASSIMP_LIBS})
