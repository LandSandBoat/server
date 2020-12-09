add_library(lunar INTERFACE)
target_link_libraries(lunar INTERFACE no_warnings)
target_include_directories(lunar INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
