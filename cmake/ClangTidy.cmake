#
# Enable these jobs on command-line with 'cmake -DENABLE_CLANG_TIDY=ON ..'
#

if(ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY_COMMAND NAMES clang-tidy)

    if(NOT CLANG_TIDY_COMMAND)
        message(FATAL_ERROR "ENABLE_CLANG_TIDY is ON but clang-tidy is not found!")
    else()
        set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_COMMAND};-header-filter='(${CMAKE_SOURCE_DIR}/src/.*|${CMAKE_SOURCE_DIR}/ext/.*|${CMAKE_BINARY_DIR}/.*)';-format-style='file'")

        if(ENABLE_CLANG_TIDY_AUTO_FIX)
            set(CMAKE_CXX_CLANG_TIDY "${CMAKE_CXX_CLANG_TIDY};-fix")
        endif()
    endif()
endif(ENABLE_CLANG_TIDY)
