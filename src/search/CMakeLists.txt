add_subdirectory(packets)

set(SOURCES
    ${COMMON_SOURCES}
    ${PACKET_SOURCES}
    data_loader.cpp
    data_loader.h
    search.cpp
    search.h
    tcp_request.cpp
    tcp_request.h)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/searchserver.rc")
endif()

add_executable(topaz_search
    ${SOURCES}
    ${resource})

if(WIN32)
    set_target_properties(topaz_search PROPERTIES OUTPUT_NAME topaz_search${spacer}${platform_suffix})
endif()

target_compile_definitions(
    topaz_search
    PUBLIC
    -DDEBUGLOGSEARCH
)

target_compile_definitions(topaz_search PUBLIC DEFINE_OWN_MAIN)

target_link_libraries(topaz_search
    PUBLIC
        ${EXTERNAL_LIBS}
        project_options
    PRIVATE
        project_warnings
)

target_include_directories(topaz_search
    PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
)

set_target_output_directory(topaz_search)
