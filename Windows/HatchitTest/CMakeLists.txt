
include_directories("${PROJECT_SOURCE_DIR}/../HatchitCore/include/")

add_definitions(-D_UNICODE)

add_executable(HatchitTest ${PROJECT_SOURCE_DIR}/../HatchitTest/source/main.cpp)

add_custom_command(TARGET HatchitTest POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $(SolutionDir)HatchitCore/$(Configuration)/HatchitCore.dll $<TARGET_FILE_DIR:HatchitTest>)

target_link_libraries(HatchitTest HatchitCore)