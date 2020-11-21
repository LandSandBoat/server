set(SOURCES
    blowfish.cpp
    blowfish.h
    cbasetypes.h
    kernel.cpp
    kernel.h
    md52.cpp
    md52.h
    mmo.h
    showmsg.cpp
    showmsg.h
    socket.cpp
    socket.h
    sql.cpp
    sql.h
    string.h
    taskmgr.cpp
    taskmgr.h
    timer.cpp
    timer.h
    tpzrand.h
    utils.cpp
    utils.h
    version.h
    zlib.cpp
    zlib.h
    zmq.hpp)

add_library(common STATIC ${SOURCES})

target_link_libraries(
    common
    PUBLIC
    fmt
    project_options
    # project_warnings
)
 
if(TRACY_ENABLE)
    target_link_libraries(common PUBLIC tracy_client)
endif(TRACY_ENABLE)
