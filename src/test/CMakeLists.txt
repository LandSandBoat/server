# Catch2 hosts the C++ unit tests that run during xi_test startup, before the
# Lua test engine boots (see main.cpp).
suspend_clang_tidy()
CPMAddPackage(
    NAME Catch2
    GITHUB_REPOSITORY catchorg/Catch2
    GIT_TAG v3.7.1
    SYSTEM ON
    OPTIONS
        "CATCH_INSTALL_DOCS OFF"
        "CATCH_INSTALL_EXTRAS OFF"
) # defines: Catch2::Catch2
resume_clang_tidy()

set(SOURCES
    enums/test_status.h
    enums/tick_type.h
    tests/rng_spread_tests.cpp
    tests/utils/saturated_engine.h
    in_memory_sink.h
    mock_manager.cpp
    mock_manager.h
    mock_socket.h
    test_application.h
    test_application.cpp
    test_case.h
    test_case.cpp
    test_char.h
    test_char.cpp
    test_collector.h
    test_collector.cpp
    test_engine.h
    test_engine.cpp
    test_lua_environment.h
    test_lua_environment.cpp
    test_matcher.h
    test_matcher.cpp
    test_suite.h
    test_suite.cpp
)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Apple")
    set_source_files_properties(
        tests/rng_spread_tests.cpp
        PROPERTIES
            COMPILE_OPTIONS "-fconstexpr-steps=2097152"
    )
endif()

# Catch2 test TUs live in the executable, the only target that links Catch2.
xi_add_executable(xi_test testserver.rc
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/bitset_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/data_binding_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/ecosystems_tree_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/experience_dataset_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/merits_dataset_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/skills_dataset_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/weapon_skills_dataset_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/zones/mobs_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/zones/npcs_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/zones/regions_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/data/zones/settings_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/entity_list_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/fishing_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/item_container_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/rng_runtime_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/pathfind_region_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/roam_region_tests.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tests/transport_voyage_tests.cpp
)
add_dependencies(xi_test data_schema_generate)

xi_add_library(xi_test_lib OBJECT ${SOURCES})
add_subdirectory(lua)
add_subdirectory(reporters)
target_include_directories(xi_test_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(xi_test_lib
    PUBLIC
        xi_connect_lib
        xi_map_core
        xi_world_lib
        xi_ext_test
)

target_link_libraries(xi_test PRIVATE xi_test_lib Catch2::Catch2)
xi_precompile_headers(xi_test)

if(TRACY_ENABLE)
    set_target_properties(xi_test PROPERTIES OUTPUT_NAME xi_test_tracy)
endif()

# `ctest` runs the copy staged in the repo root, from the repo root, as CI does. It needs the
# database set up first (tools/dbtool.py update). Catch2's tests run inside it at startup.
add_test(NAME xi_test
    COMMAND ${CMAKE_SOURCE_DIR}/$<TARGET_FILE_NAME:xi_test> --keep-going
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
set_tests_properties(xi_test PROPERTIES LABELS "needs-db")
