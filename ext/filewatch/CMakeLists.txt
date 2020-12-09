add_library(filewatch INTERFACE)
target_link_libraries(filewatch INTERFACE no_warnings)
target_include_directories(filewatch INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
