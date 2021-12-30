set(SOURCES
    data_loader.cpp
    data_loader.h
    search.cpp
    search.h
    tcp_request.cpp
    tcp_request.h)

add_subdirectory(packets)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/searchserver.rc")
endif()

add_executable(xi_search
    ${SOURCES}
    ${resource})

if(WIN32)
    set_target_properties(xi_search PROPERTIES OUTPUT_NAME xi_search)
endif()

target_compile_definitions(
    xi_search
    PUBLIC
    -DDEBUGLOGSEARCH
    -DDEFINE_OWN_MAIN
)

target_compile_definitions(xi_search PUBLIC DEFINE_OWN_MAIN)

target_link_libraries(xi_search
    PUBLIC
    common
    search_packets
    project_options
    PRIVATE
    project_warnings
)

set_target_output_directory(xi_search)
