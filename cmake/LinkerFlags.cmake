#
# Centralized linker flag configuration
#
# This file handles all linker-specific settings,
# separated by build type and platform for better maintainability.
#

# Set debug linker flags (prioritize build speed)
function(set_debug_linker_flags target)
    if(MSVC)
        set(MSVC_DEBUG_LINK_FLAGS

            # /INCREMENTAL # Enable incremental linking (faster link times on rebuilds)
            # /DEBUG:FULL # Generate full debug information (works with /Zi external PDB)
            # /OPT:NOREF # Don't remove unreferenced code (faster linking)
            # /OPT:NOICF # Don't fold identical functions (faster linking)
        )
        target_link_options(${target} PRIVATE ${MSVC_DEBUG_LINK_FLAGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        # Debug linker flags for faster builds
        target_link_options(${target} PRIVATE
            -Wl,--build-id=none # Skip build ID generation for speed
        )

        # Use faster linkers if available
        if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
            execute_process(COMMAND ${CMAKE_CXX_COMPILER} -fuse-ld=lld -Wl,--version
                OUTPUT_QUIET ERROR_QUIET RESULT_VARIABLE LLD_RESULT)

            if(LLD_RESULT EQUAL 0)
                target_link_options(${target} PRIVATE -fuse-ld=lld) # Use LLVM's LLD linker (faster than GNU ld)
            endif()
        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
            execute_process(COMMAND ${CMAKE_CXX_COMPILER} -fuse-ld=gold -Wl,--version
                OUTPUT_QUIET ERROR_QUIET RESULT_VARIABLE GOLD_RESULT)

            if(GOLD_RESULT EQUAL 0)
                target_link_options(${target} PRIVATE -fuse-ld=gold) # Use GNU gold linker (faster than GNU ld)
            endif()
        endif()
    endif()
endfunction()

# Set release linker flags (prioritize runtime performance)
function(set_release_linker_flags target)
    if(MSVC)
        set(MSVC_RELEASE_LINK_FLAGS

            # /INCREMENTAL:NO # Disable incremental linking (faster runtime, smaller binary)
            # /LTCG # Link Time Code Generation
            # /OPT:REF # Remove unreferenced functions and data (reduce binary size)
            # /OPT:ICF # Identical COMDAT folding (merge identical functions, reduce binary size)
        )
        target_link_options(${target} PRIVATE ${MSVC_RELEASE_LINK_FLAGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_link_options(${target} PRIVATE
            -Wl,--gc-sections # Remove unused sections
            -Wl,--strip-all # Strip all symbols for smaller binaries
        )
    endif()
endfunction()

# Set RelWithDebInfo linker flags (optimized with debug info)
function(set_relwithdebinfo_linker_flags target)
    if(MSVC)
        set(MSVC_RELWITHDEBINFO_LINK_FLAGS

            # /INCREMENTAL # Enable incremental linking (faster rebuilds)
            # /DEBUG:FULL # Generate full debug information (works with /Zi external PDB)
        )
        target_link_options(${target} PRIVATE ${MSVC_RELWITHDEBINFO_LINK_FLAGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        # Use faster linkers if available
        if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
            execute_process(COMMAND ${CMAKE_CXX_COMPILER} -fuse-ld=lld -Wl,--version
                OUTPUT_QUIET ERROR_QUIET RESULT_VARIABLE LLD_RESULT)

            if(LLD_RESULT EQUAL 0)
                target_link_options(${target} PRIVATE -fuse-ld=lld) # Use LLVM's LLD linker
            endif()
        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
            execute_process(COMMAND ${CMAKE_CXX_COMPILER} -fuse-ld=gold -Wl,--version
                OUTPUT_QUIET ERROR_QUIET RESULT_VARIABLE GOLD_RESULT)

            if(GOLD_RESULT EQUAL 0)
                target_link_options(${target} PRIVATE -fuse-ld=gold) # Use GNU gold linker
            endif()
        endif()
    endif()
endfunction()

function(set_symbol_visibility target visibility)
    if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        if(${visibility} STREQUAL "hidden")
            target_compile_options(${target} PRIVATE -fvisibility=hidden)
            target_compile_definitions(${target} PRIVATE -DAPI_EXPORTS)
        elseif(${visibility} STREQUAL "default")
            target_compile_options(${target} PRIVATE -fvisibility=default)
        endif()
    endif()
endfunction()

function(link_platform_libraries target)
    if(WIN32)
        target_link_libraries(${target} PRIVATE
            WS2_32 # Windows Sockets
            dbghelp # Debug Help Library
            Shlwapi # Shell Lightweight Utility Functions
        )
    elseif(UNIX)
        target_link_libraries(${target} PRIVATE
            dl # Dynamic loading
        )

        # 32-bit systems (like Raspberry Pi) need libatomic
        if(CMAKE_SIZEOF_VOID_P EQUAL 4)
            target_link_libraries(${target} PRIVATE atomic)
        endif()
    endif()
endfunction()

# Apply security hardening linker flags
function(set_security_hardening_linker_flags target)
    if(MSVC)
        set(MSVC_SECURITY_LINK_FLAGS

            # /DYNAMICBASE # Address Space Layout Randomization (ASLR) - randomize base address
            # /NXCOMPAT # Data Execution Prevention (DEP) - mark memory as non-executable
        )
        target_link_options(${target} PRIVATE ${MSVC_SECURITY_LINK_FLAGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        # Note: CFI (Control Flow Integrity) is only enabled for Release builds with LTO
        # CFI requires LTO and is incompatible with Debug builds
        if(CMAKE_BUILD_TYPE MATCHES "Release" AND ENABLE_LTO)
            target_link_options(${target} PRIVATE -fsanitize=cfi-vcall)
        endif()
    endif()
endfunction()

# Apply LTO-specific linker optimizations to a target
function(configure_lto_linker_flags target)
    if(NOT CMAKE_INTERPROCEDURAL_OPTIMIZATION)
        return()
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        set(CLANG_LTO_LINK_FLAGS -flto=thin) # ThinLTO (faster than full LTO, better parallelization)
        target_link_options(${target} PRIVATE ${CLANG_LTO_LINK_FLAGS})

        if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
            target_link_options(${target} PRIVATE -Wl,--lto-O3) # Aggressive LTO optimization level
        endif()

    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(GCC_LTO_LINK_FLAGS
            -flto=auto # Auto-detect number of parallel LTO jobs
            -flto-partition=1to1 # One partition per translation unit (better parallelization)
        )
        target_link_options(${target} PRIVATE ${GCC_LTO_LINK_FLAGS})

        if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
            target_link_options(${target} PRIVATE -fuse-linker-plugin) # Use linker plugin for LTO
        endif()

    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        # /OPT:REF and /OPT:ICF are already handled in release linker flags
        # MSVC LTO is handled via /LTCG which is already in release flags
    endif()
endfunction()

# Disable LTO linker flags for specific targets
function(disable_lto_linker_flags target)
    if(NOT CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(NO_LTO_LINK_FLAGS -fno-lto) # Explicitly disable LTO for this target
        target_link_options(${target} PRIVATE ${NO_LTO_LINK_FLAGS})
    endif()
endfunction()

function(configure_linker_flags target)
    # Apply build-type specific linker flags
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set_debug_linker_flags(${target})
    elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
        set_relwithdebinfo_linker_flags(${target})
    else()
        # Release, MinSizeRel
        set_release_linker_flags(${target})
    endif()

    # Apply security hardening for non-debug builds
    if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug" AND ENABLE_SECURITY_HARDENING)
        set_security_hardening_linker_flags(${target})
    endif()

    # Apply LTO linker configuration if enabled
    if(CMAKE_INTERPROCEDURAL_OPTIMIZATION)
        configure_lto_linker_flags(${target})
    endif()

    # Link platform-specific libraries
    link_platform_libraries(${target})

    # TODO: Move to options
    option(HIDE_SYMBOLS "Hide symbols by default" ON)

    if(HIDE_SYMBOLS AND NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
        set_symbol_visibility(${target} "hidden")
    else()
        set_symbol_visibility(${target} "default")
    endif()
endfunction()
