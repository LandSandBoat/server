# Generated sources: version.cpp, the IPC stubs, and the enum/data codegen under build/generated.

configure_file(${CMAKE_SOURCE_DIR}/src/common/version.cpp.in
               ${CMAKE_BINARY_DIR}/generated/version.cpp)

set_property(
    DIRECTORY
    APPEND
    PROPERTY CMAKE_CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py
)
message(STATUS "Generating IPC stubs")
execute_process(
    COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    RESULT_VARIABLE ipc_exit_code
)
if(NOT ipc_exit_code EQUAL 0)
    message(FATAL_ERROR "Failed to generate IPC stubs")
endif()

execute_process(
    COMMAND ${Python_EXECUTABLE} -c "import jinja2, jsonschema; from ruamel.yaml import YAML"
    RESULT_VARIABLE codegen_deps_exit_code
    OUTPUT_QUIET
    ERROR_QUIET
)
if(NOT codegen_deps_exit_code EQUAL 0)
    message(FATAL_ERROR
        "Codegen requires the Python packages jinja2, jsonschema, and ruamel.yaml, "
        "but they are not installed for the interpreter CMake selected:\n"
        "    ${Python_EXECUTABLE}\n"
        "Install them by running this command exactly as shown (the interpreter path "
        "matters, so the packages land in the environment this build uses):\n"
        "    ${Python_EXECUTABLE} -m pip install -r ${CMAKE_SOURCE_DIR}/tools/requirements.txt\n"
        "If pip refuses with \"externally-managed-environment\" (Homebrew and most Linux distro "
        "Pythons), either add --user --break-system-packages to that command, or build inside a "
        "virtualenv:\n"
        "    ${Python_EXECUTABLE} -m venv .venv && ./.venv/bin/pip install -r ${CMAKE_SOURCE_DIR}/tools/requirements.txt\n"
        "then reconfigure with -DPython_EXECUTABLE=${CMAKE_SOURCE_DIR}/.venv/bin/python"
    )
endif()

# The generated headers must exist before the first configure finishes, so bootstrap once.
set(ENUM_CODEGEN_STAMP ${CMAKE_BINARY_DIR}/generated/.enum_codegen.stamp)
if(NOT EXISTS ${ENUM_CODEGEN_STAMP})
    message(STATUS "Bootstrapping enum codegen")
    execute_process(
        COMMAND ${Python_EXECUTABLE} -m tools.codegen ${CMAKE_BINARY_DIR}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE codegen_exit_code
    )
    if(NOT codegen_exit_code EQUAL 0)
        message(FATAL_ERROR "Enum codegen failed")
    endif()
endif()

add_custom_target(enum_codegen
    COMMAND ${Python_EXECUTABLE} -m tools.codegen ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    BYPRODUCTS ${ENUM_CODEGEN_STAMP}
    USES_TERMINAL
    VERBATIM
)
