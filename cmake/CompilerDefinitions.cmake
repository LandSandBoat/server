#
# Compiler Definitions and Preprocessor Macros
#
# This file centralizes all preprocessor definitions used across the project
#

# Cross-platform definitions
set(COMMON_DEFINITIONS

    # Sol configuration
    -DSOL_ALL_SAFETIES_ON=1
    -DSOL_NO_CHECK_NUMBER_PRECISION=1
    -DSOL_DEFAULT_PASS_ON_ERROR=1
    -DSOL_PRINT_ERRORS=0

    # Recast Navigation
    -DRC_FAST_MATH=1

    # Logging configuration
    -DSPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_DEBUG
)

# Platform-specific definitions
if(WIN32)
    set(PLATFORM_DEFINITIONS
        -D_CONSOLE
        -D_MBCS
        -DNOMINMAX
        -D_CRT_SECURE_NO_WARNINGS
        -D_CRT_NONSTDC_NO_DEPRECATE
    )

    # Windows version targeting
    if(NOT DEFINED _WIN32_WINNT)
        # Target Windows 10 by default (0x0A00)
        set(_WIN32_WINNT 0x0A00)
    endif()

    list(APPEND PLATFORM_DEFINITIONS -D_WIN32_WINNT=${_WIN32_WINNT})

elseif(UNIX AND NOT APPLE)
    set(PLATFORM_DEFINITIONS

        # Linux-specific definitions go here
    )

elseif(APPLE)
    set(PLATFORM_DEFINITIONS

        # macOS-specific definitions can go here
    )
endif()

# Feature-based definitions (controlled by CMake options)
set(FEATURE_DEFINITIONS "")

# Tracy profiling
if(ENABLE_TRACY)
    list(APPEND FEATURE_DEFINITIONS
        -DENABLE_TRACY=1
        -DTRACY_ENABLE=1
        -DTRACY_ON_DEMAND=1
        -DTRACY_NO_BROADCAST=1
    )
endif()

# Combine all definitions
set(ALL_COMPILER_DEFINITIONS
    ${COMMON_DEFINITIONS}
    ${PLATFORM_DEFINITIONS}
    ${FEATURE_DEFINITIONS}
)

# Function to apply definitions to a target
function(configure_compiler_definitions target)
    target_compile_definitions(${target} PRIVATE ${ALL_COMPILER_DEFINITIONS})
endfunction()

# Apply definitions globally (temporary - should move to per-target)
add_compile_definitions(${COMMON_DEFINITIONS} ${PLATFORM_DEFINITIONS} ${FEATURE_DEFINITIONS})
