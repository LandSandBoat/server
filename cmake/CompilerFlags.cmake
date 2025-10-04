#
# Compiler configuration and warning flags
#

#
# Compiler Detection
#
set(IS_MSVC FALSE)
set(IS_CLANG FALSE)
set(IS_GCC FALSE)
set(IS_GCC_OR_CLANG FALSE)

if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    set(IS_MSVC TRUE)
elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
    set(IS_CLANG TRUE)
    set(IS_GCC_OR_CLANG TRUE)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(IS_GCC TRUE)
    set(IS_GCC_OR_CLANG TRUE)
endif()

#
# Base Compiler Flags
#

# Set base MSVC flags that apply to all build types
function(set_base_msvc_flags target)
    if(MSVC)
        set(MSVC_BASE_FLAGS
            /GR # Enable Run-Time Type Information (required for dynamic_cast and typeid)
            /Oy- # Disable frame pointer omission for better debugging and stack traces
            /MP # Enable multi-processor compilation for faster builds
            /FS # Force synchronous PDB writes (prevents locking with parallel builds)
            /bigobj # Increase object file size limit (required for heavy template usage)
            /utf-8 # Treat source and execution character sets as UTF-8
        )
        target_compile_options(${target} PRIVATE ${MSVC_BASE_FLAGS})
    endif()
endfunction()

# Set base Clang flags that apply to all build types
function(set_base_clang_flags target)
    if(IS_CLANG)
        set(CLANG_BASE_FLAGS
            -fms-extensions # Enable Microsoft language extensions for compatibility
            -fms-compatibility # Enable full MSVC compatibility mode
            -fdelayed-template-parsing # Parse templates like MSVC (required for some code patterns)
        )
        target_compile_options(${target} PRIVATE ${CLANG_BASE_FLAGS})

        if(WIN32)
            set(CLANG_WINDOWS_FLAGS
                -D_MSC_VER=1900 # Define MSVC version macro (MSVC 2015+) for library compatibility
                -Wno-microsoft-cast # Suppress warnings about Microsoft-specific cast behavior
                -Wno-unused-command-line-argument # Suppress warnings about unused compiler arguments
            )
            target_compile_options(${target} PRIVATE ${CLANG_WINDOWS_FLAGS})
        endif()
    endif()
endfunction()

#
# Build Type Specific Flags
#

# Debug build flags (prioritize build speed)
function(set_debug_compiler_flags target)
    if(MSVC)
        set(MSVC_DEBUG_FLAGS
            /MDd # Use multi-threaded debug DLL runtime

            # /Gm- # Disable minimal rebuild (obsolete, faster without it)
            # /Zc:inline # Remove unreferenced functions/data (faster linking)
            # /Gw # Optimize global data (faster linking, smaller objects)
        )
        target_compile_options(${target} PRIVATE ${MSVC_DEBUG_FLAGS})
    elseif(IS_GCC_OR_CLANG)
        set(GCC_CLANG_DEBUG_FLAGS
            -O0 # Disable all optimizations for fastest compilation and accurate debugging
            -g1 # Generate minimal debug info (line numbers only, faster than -g)
            -fno-eliminate-unused-debug-types # Keep unused types in debug info (better debugging)
        )
        target_compile_options(${target} PRIVATE ${GCC_CLANG_DEBUG_FLAGS})
    endif()
endfunction()

# Release build flags (prioritize runtime speed)
function(set_release_compiler_flags target)
    if(MSVC)
        set(MSVC_RELEASE_FLAGS
            /MD # Use multi-threaded DLL runtime

            # /O2 # Maximize speed (optimize for speed over size)
            # /Oi # Replace function calls with intrinsic functions where possible
            # /Ot # Favor fast code over small code
            # /Gy # Enable function-level linking (allows linker to remove unused functions)
            # /TP # Treat all files as C++ source files
            # /Gw # Optimize global data (merge identical data, reduce binary size)
            # /GF # Enable string pooling (reduces binary size, faster string compares)
            # /Qfast_transcendentals # Use faster (less precise) math functions (sin, cos, sqrt, etc.)
            # /Zc:inline # Remove unreferenced functions (smaller binary, faster linking)
        )
        target_compile_options(${target} PRIVATE ${MSVC_RELEASE_FLAGS})
    elseif(IS_GCC_OR_CLANG)
        set(GCC_CLANG_RELEASE_FLAGS
            -O3 # Aggressive optimization (more aggressive than -O2, enables auto-vectorization)
            -DNDEBUG # Disable assertions (removes assert() checks, improves performance)
            -march=native # Optimize for the current CPU architecture (may not be portable)
            -fomit-frame-pointer # Omit frame pointer (extra register for optimization)
            -funroll-loops # Unroll loops for better performance
            -fvectorize # Enable auto-vectorization (SIMD optimization)
        )
        target_compile_options(${target} PRIVATE ${GCC_CLANG_RELEASE_FLAGS})
    endif()
