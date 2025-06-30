if (LUAROCKS_FOUND)
    set(SOURCES
        ${COMMON_SOURCES}
        lua/lua_sim_client.cpp
        lua/lua_sim_client.h
        lua/lua_simulation.cpp
        lua/lua_simulation.h
        in_memory_sink.h
        test_char.cpp
        test_char.h
        test_runner.cpp
        test_runner.h
        main.cpp
    )

    # List of Lua modules to fetch with luarocks
    set(LUA_ROCKS
        "https://luarocks.org/manifests/lunarmodules/busted-scm-1.rockspec"
    )

    if (UNIX)
        set(resource "")
    else ()
        set(resource "${CMAKE_SOURCE_DIR}/res/testserver.rc")
    endif ()

    get_filename_component(LuaJIT_LIBRARY_DIR ${LuaJIT_LIBRARY} DIRECTORY)
    get_filename_component(LuaJIT_LIBRARY_NAME ${LuaJIT_LIBRARY} NAME)
    message(STATUS "LuaJIT_LIBRARY_DIR: ${LuaJIT_LIBRARY_DIR}")
    message(STATUS "LuaJIT_LIBRARY_NAME: ${LuaJIT_LIBRARY_NAME}")

    set(LUAROCKS_CMD
        "${LUAROCKS_EXECUTABLE}"
        "LUA_INCDIR=${LuaJIT_INCLUDE_DIR}"
        "LUA_LIBDIR=${LuaJIT_LIBRARY_DIR}"
        "LUALIB=${LuaJIT_LIBRARY_NAME}"
        "--lua-version" "5.1"
        "--local"
        "install" ${LUA_ROCKS}
    )

    message(STATUS "Executing: ${LUAROCKS_CMD}")

    execute_process(
            COMMAND ${LUAROCKS_CMD}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
            RESULT_VARIABLE LUAROCKS_RUN
    )

    execute_process(
            COMMAND "${LUAROCKS_EXECUTABLE}"
            "--local" "path" "--append" "--lr-path"
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
            OUTPUT_VARIABLE LUAROCKS_PATH
            OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    execute_process(
            COMMAND "${LUAROCKS_EXECUTABLE}"
            "--local" "path" "--append" "--lr-cpath"
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
            OUTPUT_VARIABLE LUAROCKS_CPATH
            OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if (NOT LUAROCKS_RUN EQUAL 0)
        message(FATAL_ERROR "LuaRocks command failed with code ${LUAROCKS_RUN}")
    endif ()

    add_executable(xi_test
            ${SOURCES}
            ${resource})

    target_link_libraries(xi_test
        PUBLIC
        xi_connect_lib
        xi_map_lib
        xi_world_lib
        ${SHARED_EXTERNAL_LIBS}
        ${TEST_ONLY_EXTERNAL_LIBS}
        project_options
        PRIVATE
        project_warnings
    )

    target_include_directories(xi_test
        PUBLIC
        ${CMAKE_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/../map
    )

    cmake_path(NORMAL_PATH LUAROCKS_PATH)
    cmake_path(NORMAL_PATH LUAROCKS_CPATH)

    string(REPLACE ";" "\\;" LUAROCKS_PATH "${LUAROCKS_PATH}")
    string(REPLACE ";" "\\;" LUAROCKS_CPATH "${LUAROCKS_CPATH}")

    target_compile_definitions(xi_test
            PRIVATE "LR_CPATH=\"${LUAROCKS_CPATH}\""
            PRIVATE "LR_PATH=\"${LUAROCKS_PATH}\""
    )

    if (APPLE)
        disable_lto(xi_test)
    endif ()

    set_target_output_directory(xi_test)
endif()
