add_library(recast INTERFACE)
target_link_libraries(recast INTERFACE no_warnings)
target_include_directories(recast SYSTEM INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
