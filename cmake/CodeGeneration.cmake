#
# Build-time code generation utilities
#

#
# Version File Generation (requires Git.cmake to be included beforehand)
#
function(configure_version_file)
    message(STATUS "Configuring src/common/version.cpp")
    configure_file(
        ${CMAKE_SOURCE_DIR}/src/common/version.cpp.in
        ${CMAKE_SOURCE_DIR}/src/common/version.cpp
    )
endfunction()

#
# IPC Stub Generation
#
function(generate_ipc_stubs)
    # Track the generation script for reconfiguration
    set_property(
        DIRECTORY
        APPEND
        PROPERTY CMAKE_CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py
    )

    message(STATUS "Generating IPC stubs")
    message(STATUS "Calling: ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py ${CMAKE_BINARY_DIR}")

    execute_process(
        COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py ${CMAKE_BINARY_DIR}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE IPC_EXIT_CODE
    )

    if(NOT IPC_EXIT_CODE EQUAL 0)
        message(FATAL_ERROR "Failed to generate IPC stubs")
    endif()

    # Globally include the generated directory
    include_directories(${CMAKE_BINARY_DIR}/generated)
endfunction()

function(run_python_codegen script_name output_description)
    set(SCRIPT_PATH "${CMAKE_SOURCE_DIR}/tools/${script_name}")

    if(NOT EXISTS ${SCRIPT_PATH})
        message(WARNING "Code generation script not found: ${SCRIPT_PATH}")
        return()
    endif()

    # Track the script for reconfiguration
    set_property(
        DIRECTORY
        APPEND
        PROPERTY CMAKE_CONFIGURE_DEPENDS ${SCRIPT_PATH}
    )

    message(STATUS "Running code generation: ${output_description}")
    message(STATUS "Calling: ${Python_EXECUTABLE} ${SCRIPT_PATH}")

    execute_process(
        COMMAND ${Python_EXECUTABLE} ${SCRIPT_PATH} ${CMAKE_BINARY_DIR}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE CODEGEN_EXIT_CODE
    )

    if(NOT CODEGEN_EXIT_CODE EQUAL 0)
        message(FATAL_ERROR "Failed to run ${script_name}: exit code ${CODEGEN_EXIT_CODE}")
    endif()
endfunction()

#
# CodeGen Entry Point
#
function(run_code_generation)
    message(STATUS "=== Code Generation ===")
    message(STATUS "")

    configure_version_file()
    generate_ipc_stubs()
endfunction()
