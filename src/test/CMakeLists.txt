set(SOURCES
    ${COMMON_SOURCES}
    test_application.h
    test_application.cpp
    test_engine.h
    test_engine.cpp
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
)

target_link_libraries(xi_test
    PUBLIC
        xi_test_lib)

set_target_output_directory(xi_test)
