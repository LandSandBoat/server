#
# Git repo information
#
# This module extracts git commit information for build versioning
# for embedding into the compiled binaries and general logging.
#

find_package(Git)

execute_process(COMMAND
    "${GIT_EXECUTABLE}" describe --match=NeVeRmAtCh --always --dirty
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    OUTPUT_VARIABLE GIT_SHA1
    ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND
    "${GIT_EXECUTABLE}" rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    OUTPUT_VARIABLE GIT_BRANCH
    ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND
    "${GIT_EXECUTABLE}" log -1 --format=%ad --date=local
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    OUTPUT_VARIABLE GIT_DATE
    ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(COMMAND
    "${GIT_EXECUTABLE}" log -1 --format=%s
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    OUTPUT_VARIABLE GIT_COMMIT_SUBJECT
    ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)

if(GIT_COMMIT_SUBJECT)
    string(REGEX REPLACE "\"" "'" GIT_COMMIT_SUBJECT ${GIT_COMMIT_SUBJECT})
endif()

# TODO: Publish this information to PARENT_SCOPE or turn into a function that returns it
function(report_git_information)
    message(STATUS "")
    message(STATUS "=== Git Information ===")
    message(STATUS "")
    message(STATUS "  GIT_SHA1:             ${GIT_SHA1}")
    message(STATUS "  GIT_BRANCH:           ${GIT_BRANCH}")
    message(STATUS "  GIT_DATE:             ${GIT_DATE}")
    message(STATUS "  GIT_COMMIT_SUBJECT:   ${GIT_COMMIT_SUBJECT}")
endfunction()
