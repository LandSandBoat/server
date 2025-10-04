#
# Enforce minimum compiler versions for C++20 support, and to protect users from scary compiler
# errors if they're using unsupported compiler versions.
#

# Github Ubuntu 24.04 LTS runners provide: GNU C++: 12.4.0, 13.3.0, 14.2.0
set(MIN_GCC_VERSION "14.2")

# Github Ubuntu 24.04 LTS runners provide: Clang: 16.0.6, 17.0.6, 18.1.3
set(MIN_CLANG_VERSION "18.1")

# GitHub macOS 15 runners provide AppleClang 16.0.0 (based on Clang/LLVM 16.0.0)
# NOTE: Mostly good C++20 support, but might be lagging with std::format
set(MIN_APPLECLANG_VERSION "16.0")

# Github Windows Server 2025 runners provide: Visual Studio Enterprise 2022 17.14.36511.14
# Microsoft Visual C++ 2022 Runtime 14.44.35211 (MSVC toolset v143)
# MSVC version 19.44+ corresponds to Visual Studio 2022 17.14+ with full C++20
set(MIN_MSVC_VERSION "19.44")

function(validate_compiler_version)
    print_compiler_info_string()

    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS ${MIN_GCC_VERSION})
            message(FATAL_ERROR
                "GCC version must be at least ${MIN_GCC_VERSION}! Detected: ${CMAKE_CXX_COMPILER_VERSION}")
        endif()
    endif()

    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS ${MIN_APPLECLANG_VERSION})
            message(FATAL_ERROR
                "AppleClang version must be at least ${MIN_APPLECLANG_VERSION}! Detected: ${CMAKE_CXX_COMPILER_VERSION}")
        endif()
    elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES ".*Clang")
        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS ${MIN_CLANG_VERSION})
            message(FATAL_ERROR
                "Clang version must be at least ${MIN_CLANG_VERSION}! Detected: ${CMAKE_CXX_COMPILER_VERSION}")
        endif()
    endif()

    if(MSVC)
        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS ${MIN_MSVC_VERSION})
            message(FATAL_ERROR
                "MSVC version must be at least ${MIN_MSVC_VERSION}! Detected: ${CMAKE_CXX_COMPILER_VERSION}")
        endif()
    endif()
endfunction()

function(print_compiler_info_string)
    set(COMPILER_INFO "Unknown compiler")

    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(COMPILER_INFO "GCC ${CMAKE_CXX_COMPILER_VERSION}")
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
        set(COMPILER_INFO "AppleClang ${CMAKE_CXX_COMPILER_VERSION}")
    elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES ".*Clang")
        set(COMPILER_INFO "Clang ${CMAKE_CXX_COMPILER_VERSION}")
    elseif(MSVC)
        set(COMPILER_INFO "MSVC ${CMAKE_CXX_COMPILER_VERSION}")
    endif()

    # Compiler info will be displayed in Compiler Configuration section
endfunction()

validate_compiler_version()