endfunction()

# RelWithDebInfo build flags (optimized with debug info)
function(set_relwithdebinfo_compiler_flags target)
    if(MSVC)
        set(MSVC_RELWITHDEBINFO_FLAGS
            /MD # Use multi-threaded DLL runtime

            # /Oi # Replace function calls with intrinsic functions where possible
            # /Gm- # Disable minimal rebuild (obsolete, faster without it)
            # /JMC # Enable Just My Code debugging (skip non-user code during debugging)
        )
        target_compile_options(${target} PRIVATE ${MSVC_RELWITHDEBINFO_FLAGS})
    elseif(IS_GCC_OR_CLANG)
        set(GCC_CLANG_RELWITHDEBINFO_FLAGS
            -O1 # Basic optimizations (balance between speed and compilation time)
            -g1 # Generate minimal debug info (line numbers only, faster than -g)

            # Note: NDEBUG not defined - keep assertions for RelWithDebInfo builds
        )
        target_compile_options(${target} PRIVATE ${GCC_CLANG_RELWITHDEBINFO_FLAGS})
    endif()
endfunction()

# MinSizeRel build flags (optimize for size)
function(set_minsizerel_compiler_flags target)
    if(MSVC)
        set(MSVC_MINSIZEREL_FLAGS
            /MD # Use multi-threaded DLL runtime

            # /O1 # Optimize for minimum size (balance of size and speed)
            # /Os # Favor small code over fast code
        )
        target_compile_options(${target} PRIVATE ${MSVC_MINSIZEREL_FLAGS})
    elseif(IS_GCC_OR_CLANG)
        set(GCC_CLANG_MINSIZEREL_FLAGS
            -Os # Optimize for size (enables all -O2 optimizations that don't increase code size)
            -DNDEBUG # Disable assertions (removes assert() checks)
        )
        target_compile_options(${target} PRIVATE ${GCC_CLANG_MINSIZEREL_FLAGS})
    endif()
endfunction()

#
# Security Hardening Flags
#

# Apply security hardening flags
function(set_security_hardening_flags target)
    if(MSVC)
        set(MSVC_SECURITY_FLAGS

            # /GS # Buffer security check (detect stack buffer overruns)
            # /sdl # Enable additional security checks (SDL checks, stricter warnings)
        )
        target_compile_options(${target} PRIVATE ${MSVC_SECURITY_FLAGS})
    elseif(IS_GCC_OR_CLANG)
        set(GCC_CLANG_SECURITY_FLAGS
            -fstack-protector-strong # Stack protection (guards against stack buffer overflows)
            -D_FORTIFY_SOURCE=2 # Runtime buffer overflow detection (adds bounds checking)
        )
        target_compile_options(${target} PRIVATE ${GCC_CLANG_SECURITY_FLAGS})

        # Note: CFI (Control Flow Integrity) is only enabled for Release builds with LTO
        # CFI requires LTO and is incompatible with Debug builds
        if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" AND CMAKE_BUILD_TYPE MATCHES "Release" AND ENABLE_LTO)
            set(CLANG_CFI_FLAGS
                -fsanitize=cfi-vcall # Control Flow Integrity for virtual calls (prevents vtable hijacking)
                -fvisibility=hidden # Required for CFI to work correctly
            )
            target_compile_options(${target} PRIVATE ${CLANG_CFI_FLAGS})
        endif()
    endif()
endfunction()

#
# Main Configuration Function
#

# Configure all compiler flags for a target based on build type
function(configure_compiler_flags target)
    # Apply base compiler flags
    set_base_msvc_flags(${target})
    set_base_clang_flags(${target})

    # Apply build-type specific flags
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set_debug_compiler_flags(${target})
    elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
        set_release_compiler_flags(${target})
    elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
        set_relwithdebinfo_compiler_flags(${target})
    elseif(CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
        set_minsizerel_compiler_flags(${target})
    endif()

    # Apply security hardening for non-debug builds
    if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug" AND ENABLE_SECURITY_HARDENING)
        set_security_hardening_flags(${target})
    endif()

    set_project_warnings(${target})
endfunction()

#
# Fast Math Configuration
#

# Apply fast math settings globally based on ENABLE_FAST_MATH option
if(ENABLE_FAST_MATH)
    if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(GCC_CLANG_FAST_MATH
            -ffast-math # Enable fast math optimizations (may break IEEE 754 compliance)
            -fno-finite-math-only # Don't assume all math is finite (prevents NaN/Inf issues)
        )
        add_compile_options(${GCC_CLANG_FAST_MATH})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        # add_compile_options(/fp:fast) # Fast floating-point model (less precise, faster)
    endif()
else()
    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        # add_compile_options(/fp:precise) # Precise floating-point model (default, IEEE 754 compliant)
    endif()
endif()

# Disable fast math for specific targets that require precision
function(disable_fast_math target)
    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        target_compile_options(${target} PRIVATE /fp:precise) # Precise floating-point model
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_compile_options(${target} PRIVATE -fno-fast-math) # Disable fast math optimizations
    endif()
endfunction()

# Enable strict floating point for specific targets
function(enable_strict_fp target)
    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        target_compile_options(${target} PRIVATE /fp:strict) # Strict floating-point model (most precise)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(STRICT_FP_FLAGS
            -frounding-math # Honor user-specified rounding mode
            -fsignaling-nans # Support signaling NaNs
        )
        target_compile_options(${target} PRIVATE ${STRICT_FP_FLAGS})
    endif()
endfunction()

#
# LTO/IPO Configuration
#

# Initialize LTO state
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION OFF)

# Configure LTO based on user option and compiler support
if(ENABLE_LTO)
    include(CheckIPOSupported)
    check_ipo_supported(
        RESULT lto_supported
        OUTPUT lto_output
    )

    if(lto_supported)
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
        message(STATUS "LTO/IPO enabled globally")
    else()
        message(STATUS "LTO/IPO not supported by compiler: ${lto_output}")
        set(ENABLE_LTO OFF CACHE BOOL "LTO disabled due to lack of compiler support" FORCE)
    endif()
endif()

# Apply LTO-specific compiler optimizations to a target
function(configure_lto target)
    if(NOT CMAKE_INTERPROCEDURAL_OPTIMIZATION)
        return()
    endif()

    message(STATUS "Applying LTO compiler configuration to target: ${target}")

    if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        set(CLANG_LTO_FLAGS -flto=thin) # ThinLTO (faster than full LTO, better parallelization)
        target_compile_options(${target} PRIVATE ${CLANG_LTO_FLAGS})

    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(GCC_LTO_COMPILE_FLAGS -flto=auto) # Auto-detect number of parallel LTO jobs
        target_compile_options(${target} PRIVATE ${GCC_LTO_COMPILE_FLAGS})

    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(MSVC_LTO_FLAGS
            /Gw # Optimize global data (merge identical globals)
        )
        target_compile_options(${target} PRIVATE /Gw)
    endif()
endfunction()

# Enable LTO for a specific target (overrides global setting)
function(enable_lto target)
    if(NOT ENABLE_LTO)
        message(STATUS "LTO globally disabled, cannot enable for ${target}")
        return()
    endif()

    # Check if LTO is supported
    include(CheckIPOSupported)
    check_ipo_supported(RESULT target_lto_supported)

    if(target_lto_supported)
        set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
        configure_lto(${target})
        message(STATUS "LTO enabled for target: ${target}")
    else()
        message(WARNING "Cannot enable LTO for ${target}: not supported by compiler")
    endif()
endfunction()

