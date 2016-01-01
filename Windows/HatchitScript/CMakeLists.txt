
include_directories("../../HatchitCore/include"
                    "../../HatchitScript/include"
                    "../../ThirdParty/Python/include"
                    "../../ThirdParty/Python/PC")
                    
file(GLOB HT_SCRIPT_INC ../../HatchitScript/include/*.h)
file(GLOB HT_SCRIPT_SRC ../../HatchitScript/source/*.cpp)

link_directories("${PROJECT_SOURCE_DIR}/_build/dependencies/Python/lib/$(Configuration)/")

add_definitions(-D_UNICODE)

add_library(HatchitScript SHARED ${HT_SCRIPT_INC} ${HT_SCRIPT_SRC})

target_compile_definitions(HatchitScript PRIVATE HT_NONCLIENT_BUILD)

set(PYTHON_LIBS debug python34_d optimized python34 python3)
target_link_libraries(HatchitScript HatchitCore ${PYTHON_LIBS})