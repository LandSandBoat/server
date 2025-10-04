#
# Report.cmake
#
# Comprehensive build configuration reporting
# Provides organized output of all build settings, compiler info, and dependencies
#

# Main function to generate complete build configuration report
function(generate_build_report)
    report_build_environment()
    report_build_options()
    report_compiler_configuration()
    report_compiler_flags()
    report_git_information()
    message(STATUS "")
endfunction()

# Build Environment Section
function(report_build_environment)
    message(STATUS "=== Build Environment ===")
    message(STATUS "")
    message(STATUS "  CMake Version:        ${CMAKE_VERSION}")
    message(STATUS "  System:               ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_VERSION}")
    message(STATUS "  Processor:            ${CMAKE_SYSTEM_PROCESSOR} (${PLATFORM_ARCH})")
    message(STATUS "  Generator:            ${CMAKE_GENERATOR}")
    message(STATUS "  Build Type:           ${CMAKE_BUILD_TYPE}")
    message(STATUS "  Source Directory:     ${CMAKE_SOURCE_DIR}")
    message(STATUS "  Binary Directory:     ${CMAKE_BINARY_DIR}")

    if(CACHE_BINARY)
        get_filename_component(CACHE_NAME "${CACHE_BINARY}" NAME)
        message(STATUS "  Build Cache:          ${CACHE_NAME}")
        message(STATUS "  Cache Directory:      ${CACHE_DIR}")
    else()
        message(STATUS "  Build Cache:          None")
    endif()
endfunction()

# Build Options Section
function(report_build_options)
    message(STATUS "")
    message(STATUS "=== Build Options ===")
    message(STATUS "")

    if(WARNINGS_AS_ERRORS)
        message(STATUS "  Warnings as Errors:   ${WARNINGS_AS_ERRORS}")
    endif()

    message(STATUS "  Fast Math:            ${ENABLE_FAST_MATH}")
    message(STATUS "  LTO:                  ${ENABLE_LTO}")
    message(STATUS "  Security Hardening:   ${ENABLE_SECURITY_HARDENING}")
    message(STATUS "  Tracy Profiling:      ${ENABLE_TRACY}")
    message(STATUS "  Clang-Tidy:           ${ENABLE_CLANG_TIDY}")
    message(STATUS "  Clang-Tidy Auto-Fix:  ${ENABLE_CLANG_TIDY_AUTO_FIX}")
    message(STATUS "  Valgrind:             ${ENABLE_VALGRIND}")
endfunction()

# Compiler Configuration Section
function(report_compiler_configuration)
    message(STATUS "")
    message(STATUS "=== Compiler Configuration ===")
    message(STATUS "")
    message(STATUS "  Compiler ID:          ${CMAKE_CXX_COMPILER_ID}")
    message(STATUS "  Compiler Version:     ${CMAKE_CXX_COMPILER_VERSION}")
    message(STATUS "  C++ Standard:         C++${CMAKE_CXX_STANDARD}")
    message(STATUS "  C Compiler:           ${CMAKE_C_COMPILER}")
    message(STATUS "  C++ Compiler:         ${CMAKE_CXX_COMPILER}")

    if(CMAKE_LINKER)
        message(STATUS "  Linker:               ${CMAKE_LINKER}")
    else()
        message(STATUS "  Linker:               Default (${CMAKE_CXX_COMPILER_ID})")
    endif()
endfunction()

