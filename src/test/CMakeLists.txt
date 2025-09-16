add_subdirectory(lua)
add_subdirectory(reporters)

set(SOURCES
    ${COMMON_SOURCES}
    ${LUA_SOURCES}
    ${REPORTERS_SOURCES}
    enums/test_status.h
    enums/tick_type.h
    in_memory_sink.h
    mock_manager.cpp
    mock_manager.h
    test_application.h
    test_application.cpp
    test_case.h
    test_case.cpp
    test_char.h
    test_char.cpp
    test_collector.h
    test_collector.cpp
    test_engine.h
    test_engine.cpp
    test_lua_environment.h
    test_lua_environment.cpp
    test_matcher.h
    test_matcher.cpp
    test_suite.h
    test_suite.cpp
)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/testserver.rc")
endif()

add_executable(xi_test
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${resource})

set(TEST_LIB_SOURCES ${SOURCES})
add_library(xi_test_lib
    STATIC
        ${TEST_LIB_SOURCES})

if(WIN32)
    set_target_properties(xi_test PROPERTIES OUTPUT_NAME xi_test)
endif()

if (APPLE)
    disable_lto(xi_test)
endif()

target_link_libraries(xi_test_lib
    PUBLIC
        xi_connect_lib
        xi_map_lib
        xi_world_lib
        ${SHARED_EXTERNAL_LIBS}
        ${TEST_ONLY_EXTERNAL_LIBS}
        project_options
    PRIVATE
        project_warnings
)

target_include_directories(xi_test_lib
    PUBLIC
        ${CMAKE_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/../map
        ${CMAKE_CURRENT_SOURCE_DIR}/../world
)

target_link_libraries(xi_test
    PUBLIC
        xi_test_lib)

set_target_output_directory(xi_test)
