add_subdirectory(packets)

set(SOURCES
    ${COMMON_SOURCES}
    ${PACKET_SOURCES}
    data_loader.cpp
    data_loader.h
    handler.h
    search_application.h
    search_application.cpp
    search_engine.h
    search_engine.cpp
    search_handler.h
    search_handler.cpp
)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/searchserver.rc")
endif()

add_executable(xi_search
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${resource})

set(SEARCH_LIB_SOURCES ${SOURCES})
add_library(xi_search_lib
    STATIC
        ${SEARCH_LIB_SOURCES})

if(WIN32)
    set_target_properties(xi_search PROPERTIES OUTPUT_NAME xi_search)
endif()

if (APPLE)
    disable_lto(xi_search)
endif()

target_link_libraries(xi_search_lib
    PUBLIC
        ${SHARED_EXTERNAL_LIBS}
        ${SEARCH_ONLY_EXTERNAL_LIBS}
        project_options
    PRIVATE
        project_warnings
)

target_include_directories(xi_search_lib
    PUBLIC
        ${CMAKE_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(xi_search
    PUBLIC
        xi_search_lib)

set_target_output_directory(xi_search)
