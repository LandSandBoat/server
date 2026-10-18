# Enable these jobs on command-line with 'cmake -DENABLE_CLANG_TIDY=ON ..'

option(ENABLE_CLANG_TIDY "Run clang-tidy with the compiler." OFF)
option(ENABLE_CLANG_TIDY_AUTO_FIX "Allow clang-tidy to automatically apply fixes to problems." OFF)

message(STATUS "ENABLE_CLANG_TIDY: ${ENABLE_CLANG_TIDY}")
message(STATUS "ENABLE_CLANG_TIDY_AUTO_FIX: ${ENABLE_CLANG_TIDY_AUTO_FIX}")

if(ENABLE_CLANG_TIDY)
  set(PCH_ENABLE OFF)
  find_program(CLANG_TIDY_COMMAND NAMES clang-tidy)
  if(NOT CLANG_TIDY_COMMAND)
    message(WARNING "ENABLE_CLANG_TIDY is ON but clang-tidy is not found!")
    set(CMAKE_CXX_CLANG_TIDY "" CACHE STRING "" FORCE)
  else()
    set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_COMMAND};-header-filter='(${CMAKE_SOURCE_DIR}/src/.*|${CMAKE_SOURCE_DIR}/ext/.*|${CMAKE_BINARY_DIR}/.*)';-format-style='file'")
    if(ENABLE_CLANG_TIDY_AUTO_FIX)
      set(CMAKE_CXX_CLANG_TIDY "${CMAKE_CXX_CLANG_TIDY};-fix")
    endif()
  endif()
  message(STATUS "CMAKE_CXX_CLANG_TIDY: ${CMAKE_CXX_CLANG_TIDY}")
endif()

# Third-party code pulled in after this file is included inherits CMAKE_CXX_CLANG_TIDY, and
# clang-tidy then analyses it against the dependency's own .clang-tidy instead of ours.
# Bracket those CPMAddPackage/add_subdirectory calls with these.
macro(suspend_clang_tidy)
  set(SUSPENDED_CXX_CLANG_TIDY "${CMAKE_CXX_CLANG_TIDY}")
  unset(CMAKE_CXX_CLANG_TIDY)
endmacro()

macro(resume_clang_tidy)
  set(CMAKE_CXX_CLANG_TIDY "${SUSPENDED_CXX_CLANG_TIDY}")
  unset(SUSPENDED_CXX_CLANG_TIDY)
endmacro()
