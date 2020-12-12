find_program(CLANG_FORMAT_BIN NAMES clang-format)

message(STATUS "CLANG_FORMAT_BIN: ${CLANG_FORMAT_BIN}")
add_custom_target(
        clang-format
        COMMAND ${CLANG_FORMAT_BIN}
        -style=file
        -i
        ${ALL_SOURCE_FILES}
)
