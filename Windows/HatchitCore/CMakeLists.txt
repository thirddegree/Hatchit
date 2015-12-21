

include_directories("${PROJECT_SOURCE_DIR}/../HatchitCore/include")
					
file(GLOB HT_CORE_INC ${PROJECT_SOURCE_DIR}/../HatchitCore/include/*.h)
file(GLOB HT_CORE_SRC ${PROJECT_SOURCE_DIR}/../HatchitCore/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitCore SHARED ${HT_CORE_INC} ${HT_CORE_SRC})

target_compile_definitions(HatchitCore PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitCore)