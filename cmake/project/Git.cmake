find_package(Git)
include(project/GitInfo)

# Configure-time copy, for the messages below and any CMake code that reads GIT_SHA1 and friends.
# The binaries take theirs from the xi_version target instead, which re-reads git every build.
xi_read_git_info("${CMAKE_SOURCE_DIR}")

message(STATUS "GIT_SHA1: ${GIT_SHA1}")
message(STATUS "GIT_BRANCH: ${GIT_BRANCH}")
message(STATUS "GIT_DATE: ${GIT_DATE}")
message(STATUS "GIT_COMMIT_SUBJECT: ${GIT_COMMIT_SUBJECT}")
