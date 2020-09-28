file(GLOB GENERATED_SOURCES CONFIGURE_DEPENDS *.cpp)

if(UNIX)
    set(resource "")
else()
    set(resource "../../win32/vcxproj/searchserver.rc")
endif()

add_subdirectory(packets)

add_executable(topaz_search
    $<TARGET_OBJECTS:search_packets>
    ${GENERATED_SOURCES}
    #${resource}
)

set_target_properties(topaz_search PROPERTIES OUTPUT_NAME topaz_search${spacer}${platform_suffix})

target_compile_definitions(topaz_search PUBLIC DEFINE_OWN_MAIN)

target_include_directories(topaz_search PRIVATE
    ${MYSQLCLIENT_INCLUDE_DIRS}
)

target_link_libraries(topaz_search
    ${MYSQLCLIENT_LIBRARIES}
    ${ZMQ_LIBRARIES}
    ${CMAKE_THREAD_LIBS_INIT}
    common
    project_options
)
