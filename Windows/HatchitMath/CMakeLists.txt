

include_directories("../../HatchitMath/include")
					
file(GLOB HT_MATH_INC ../../HatchitMath/include/*.h)
file(GLOB HT_MATH_SRC ../../HatchitMath/source/*.cpp)

add_definitions(-D_UNICODE)

add_library(HatchitMath SHARED ${HT_MATH_INC} ${HT_MATH_SRC})

target_compile_definitions(HatchitMath PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitMath)