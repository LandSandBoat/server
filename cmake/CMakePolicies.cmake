#
# CMake policy configuration
#
# Must be included before project() call in CMakeLists.txt
#

# CMP0069: Enable Link Time Optimization (LTO) support
# https://cmake.org/cmake/help/latest/policy/CMP0069.html
cmake_policy(SET CMP0069 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0069 NEW)

# # CMP0091: MSVC runtime library flags selected by abstraction
# # https://cmake.org/cmake/help/latest/policy/CMP0091.html
# # Enables CMAKE_MSVC_RUNTIME_LIBRARY variable
# if(POLICY CMP0091)
# cmake_policy(SET CMP0091 NEW)
# set(CMAKE_POLICY_DEFAULT_CMP0091 NEW)
# endif()

# # CMP0141: MSVC debug information format specified by abstraction
# # https://cmake.org/cmake/help/latest/policy/CMP0141.html
# # Enables CMAKE_MSVC_DEBUG_INFORMATION_FORMAT variable
# if(POLICY CMP0141)
# cmake_policy(SET CMP0141 NEW)
# set(CMAKE_POLICY_DEFAULT_CMP0141 NEW)
# endif()
