# Generated sources: version.cpp, the IPC stubs, and the enum/data codegen under build/generated.

# Written at configure time so a fresh tree has it, then refreshed by xi_version on every build so
# the binaries report the commit they were built from, not the one last configured.
set(XI_VERSION_CPP ${CMAKE_BINARY_DIR}/generated/version.cpp)
configure_file(${CMAKE_SOURCE_DIR}/src/common/version.cpp.in ${XI_VERSION_CPP} @ONLY)
add_custom_target(xi_version
    COMMAND ${CMAKE_COMMAND}
        -DGIT_EXECUTABLE=${GIT_EXECUTABLE}
        -DSOURCE_DIR=${CMAKE_SOURCE_DIR}
        -DINPUT=${CMAKE_SOURCE_DIR}/src/common/version.cpp.in
        -DOUTPUT=${XI_VERSION_CPP}
        -P ${CMAKE_CURRENT_LIST_DIR}/Version.cmake
    BYPRODUCTS ${XI_VERSION_CPP}
    COMMENT "Checking git version info"
    VERBATIM
)

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

# The same inputs tools/codegen/cli.py checks against its stamp. Per-zone data never holds an enum.
file(GLOB_RECURSE ENUM_CODEGEN_INPUTS CONFIGURE_DEPENDS
    ${CMAKE_SOURCE_DIR}/data/*.yaml
    ${CMAKE_SOURCE_DIR}/modules/*/data/*.yaml
    ${CMAKE_SOURCE_DIR}/tools/codegen/*.py
    ${CMAKE_SOURCE_DIR}/tools/codegen/templates/*.j2
)
list(FILTER ENUM_CODEGEN_INPUTS EXCLUDE REGEX "^${CMAKE_SOURCE_DIR}/data/zones/")

# The headers it writes depend on what the YAML declares, so the stamp stands in for them.
# Targets that include them depend on enum_codegen.
set(ENUM_CODEGEN_STAMP ${CMAKE_BINARY_DIR}/generated/.enum_codegen.stamp)
add_custom_command(
    OUTPUT ${ENUM_CODEGEN_STAMP}
    COMMAND ${Python_EXECUTABLE} -m tools.codegen ${CMAKE_BINARY_DIR}
    DEPENDS ${ENUM_CODEGEN_INPUTS}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Generating enums"
    USES_TERMINAL
    VERBATIM
)
add_custom_target(enum_codegen DEPENDS ${ENUM_CODEGEN_STAMP})