# Disable LTO for specific targets
function(disable_lto target)
    set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION FALSE)

    if(NOT CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(NO_LTO_FLAGS -fno-lto) # Explicitly disable LTO for this target
        target_compile_options(${target} PRIVATE ${NO_LTO_FLAGS})
    endif()

    # Also disable LTO linker flags
    disable_lto_linker_flags(${target})

    message(STATUS "LTO disabled for target: ${target}")
endfunction()

#
# Compiler Warning Configuration
#

# Set compiler warnings for a target
function(set_project_warnings target)
    set(MSVC_WARNINGS
        /W4 # Baseline reasonable warnings
        /permissive- # standards conformance mode for MSVC compiler

        # Disable specific noisy or non-actionable warnings
        /wd4100 # unreferenced formal parameter
        /wd4127 # conditional expression is constant
        /wd4201 # nonstandard extension used: nameless struct/union
        /wd4242 # conversion from 'type1' to 'type1', possible loss of data
        /wd4244 # conversion from 'const type1' to 'type2', possible loss of data
        /wd4245 # conversion from 'const type1' to 'type2', signed/unsigned mismatch
        /wd4456 # declaration of 'var' hides local declaration
        /wd4457 # declaration of 'var' hides function parameter
        /wd4458 # declaration of 'var' hides class member
        /wd4459 # declaration of 'var' hides global declaration
        /wd5272 # throwing an object of non-copyable type 'type' is non-standard
        /wd4554 # operator precedence warning (concurrentqueue issue)

        # Additional warnings to consider enabling in the future
        # /w14254 # conversion from 'type1:field_bits' to 'type2:field_bits', possible loss of data
        # /w14263 # member function does not override any base class virtual member function
        # /w14265 # class has virtual functions, but destructor is not virtual
        # /w14287 # unsigned/negative constant mismatch
        # /we4289 # nonstandard extension used: 'variable': loop control variable declared in the for-loop is used outside
        # /w14296 # expression is always 'boolean_value'
        # /w14311 # pointer truncation from 'type1' to 'type2'
        # /w14545 # expression before comma evaluates to a function which is missing an argument list
        # /w14546 # function call before comma missing argument list
        # /w14547 # operator before comma has no effect; expected operator with side-effect
        # /w14549 # operator before comma has no effect; did you intend 'operator'?
        # /w14555 # expression has no effect; expected expression with side-effect
        # /w14619 # pragma warning: there is no warning number 'number'
        # /w14640 # Enable warning on thread un-safe static member initialization
        # /w14905 # wide string literal cast to 'LPSTR'
        # /w14906 # string literal cast to 'LPWSTR'
        # /w14928 # illegal copy-initialization; more than one user-defined conversion has been implicitly applied
    )

    set(CLANG_WARNINGS
        -Wall # Enable most common warnings
        -Wextra # Enable extra warnings not covered by -Wall
        -Wnon-virtual-dtor # Warn about missing virtual destructors
        -Wunused-function # Warn about unused functions
        -Wunused-variable # Warn about unused variables
        -Woverloaded-virtual # Warn when virtual function is hidden
        -Wnull-dereference # Warn about potential null pointer dereferences
        -Wformat=2 # Warn about printf/scanf format issues
        -Wno-unused-parameter # Don't warn about unused function parameters (common in interfaces)
        -Wno-missing-field-initializers # Don't warn about missing field initializers (too noisy)
        -Wno-sign-compare # Don't warn about signed/unsigned comparisons (too noisy)
    )

    if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 18)
        list(APPEND CLANG_WARNINGS
            -Wno-nan-infinity-disabled # Don't warn about NaN/Inf with fast-math (expected with detour)
            -Wunused-private-field # Warn about unused private fields
        )
    endif()

    set(GCC_WARNINGS
        ${CLANG_WARNINGS}
        -Wmisleading-indentation # Warn about misleading indentation (GCC-specific)
        -Wduplicated-cond # Warn about duplicated conditions in if-else chains (GCC-specific)
        -Wduplicated-branches # Warn about duplicated branches (GCC-specific)
        -Wlogical-op # Warn about suspicious uses of logical operators (GCC-specific)
        -Wno-useless-cast # Don't warn about casts to the same type (too noisy)
        -fno-var-tracking-assignments # Disable variable tracking for faster debug builds
    )

    if(MSVC)
        set(PROJECT_WARNINGS ${MSVC_WARNINGS})
        set(ERROR_FLAG "/WX")
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        set(PROJECT_WARNINGS ${CLANG_WARNINGS})
        set(ERROR_FLAG "-Werror")
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(PROJECT_WARNINGS ${GCC_WARNINGS})
        set(ERROR_FLAG "-Werror")
    else()
        message(AUTHOR_WARNING "No compiler warnings set for '${CMAKE_CXX_COMPILER_ID}' compiler.")
        return()
    endif()

    if(WARNINGS_AS_ERRORS)
        target_compile_options(${target} PRIVATE ${ERROR_FLAG} ${PROJECT_WARNINGS})
    else()
        target_compile_options(${target} PRIVATE ${PROJECT_WARNINGS})
    endif()
endfunction()
