set(SOURCES
    blowfish.cpp
    blowfish.h
    cbasetypes.h
    debug.h
    $<$<PLATFORM_ID:Windows>:debug_windows.cpp>
    $<$<PLATFORM_ID:Darwin>:debug_osx.cpp>
    $<$<PLATFORM_ID:Linux>:debug_linux.cpp>
    filewatcher.cpp
    filewatcher.h
    kernel.cpp
    kernel.h
    logging.cpp
    logging.h
    md52.cpp
    md52.h
    mmo.h
    socket.cpp
    socket.h
    sql.cpp
    sql.h
    string.h
    taskmgr.cpp
    taskmgr.h
    timer.cpp
    timer.h
    xirand.h
    utils.cpp
    utils.h
    version.cpp # auto-generated
    version.h
    zlib.cpp
    zlib.h)

add_library(common STATIC ${SOURCES})

target_link_libraries(common
    PUBLIC
    mariadbclient
    spdlog_header_only
    sol2_single
    efsw
    concurrentqueue
    project_options
    #PRIVATE
    #project_warnings
)
 
if(TRACY_ENABLE)
    target_link_libraries(common PUBLIC tracy_client)
endif(TRACY_ENABLE)
