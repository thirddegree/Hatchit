set (HatchitTest_TITLE "HatchitTest")
configure_file (
    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/HatchitTest.h.in"
    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/HatchitTest.h"
)


include_directories("${PROJECT_SOURCE_DIR}/../HatchitCore/include/" "${PROJECT_SOURCE_DIR}/../HatchitCore/include/windows"
                    "${PROJECT_SOURCE_DIR}/../HatchitResource/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitMath/include"
                    "${PROJECT_SOURCE_DIR}/../HatchitGraphics/include"
                    "${PROJECT_SOURCE_DIR}/../HatchitGraphics/include/opengl"
                    "${PROJECT_SOURCE_DIR}/../HatchitGraphics/include/directx"
                    "${PROJECT_SOURCE_DIR}/../HatchitGame/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitNetwork/include/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/assimp/include"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/stb"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/SDL2/include"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/inih/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/glew/include/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/tinyxml2/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/Python/include/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/Python/PC/")



link_directories("${PROJECT_SOURCE_DIR}/_build/dependencies/assimp/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/SDL2/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/tinyxml2/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/glew/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/Python/lib/$(Configuration)/")


add_definitions(-D_UNICODE)

add_executable(HatchitTest ${PROJECT_SOURCE_DIR}/../HatchitTest/source/main.cpp)
add_executable(HatchitClient ${PROJECT_SOURCE_DIR}/../HatchitTest/source/client.cpp)
add_executable(HatchitServer ${PROJECT_SOURCE_DIR}/../HatchitTest/source/server.cpp)

set_target_properties(HatchitTest
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/")

add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitNetwork>/HatchitNetwork.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitCore>/HatchitCore.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitResource>/HatchitResource.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitMath>/HatchitMath.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitGraphics>/HatchitGraphics.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitGame>/HatchitGame.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   ${PROJECT_SOURCE_DIR}/../HatchitTest/HatchitTest.ini $<TARGET_FILE_DIR:HatchitTest>)
                   
set_target_properties(HatchitClient
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/")

add_custom_command(TARGET HatchitClient PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitNetwork>/HatchitNetwork.dll $<TARGET_FILE_DIR:HatchitClient>)
add_custom_command(TARGET HatchitClient PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitCore>/HatchitCore.dll $<TARGET_FILE_DIR:HatchitClient>)
                   
set_target_properties(HatchitServer
                      PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/"
                      LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/"
                      RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/_build/bin/")

add_custom_command(TARGET HatchitServer PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitNetwork>/HatchitNetwork.dll $<TARGET_FILE_DIR:HatchitServer>)
add_custom_command(TARGET HatchitServer PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitCore>/HatchitCore.dll $<TARGET_FILE_DIR:HatchitServer>)



set(PYTHON_LIBS debug python34_d optimized python34 python3)
set(ASSIMP_LIBS debug assimpd optimized assimp)
set(GLEW_LIBS debug glew32d optimized glew32)
target_link_libraries(HatchitTest HatchitCore HatchitResource HatchitMath HatchitNetwork HatchitGraphics HatchitGame ${PYTHON_LIBS} tinyxml2 ${ASSIMP_LIBS} SDL2 d3d11 d3dcompiler opengl32 ${GLEW_LIBS} glu32 Ws2_32)
target_link_libraries(HatchitClient HatchitCore HatchitNetwork Ws2_32)
target_link_libraries(HatchitServer HatchitCore HatchitNetwork Ws2_32)
