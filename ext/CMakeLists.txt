add_subdirectory(detour)
add_subdirectory(fmt)
# add_subdirectory(luajit) # Handled globally
add_subdirectory(lunar)
# add_subdirectory(mysql) # Handled globally
add_subdirectory(recast)
# add_subdirectory(zmq) # Handled globally

set(EXTERNAL_LIBS
    detour
    fmt
    lunar
    recast
)

# TODO: Don't link everything globally
link_libraries(${EXTERNAL_LIBS})
