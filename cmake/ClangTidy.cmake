# Enable these jobs on command-line with 'cmake -DENABLE_CLANG_TIDY=ON ..'

option(ENABLE_CLANG_TIDY "Run clang-tidy with the compiler." OFF)
option(ENABLE_CLANG_TIDY_AUTO_FIX "Allow clang-tidy to automatically apply fixes to problems." OFF)

message(STATUS "ENABLE_CLANG_TIDY: ${ENABLE_CLANG_TIDY}")
message(STATUS "ENABLE_CLANG_TIDY_AUTO_FIX: ${ENABLE_CLANG_TIDY_AUTO_FIX}")

if(ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_COMMAND NAMES clang-tidy)
  if(NOT CLANG_TIDY_COMMAND)
    message(WARNING "CMake_RUN_CLANG_TIDY is ON but clang-tidy is not found!")
    set(CMAKE_CXX_CLANG_TIDY "" CACHE STRING "" FORCE)
  else()
    set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_COMMAND};-header-filter='(${CMAKE_SOURCE_DIR}/src/.*|${CMAKE_SOURCE_DIR}/ext/.*|${CMAKE_BINARY_DIR}/.*)';-format-style='file'")
    if(ENABLE_CLANG_TIDY_AUTO_FIX)
      set(CMAKE_CXX_CLANG_TIDY "${CMAKE_CXX_CLANG_TIDY};-fix")
    endif()
  endif()
  message(STATUS "CMAKE_CXX_CLANG_TIDY: ${CMAKE_CXX_CLANG_TIDY}")

  # Create a preprocessor definition that depends on .clang-tidy content so
  # the compile command will change when .clang-tidy changes.  This ensures
  # that a subsequent build re-runs clang-tidy on all sources even if they
  # do not otherwise need to be recompiled.  Nothing actually uses this
  # definition.  We add it to targets on which we run clang-tidy just to
  # get the build dependency on the .clang-tidy file.
  #file(SHA1 ${CMAKE_CURRENT_SOURCE_DIR}/.clang-tidy clang_tidy_sha1)
  #set(CLANG_TIDY_DEFINITIONS "CLANG_TIDY_SHA1=${clang_tidy_sha1}")
  #unset(clang_tidy_sha1)

endif(ENABLE_CLANG_TIDY)
