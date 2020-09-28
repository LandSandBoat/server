file(GLOB GENERATED_SOURCES CONFIGURE_DEPENDS *.cpp)

if(UNIX)
    set(resource "")
else()
    set(resource "../../win32/vcxproj/connectserver.rc")
endif()

add_executable(topaz_connect
    $<TARGET_OBJECTS:common>
    ${GENERATED_SOURCES}
    #${resource}
)

set_target_properties(topaz_connect PROPERTIES OUTPUT_NAME topaz_connect${spacer}${platform_suffix})

target_include_directories(topaz_connect PRIVATE
    ${MYSQLCLIENT_INCLUDE_DIRS}
)

target_link_libraries(topaz_connect
    ${MYSQLCLIENT_LIBRARIES}
    ${ZMQ_LIBRARIES}
    ${CMAKE_THREAD_LIBS_INIT}
    common
    project_options
)
