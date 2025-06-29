if (WIN32)
    # This is unset in another part of the project but we need it temporarily.
    set(CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH ON)
    find_program(LUAROCKS_EXECUTABLE luarocks)
    set(CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH OFF)
else()
    find_program(LUAROCKS_EXECUTABLE luarocks)
endif ()

if (LUAROCKS_EXECUTABLE)
    set(LUAROCKS_FOUND TRUE)
else()
    set(LUAROCKS_FOUND FALSE)
endif()

message(STATUS "LUAROCKS_FOUND: ${LUAROCKS_FOUND}")
message(STATUS "LUAROCKS_EXECUTABLE: ${LUAROCKS_EXECUTABLE}")
