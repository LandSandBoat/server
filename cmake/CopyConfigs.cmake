set(CONFIG_FILES
    license.conf
    login.conf
    maint.conf
    map.conf
    packet_tcp.conf
    packet_udp.conf
    search_server.conf
    server_message.conf
    version.conf
)

foreach(file ${CONFIG_FILES})
    if (NOT EXISTS "${CMAKE_SOURCE_DIR}/conf/${file}")
        set(copied_configs TRUE)
        message(STATUS "Copying config file: ${CMAKE_SOURCE_DIR}/conf/default/${file} -> ${CMAKE_SOURCE_DIR}/conf/${file}")
        file(COPY ${CMAKE_SOURCE_DIR}/conf/default/${file} DESTINATION ${CMAKE_SOURCE_DIR}/conf)
    endif()
endforeach()

if (${copied_configs})
    message(STATUS "Populated config files, don't forget to change the default values!")
endif()
