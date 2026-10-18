# Writes version.cpp from git. Script mode, run by the xi_version target on every build:
#   cmake -DGIT_EXECUTABLE=<git> -DSOURCE_DIR=<repo> -DINPUT=<version.cpp.in> -DOUTPUT=<version.cpp> -P Version.cmake
# configure_file leaves OUTPUT untouched when nothing changed, so an unchanged commit recompiles nothing.

include(${CMAKE_CURRENT_LIST_DIR}/GitInfo.cmake)
xi_read_git_info("${SOURCE_DIR}")
configure_file("${INPUT}" "${OUTPUT}" @ONLY)
