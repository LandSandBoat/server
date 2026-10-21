# Build `clang_format` to format the sources in place, or `clang_format_check` to only report.
# Both run tools/run_clang_format.py, which looks for clang-format 22.

add_custom_target(clang_format
    COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/run_clang_format.py
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    USES_TERMINAL
    VERBATIM
)

add_custom_target(clang_format_check
    COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/run_clang_format.py --check
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    USES_TERMINAL
    VERBATIM
)
