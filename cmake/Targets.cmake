#
# Centralized target definitions and properties
#
# This file contains all add_executable() and add_library() calls
# along with target-specific properties and configurations.
#

function(create_connect_library)
    add_library(xi_connect_lib STATIC ${LOGIN_SOURCES})

    configure_compiler_flags(xi_connect_lib)
    configure_linker_flags(xi_connect_lib)
    configure_compiler_definitions(xi_connect_lib)

    target_link_libraries(xi_connect_lib PUBLIC
        ${SHARED_EXTERNAL_LIBS}
        ${CONNECT_ONLY_EXTERNAL_LIBS}
    )

    target_include_directories(xi_connect_lib PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_SOURCE_DIR}/src/login
    )

    # Configure PCH (conditional on Windows without caching)
    configure_pch(xi_connect_lib)

    set_target_output_directory(xi_connect_lib)
endfunction()

function(create_connect_executable)
    add_executable(xi_connect ${LOGIN_APP_SOURCES})

    configure_compiler_flags(xi_connect)
    configure_linker_flags(xi_connect)
    configure_compiler_definitions(xi_connect)

    target_link_libraries(xi_connect PUBLIC
        xi_connect_lib
    )

    set_target_output_directory(xi_connect)
endfunction()

function(create_map_library)
    add_library(xi_map_lib STATIC ${MAP_LIB_SOURCES})

    process_modules()

    configure_compiler_flags(xi_map_lib)
    configure_linker_flags(xi_map_lib)
    configure_compiler_definitions(xi_map_lib)

    target_link_libraries(xi_map_lib PUBLIC
        ${SHARED_EXTERNAL_LIBS}
        ${MAP_ONLY_EXTERNAL_LIBS}
    )

    target_include_directories(xi_map_lib PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_SOURCE_DIR}/src/map
    )

    if(module_include_dirs)
        target_include_directories(xi_map_lib PUBLIC ${module_include_dirs})
    endif()

    # Configure PCH (conditional on Windows without caching)
    configure_pch(xi_map_lib)

    include_module_cmakelists("${cmakelist_include_paths}")
endfunction()

function(create_map_executable)
    if(ENABLE_TRACY)
        set(MAP_TARGET_NAME xi_map_tracy)
    else()
        set(MAP_TARGET_NAME xi_map)
    endif()

    add_executable(${MAP_TARGET_NAME} ${MAP_APP_SOURCES})

    configure_compiler_flags(${MAP_TARGET_NAME})
    configure_linker_flags(${MAP_TARGET_NAME})
    configure_compiler_definitions(${MAP_TARGET_NAME})

    target_link_libraries(${MAP_TARGET_NAME} PRIVATE
        xi_map_lib
    )

    if(ENABLE_TRACY)
        target_link_libraries(${MAP_TARGET_NAME} PRIVATE TracyClient)
        message(STATUS "ENABLE_TRACY: xi_map will be output as xi_map_tracy")
    endif()

    set_target_output_directory(${MAP_TARGET_NAME})
endfunction()

function(create_search_library)
    add_library(xi_search_lib STATIC ${SEARCH_LIB_SOURCES})

    configure_compiler_flags(xi_search_lib)
    configure_linker_flags(xi_search_lib)
    configure_compiler_definitions(xi_search_lib)

    target_link_libraries(xi_search_lib PUBLIC
        ${SHARED_EXTERNAL_LIBS}
        ${SEARCH_ONLY_EXTERNAL_LIBS}
    )

    target_include_directories(xi_search_lib PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_SOURCE_DIR}/src/search
    )

    # Configure PCH (conditional on Windows without caching)
    configure_pch(xi_search_lib)
endfunction()

function(create_search_executable)
    add_executable(xi_search ${SEARCH_APP_SOURCES})

    configure_compiler_flags(xi_search)
    configure_linker_flags(xi_search)
    configure_compiler_definitions(xi_search)

    target_link_libraries(xi_search PUBLIC
        xi_search_lib
    )

    set_target_output_directory(xi_search)
endfunction()

# Create xi_world_lib library (world server functionality)
function(create_world_library)
    add_library(xi_world_lib STATIC ${WORLD_LIB_SOURCES})

    configure_compiler_flags(xi_world_lib)
    configure_linker_flags(xi_world_lib)
    configure_compiler_definitions(xi_world_lib)

    target_link_libraries(xi_world_lib PUBLIC
        ${SHARED_EXTERNAL_LIBS}
        ${WORLD_ONLY_EXTERNAL_LIBS}
    )

    target_include_directories(xi_world_lib PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_SOURCE_DIR}/src/world
    )

    # Configure PCH (conditional on Windows without caching)
    configure_pch(xi_world_lib)
endfunction()

function(create_world_executable)
    add_executable(xi_world ${WORLD_APP_SOURCES})

    configure_compiler_flags(xi_world)
    configure_linker_flags(xi_world)
    configure_compiler_definitions(xi_world)

    target_link_libraries(xi_world PUBLIC
        xi_world_lib
    )

    set_target_output_directory(xi_world)
endfunction()

function(create_test_library)
    add_library(xi_test_lib STATIC ${TEST_SOURCES})

    configure_compiler_flags(xi_test_lib)
    configure_linker_flags(xi_test_lib)
    configure_compiler_definitions(xi_test_lib)

    target_link_libraries(xi_test_lib PUBLIC
        ${TEST_ONLY_EXTERNAL_LIBS}
        xi_connect_lib
        xi_map_lib
        xi_world_lib
    )

    target_include_directories(xi_test_lib PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_SOURCE_DIR}/src/test
    )

    # Configure PCH (conditional on Windows without caching)
    configure_pch(xi_test_lib)
endfunction()

function(create_test_executable)
    if(ENABLE_TRACY)
        set(TEST_TARGET_NAME xi_test_tracy)
    else()
        set(TEST_TARGET_NAME xi_test)
    endif()

    add_executable(${TEST_TARGET_NAME} ${TEST_APP_SOURCES})

    configure_compiler_flags(${TEST_TARGET_NAME})
    configure_linker_flags(${TEST_TARGET_NAME})
    configure_compiler_definitions(${TEST_TARGET_NAME})

    target_link_libraries(${TEST_TARGET_NAME} PRIVATE
        xi_test_lib
    )

    if(ENABLE_TRACY)
        target_link_libraries(${TEST_TARGET_NAME} PRIVATE TracyClient)
        message(STATUS "ENABLE_TRACY: xi_test will be output as xi_test_tracy")
    endif()

    set_target_output_directory(${TEST_TARGET_NAME})
endfunction()

function(create_all_targets)
    create_connect_library()
    create_connect_executable()

    create_map_library()
    create_map_executable()

    create_search_library()
    create_search_executable()

    create_world_library()
    create_world_executable()

    create_test_library()
    create_test_executable()
endfunction()
