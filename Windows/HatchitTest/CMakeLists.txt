set (HatchitTest_TITLE "HatchitTest")
configure_file (
    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/HatchitTest.h.in"
    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/HatchitTest.h"
)


include_directories("${PROJECT_SOURCE_DIR}/../HatchitCore/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitResource/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitMath/include"
                    "${PROJECT_SOURCE_DIR}/../HatchitImage/include"
                    "${PROJECT_SOURCE_DIR}/../HatchitImage/stb"
                    "${PROJECT_SOURCE_DIR}/../HatchitGraphics/include"
                    "${PROJECT_SOURCE_DIR}/../HatchitGraphics/include/opengl"
                    "${PROJECT_SOURCE_DIR}/../HatchitGraphics/include/directx"
                    "${PROJECT_SOURCE_DIR}/../HatchitGame/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitTest/include/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/assimp/include"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/SDL2/include"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/inih/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/glew/include/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/tinyxml2/")
                    
                    
                    
link_directories("${PROJECT_SOURCE_DIR}/_build/dependencies/assimp/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/SDL2/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/tinyxml2/lib/$(Configuration)/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/glew/lib/$(Configuration)/")
				

add_definitions(-D_UNICODE)

add_executable(HatchitTest ${PROJECT_SOURCE_DIR}/../HatchitTest/source/main.cpp)

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
                   $<TARGET_FILE_DIR:HatchitImage>/HatchitImage.dll $<TARGET_FILE_DIR:HatchitTest>)                  
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitGame>/HatchitGame.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $(SolutionDir)../dependencies/SDL2/bin/$(Configuration)/SDL2.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $(SolutionDir)../dependencies/assimp/bin/$(Configuration)/assimp.dll $<TARGET_FILE_DIR:HatchitTest>)    
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $(SolutionDir)../dependencies/glew/bin/$(Configuration)/glew32.dll $<TARGET_FILE_DIR:HatchitTest>)    
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $(SolutionDir)../dependencies/tinyxml2/bin/$(Configuration)/tinyxml2.dll $<TARGET_FILE_DIR:HatchitTest>)       
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   ${PROJECT_SOURCE_DIR}/../HatchitTest/HatchitTest.ini $<TARGET_FILE_DIR:HatchitTest>) 
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   ${PROJECT_SOURCE_DIR}/../HatchitImage/test/croissant.png $<TARGET_FILE_DIR:HatchitTest>)    
add_custom_command(TARGET HatchitTest PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   ${PROJECT_SOURCE_DIR}/../HatchitImage/test/floor.jpg $<TARGET_FILE_DIR:HatchitTest>)    
target_link_libraries(HatchitTest HatchitCore HatchitResource HatchitMath HatchitImage HatchitGraphics HatchitGame tinyxml2 assimp SDL2 d3d11 d3dcompiler opengl32 glew32 glu32)