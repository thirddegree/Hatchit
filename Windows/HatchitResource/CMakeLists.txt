
include_directories("../../HatchitCore/include"
                    "../../HatchitResource/include"
                    "../../HatchitResource/source/inline"
                    "../../ThirdParty/assimp/include"
                    "../../ThirdParty/stb/"
                    "../../ThirdParty/inih/"
		    "../../ThirdParty/json/src"
		    "../../ThirdParty/cppformat/cppformat")
                    
link_directories("../_build/dependencies/assimp/lib/$(Configuration)/")
                    
file(GLOB HT_RESOURCE_INC ../../HatchitResource/include/*.h)
file(GLOB HT_RESOURCE_SRC ../../HatchitResource/source/*.cpp ../../HatchitResource/source/*.c)

add_definitions(-D_UNICODE)

add_library(HatchitResource SHARED ${HT_RESOURCE_INC} ${HT_RESOURCE_SRC})

target_compile_definitions(HatchitResource PRIVATE HT_NONCLIENT_BUILD STB_IMAGE_IMPLEMENTATION)

set(ASSIMP_LIBS debug assimpd optimized assimp)
target_link_libraries(HatchitResource HatchitCore ${ASSIMP_LIBS})
