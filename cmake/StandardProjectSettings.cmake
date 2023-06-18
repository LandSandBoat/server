# Set a default build type if none was specified
if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "Setting build type to 'RelWithDebInfo' as none was specified.")
  set(CMAKE_BUILD_TYPE
      "RelWithDebInfo"
      CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui, ccmake
  set_property(
    CACHE CMAKE_BUILD_TYPE
    PROPERTY STRINGS
             "Debug"
             "Release"
             "MinSizeRel"
             "RelWithDebInfo")
endif()

option(ENABLE_IPO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)" ON)

if(ENABLE_IPO)
  include(CheckIPOSupported)
  check_ipo_supported(
    RESULT
    result
    OUTPUT
    output)
  if(result)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
  else()
    message(STATUS "IPO is not supported: ${output}")
  endif()
endif()

# Snippet from GLM: https://github.com/g-truc/glm (MIT)
# NOTE: fast-math was on by default before the CMake build refactoring!
option(ENABLE_FAST_MATH "Enable fast math optimizations" ON)
if(ENABLE_FAST_MATH)
    message(STATUS "ENABLE_FAST_MATH: ON")
    if((CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR (CMAKE_CXX_COMPILER_ID MATCHES "GNU"))
        add_compile_options(-ffast-math)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        add_compile_options(/fp:fast)
    endif()
else()
    message(STATUS "ENABLE_FAST_MATH: OFF")
    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        add_compile_options(/fp:precise)
    endif()
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
    )

    if(CMAKE_CONFIGURATION_TYPES STREQUAL Debug)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /INCREMENTAL /SAFESEH:NO")
        list(APPEND FLAGS_AND_DEFINES
            # TODO: Restore old flag
            # /ZI # Omit Default Library Name
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
    message(STATUS "Setting output directory for ${target} to ${CMAKE_SOURCE_DIR}")
    set_target_properties(${target} PROPERTIES
        VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_SOURCE_DIR}"
        RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_SOURCE_DIR}"
        RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_SOURCE_DIR}"
        RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_SOURCE_DIR}"
    )
endfunction()

function(disable_lto target)
    target_compile_options(${target} PRIVATE -fno-lto)
    target_link_options(${target} PRIVATE -fno-lto)
endfunction()
