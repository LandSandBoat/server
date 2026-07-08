# Set a default build type if none was specified
get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(isMultiConfig)
  set(CMAKE_CONFIGURATION_TYPES
      "RelWithDebInfo;Debug;Release;MinSizeRel"
      CACHE STRING "Available build configurations" FORCE)

  if(CMAKE_GENERATOR STREQUAL "Ninja Multi-Config")
    set(CMAKE_DEFAULT_BUILD_TYPE "RelWithDebInfo")
  endif()
elseif(NOT CMAKE_BUILD_TYPE)
  message(STATUS "Setting build type to 'RelWithDebInfo' as none was specified.")
  set(CMAKE_BUILD_TYPE
      "RelWithDebInfo"
      CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui, ccmake
  set_property(
    CACHE CMAKE_BUILD_TYPE
    PROPERTY STRINGS
        "RelWithDebInfo"
        "Debug"
        "Release"
        "MinSizeRel"
    )
endif()

option(ENABLE_IPO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)" ON)
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION OFF)
if(ENABLE_IPO AND NOT CMAKE_BUILD_TYPE STREQUAL Debug AND NOT CMAKE_BUILD_TYPE STREQUAL ASAN AND NOT CMAKE_BUILD_TYPE STREQUAL UBSAN AND NOT CMAKE_BUILD_TYPE STREQUAL TSAN AND NOT CMAKE_BUILD_TYPE STREQUAL MSAN AND NOT CMAKE_BUILD_TYPE STREQUAL LSAN)
  include(CheckIPOSupported)
  check_ipo_supported(
    RESULT
    result
    OUTPUT
    output)
  if(result)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
  else()
    message(STATUS "IPO is not supported: ${output}")
  endif()
endif()
message(STATUS "CMAKE_INTERPROCEDURAL_OPTIMIZATION: ${CMAKE_INTERPROCEDURAL_OPTIMIZATION} (this implies /GL or -flto)")

if((CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR (CMAKE_CXX_COMPILER_ID MATCHES "GNU"))
    add_compile_options(-fno-fast-math)
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    add_compile_options(/fp:precise)
endif()

if(MSVC)
    list(APPEND FLAGS_AND_DEFINES
        -D_CONSOLE
        -D_MBCS
        -DNOMINMAX
        -D_CRT_SECURE_NO_WARNINGS
        -D_CRT_NONSTDC_NO_DEPRECATE
        # TODO: This is being overwritten by /Ob0
        # /Ob2 # Inline Function Expansion
        /Oy- # Frame-Pointer Omission
        /MP # Build with Multiple Processes
        /bigobj # Allow bigger .obj files, which we have from mainly the sol templating
        /utf-8 # Treat source files as UTF-8. This is needed because of certain symbols inside fmtlib's code. u-second, etc.
    )

    if(CMAKE_BUILD_TYPE STREQUAL Debug)
        # /EDITANDCONTINUE isn't supported, it messes with Tracy
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /INCREMENTAL /SAFESEH:NO")
        list(APPEND FLAGS_AND_DEFINES
            /GR # Enable RTTI
        )
    else()
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /INCREMENTAL:NO /LTCG /OPT:REF /OPT:ICF")
        list(APPEND FLAGS_AND_DEFINES
            /Oi # Generate Intrinsic Functions
            /GL # Whole Program Optimization
            /Gy # Enable Function Level Linking
            /TP # C++ Source Files
        )
    endif()

    link_libraries(WS2_32 dbghelp Shlwapi)
endif()

if(UNIX)
    link_libraries(dl)
endif()

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    if (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 9.0)
        message(FATAL_ERROR
                "GCC version must be at least 9.0! Detected: ${CMAKE_CXX_COMPILER_VERSION}")
    endif()
endif()

# TODO: These should be applied on a per-target level, not globally like this!
string(REPLACE ";" " " FLAGS_AND_DEFINES_STR "${FLAGS_AND_DEFINES}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAGS_AND_DEFINES_STR}")

function(set_target_output_directory target)
    # Run from the repo root: data, scripts, settings and the runtime DLLs all live there.
    # DEBUGGER_WORKING_DIRECTORY (CMake 4.0+): Ninja and other non-VS generators.
    # VS_DEBUGGER_WORKING_DIRECTORY: Visual Studio generator (takes precedence there).
    set_target_properties(${target} PROPERTIES
        DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")

    message(STATUS "${target}: staging build artifact to ${CMAKE_SOURCE_DIR} after build")
    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "$<TARGET_FILE:${target}>"
                "${CMAKE_SOURCE_DIR}/$<TARGET_FILE_NAME:${target}>"
        VERBATIM)

    if(MSVC)
        add_custom_command(TARGET ${target} POST_BUILD
            COMMAND "$<$<CONFIG:Debug,RelWithDebInfo>:${CMAKE_COMMAND};-E;copy_if_different;$<TARGET_PDB_FILE:${target}>;${CMAKE_SOURCE_DIR}/$<TARGET_PDB_FILE_NAME:${target}>>"
            COMMAND_EXPAND_LISTS
            VERBATIM)
    endif()
endfunction()

function(disable_lto target)
    target_compile_options(${target} PRIVATE -fno-lto)
    target_link_options(${target} PRIVATE -fno-lto)
endfunction()
