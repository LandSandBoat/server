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

add_executable(ixion_search
    ${SOURCES}
    ${resource})

if(WIN32)
    set_target_properties(ixion_search PROPERTIES OUTPUT_NAME ixion_search${spacer}${platform_suffix})
endif()

target_compile_definitions(
    ixion_search
    PUBLIC
    -DDEBUGLOGSEARCH
    -DDEFINE_OWN_MAIN
)

target_compile_definitions(ixion_search PUBLIC DEFINE_OWN_MAIN)

target_link_libraries(ixion_search
    PUBLIC
    common
    search_packets
    project_options
    PRIVATE
    project_warnings
)

set_target_output_directory(ixion_search)
