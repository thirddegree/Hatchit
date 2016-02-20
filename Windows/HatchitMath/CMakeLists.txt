

include_directories("../../HatchitMath/include"
                    "../../HatchitMath/source/inline")
					
file(GLOB HT_MATH_INC ../../HatchitMath/include/*.h)
file(GLOB HT_MATH_INL ../../HatchitMath/source/inline/*.inl)
file(GLOB HT_MATH_SRC ../../HatchitMath/source/*.cpp)


source_group("Source Files\\inline" FILES ${HT_MATH_INL})

add_definitions(-D_UNICODE)

add_library(HatchitMath SHARED ${HT_MATH_INC} ${HT_MATH_SRC} ${HT_MATH_INL})

target_compile_definitions(HatchitMath PRIVATE HT_NONCLIENT_BUILD)

target_link_libraries(HatchitMath)