# Compiler Flags Section
function(report_compiler_flags)
    message(STATUS "")
    message(STATUS "=== Compiler Flags ===")
    message(STATUS "")

    string(TOUPPER "${CMAKE_BUILD_TYPE}" CMAKE_BUILD_TYPE_UPPER)

    # Get compile options added via add_compile_options()
    get_directory_property(COMPILE_OPTIONS COMPILE_OPTIONS)
    string(REPLACE ";" " " COMPILE_OPTIONS_STR "${COMPILE_OPTIONS}")

    message(STATUS "  Base C Flags:         ${CMAKE_C_FLAGS}")
    message(STATUS "  Base C++ Flags:       ${CMAKE_CXX_FLAGS}")

    if(COMPILE_OPTIONS)
        message(STATUS "  Global Options:       ${COMPILE_OPTIONS_STR}")
    endif()

    if("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "DEBUG")
        message(STATUS "  Build Type Flags:     ${CMAKE_CXX_FLAGS_DEBUG}")
    elseif("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "FASTDEBUG")
        message(STATUS "  Build Type Flags:     ${CMAKE_CXX_FLAGS_FASTDEBUG}")
    elseif("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "MINSIZEREL")
        message(STATUS "  Build Type Flags:     ${CMAKE_CXX_FLAGS_MINSIZEREL}")
    elseif("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "RELEASE")
        message(STATUS "  Build Type Flags:     ${CMAKE_CXX_FLAGS_RELEASE}")
    elseif("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "RELWITHDEBINFO")
        message(STATUS "  Build Type Flags:     ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
    else()
        message(FATAL_ERROR "Did not recognise CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} to print out compiler flags.")
    endif()

    message(STATUS "  Linker Flags:         ${CMAKE_EXE_LINKER_FLAGS}")
endfunction()

function(report_xi_map_target_flags)
    message(STATUS "")
    message(STATUS "=== xi_map Target Flags ===")
    message(STATUS "")

    if(TARGET xi_map)
        get_target_property(COMPILE_OPTIONS xi_map COMPILE_OPTIONS)
        get_target_property(COMPILE_DEFINITIONS xi_map COMPILE_DEFINITIONS)
        get_target_property(LINK_OPTIONS xi_map LINK_OPTIONS)

        if(COMPILE_OPTIONS)
            string(REPLACE ";" " " COMPILE_OPTIONS_STR "${COMPILE_OPTIONS}")
            message(STATUS "  Compile Options:      ${COMPILE_OPTIONS_STR}")
        else()
            message(STATUS "  Compile Options:      (none)")
        endif()

        if(COMPILE_DEFINITIONS)
            string(REPLACE ";" " " COMPILE_DEFINITIONS_STR "${COMPILE_DEFINITIONS}")
            message(STATUS "  Compile Definitions:  ${COMPILE_DEFINITIONS_STR}")
        else()
            message(STATUS "  Compile Definitions:  (none)")
        endif()

        if(LINK_OPTIONS)
            string(REPLACE ";" " " LINK_OPTIONS_STR "${LINK_OPTIONS}")
            message(STATUS "  Link Options:         ${LINK_OPTIONS_STR}")
        else()
            message(STATUS "  Link Options:         (none)")
        endif()
    else()
        message(STATUS "  Target xi_map not yet created")
    endif()
endfunction()

# Configuration Complete Section
function(report_configuration_complete)
    message(STATUS "")
    message(STATUS "=== Configuration Complete ===")
    message(STATUS "")
    message(STATUS "  Build files written to: ${CMAKE_BINARY_DIR}")
    message(STATUS "  Ready to build with: cmake --build ${CMAKE_BINARY_DIR} --parallel")
    message(STATUS "")

    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        message(STATUS "  This is a !!! Debug !!! build: Fastest recompile time and maximum debug info.")
    elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
        message(STATUS "  This is a !!! Release !!! build: Maximum optimization and some debug info.")
    endif()

    message(STATUS "")
endfunction()

# System Dependencies Section (wrapper for Dependencies.cmake)
function(report_system_dependencies)
    message(STATUS "")
    message(STATUS "=== System Dependencies ===")
    message(STATUS "")
    find_python()
    configure_tracy()
    find_system_dependencies()

    # Export Python_EXECUTABLE to parent scope
    set(Python_EXECUTABLE ${Python_EXECUTABLE} PARENT_SCOPE)
endfunction()

# External Packages Section (wrapper for Dependencies.cmake)
function(report_external_packages)
    message(STATUS "")
    message(STATUS "=== External Packages (CPM) ===")
    message(STATUS "")
    message(STATUS "  CPM Cache Directory:  ${CPM_SOURCE_CACHE}")
    message(STATUS "")
    message(STATUS "Configuring CPM packages...")
    message(STATUS "")

    configure_cpm_dependencies()

    message(STATUS "")
    configure_local_external_libs()
    define_dependency_groups()

    # Export Python_EXECUTABLE to parent scope
    set(Python_EXECUTABLE ${Python_EXECUTABLE} PARENT_SCOPE)

    # Export dependency group variables to parent scope
    set(SHARED_EXTERNAL_LIBS ${SHARED_EXTERNAL_LIBS} PARENT_SCOPE)
    set(CONNECT_ONLY_EXTERNAL_LIBS ${CONNECT_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(MAP_ONLY_EXTERNAL_LIBS ${MAP_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(SEARCH_ONLY_EXTERNAL_LIBS ${SEARCH_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(WORLD_ONLY_EXTERNAL_LIBS ${WORLD_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(TEST_ONLY_EXTERNAL_LIBS ${TEST_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
endfunction()

# Code Generation Section (wrapper for CodeGeneration.cmake)
function(report_code_generation)
    run_code_generation()
endfunction()

# Module Processing Section (wrapper for ModuleHandling.cmake)
function(report_module_processing)
    message(STATUS "")
    process_modules()
endfunction()

# Final Build Summary Section
function(report_final_summary)
    report_configuration_complete()
endfunction()