add_subdirectory(common)
add_subdirectory(login)
add_subdirectory(map)
add_subdirectory(search)

if(BUILD_WORLD)
    add_subdirectory(world)
endif(BUILD_WORLD)
