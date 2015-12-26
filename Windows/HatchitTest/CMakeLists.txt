
include_directories("${PROJECT_SOURCE_DIR}/../HatchitCore/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitResource/include/"
                    "${PROJECT_SOURCE_DIR}/../HatchitGame/include/"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/assimp/include"
                    "${PROJECT_SOURCE_DIR}/../ThirdParty/inih/")
                    
                    
                    
link_directories("${PROJECT_SOURCE_DIR}/_build/dependencies/assimp/lib/Release/"
                 "${PROJECT_SOURCE_DIR}/_build/dependencies/SDL2/lib/Release/")
				

add_definitions(-D_UNICODE)

add_executable(HatchitTest ${PROJECT_SOURCE_DIR}/../HatchitTest/source/main.cpp)

add_custom_command(TARGET HatchitTest POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitCore>/HatchitCore.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitResource>/HatchitResource.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $<TARGET_FILE_DIR:HatchitGame>/HatchitGame.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $(SolutionDir)../dependencies/SDL2/bin/Release/SDL2.dll $<TARGET_FILE_DIR:HatchitTest>)
add_custom_command(TARGET HatchitTest POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                   $(SolutionDir)../dependencies/assimp/bin/Release/assimp.dll $<TARGET_FILE_DIR:HatchitTest>)    

              


target_link_libraries(HatchitTest HatchitCore HatchitResource HatchitGame assimp SDL2)