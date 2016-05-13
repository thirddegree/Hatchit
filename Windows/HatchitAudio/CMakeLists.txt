include_directories("../../HatchitAudio/include"
                    "../../HatchitAudio/source/inline"
                    "../../HatchitCore/include"
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
                    "../../ThirdParty/cppformat/cppformat"
                    "../../ThirdParty/openal-soft/include")
                    
link_directories("../_build/dependencies/assimp/lib/$(Configuration)/"
                 "../_build/dependencies/openal-soft/lib/$(Configuration)/")
                    
file(GLOB HT_AUDIO_INC ../../HatchitAudio/include/*.h)
file(GLOB HT_AUDIO_SRC ../../HatchitAudio/source/*.cpp ../../HatchitAudio/source/*.c)
file(GLOB HT_AUDIO_INL ../../HatchitAudio/source/inline/*.inl)

source_group("Source Files\\inline" FILES ${HT_AUDIO_INL})

add_definitions(-D_UNICODE)

add_library(HatchitAudio SHARED ${HT_AUDIO_INC} ${HT_AUDIO_SRC} ${HT_AUDIO_INL})

target_compile_definitions(HatchitAudio PRIVATE HT_NONCLIENT_BUILD STB_IMAGE_IMPLEMENTATION)

set(ASSIMP_LIBS debug assimpd optimized assimp)
set(OPENAL_LIBS debug OpenAL32d optimized OpenAL32)
target_link_libraries(HatchitAudio HatchitResource HatchitCore ${ASSIMP_LIBS} ${OPENAL_LIBS})
