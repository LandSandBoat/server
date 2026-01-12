add_executable(announce announce.cpp)

set_target_properties(announce PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/tools
)

target_include_directories(announce PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/src/map
    ${CMAKE_BINARY_DIR}/generated
    ${ZeroMQ_INCLUDE_DIRS}
)

target_link_libraries(announce
    PRIVATE
        project_options
        project_warnings
        xi_world_lib
        ${ZeroMQ_LIBRARIES}
)
