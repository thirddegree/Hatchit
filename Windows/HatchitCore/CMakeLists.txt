

include_directories("../../HatchitCore/include" 
                    "../../HatchitCore/include/windows"
                    "../../ThirdParty/inih/"
                    "../../ThirdParty/cppformat/cppformat"
                    "../../ThirdParty/json/src")
					
file(GLOB HT_CORE_INC ../../HatchitCore/include/*.h ../../HatchitCore/include/windows/*.h)
file(GLOB HT_CORE_SRC ../../HatchitCore/source/*.cpp ../../HatchitCore/source/windows/*.cpp)
file(GLOB INIH_SRC ../../ThirdParty/inih/*.c)
file(GLOB CPPFMT_SRC ../../ThirdParty/cppformat/cppformat/*.cc)

source_group("Source Files\\inih" FILES ${INIH_SRC})
source_group("Source Files\\cppformat" FILES ${CPPFMT_SRC})
add_definitions(-D_UNICODE)

add_library(HatchitCore SHARED ${HT_CORE_INC} ${HT_CORE_SRC} ${INIH_SRC} ${CPPFMT_SRC})

target_compile_definitions(HatchitCore PRIVATE HT_NONCLIENT_BUILD)
target_compile_definitions(HatchitCore PRIVATE FMT_EXPORT)

target_link_libraries(HatchitCore)
