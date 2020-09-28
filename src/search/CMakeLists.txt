set(SOURCES
    data_loader.cpp
    data_loader.h
    search.cpp
    search.h
    tcp_request.cpp
    tcp_request.h)

add_subdirectory(packets)

add_executable(topaz_search
    ${SOURCES}
    $<TARGET_OBJECTS:search_packets>)

target_compile_definitions(topaz_search PUBLIC DEFINE_OWN_MAIN)

target_link_libraries(topaz_search
    common
    project_options
    #project_warnings
)
