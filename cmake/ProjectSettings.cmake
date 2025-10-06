#
# Core C++ Standard and Project Configuration
#
# This module handles basic C++ language standards, project settings,
# build type defaults, and configuration options.
#

include(CPM)
include(Git)
include(Python)
include(Platform)
include(CompilerMinimumVersions)
include(Tracy)
include(Files)
include(PCH)

include(CodeGeneration)
include(LinkerFlags)
include(ExeOutputDirectory)

# C++ Language Standard Configuration
# NOTE:
# We want to be using C++23, but we're being let down by the GitHub CI runners that we use
# and by MacOS's bundled AppleClang (which is often out of date).
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(LINKER_LANGUAGE CXX)

# Project Configuration
set(USE_FOLDERS ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# TODO: Do we want this ON by default?
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# External Library Configuration
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE) # Suppress warnings from external libs

# Set a default build type if none was specified
# Must be set BEFORE options that depend on CMAKE_BUILD_TYPE
if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'Debug' as none was specified.")
    set(CMAKE_BUILD_TYPE
        "Debug"
        CACHE STRING "Choose the type of build." FORCE)

    # Set the possible values of build type for cmake-gui, ccmake
    set_property(
        CACHE CMAKE_BUILD_TYPE
        PROPERTY STRINGS
        "Debug"
        "Release"
    )
endif()

# Project Options
option(ENABLE_FAST_MATH "Enable fast math optimizations" ON)
option(ENABLE_VALGRIND "Run the server with Valgrind." OFF)
option(ENABLE_CLANG_TIDY "Run clang-tidy with the compiler." OFF)
option(ENABLE_CLANG_TIDY_AUTO_FIX "Allow clang-tidy to automatically apply fixes to problems." OFF)
option(ENABLE_SECURITY_HARDENING "Enable security hardening flags" ON)
option(ENABLE_TRACY "Enable Tracy profiling." OFF)
option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON)

# LTO defaults:
# OFF for Debug (faster linking, avoids /OPT:NOREF conflict)
# ON for Release (better optimization)
if(NOT DEFINED ENABLE_LTO)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        option(ENABLE_LTO "Enable Link Time Optimization (LTO) / Interprocedural Optimization (IPO)" OFF)
        message(STATUS "LTO disabled by default for Debug builds (user can override with -DENABLE_LTO=ON)")
    else()
        option(ENABLE_LTO "Enable Link Time Optimization (LTO) / Interprocedural Optimization (IPO)" ON)
        message(STATUS "LTO enabled by default for ${CMAKE_BUILD_TYPE} builds (user can override with -DENABLE_LTO=OFF)")
    endif()
endif()

message(STATUS "")

include(TargetUtils)

include(CompilerFlags)
include(LinkerFlags)
include(CompilerDefinitions)

include(IconRCFiles)
include(ModuleHandling)
include(Targets)
include(Sanitizers)
include(Valgrind)

include(Cache)

include(Report)
report_build_environment()
report_build_options()
report_compiler_configuration()
report_compiler_flags()
report_git_information()

include(Dependencies)
report_system_dependencies()
report_external_packages()

include(ClangTidy)
include(Fuzzing)

report_code_generation()
create_all_targets()

report_xi_map_target_flags()

report_final_summary()

# Target debugging utilities - uncomment to use:
# print_all_targets()                    # Shows all available targets in the project
# print_target_links(xi_map_lib)         # Shows what libraries a target links to
# print_target_dependencies(xi_map)      # Shows recursive dependency tree
