#
# PCH.cmake
#
# Precompiled Headers Configuration
#
# This module handles PCH (Precompiled Headers) configuration conditionally
# based on platform and build cache availability.
#

# PCH is enabled conditionally:
# - On Windows: where build caching tools like sccache may be less effective
# - When CACHE_OPTION is not set or set to "none"
# - Can be explicitly controlled with ENABLE_PCH option

# Determine if PCH should be enabled by default
if(NOT DEFINED ENABLE_PCH)
    if(WIN32)
        # On Windows, PCH can be beneficial when caching is not available
        if(NOT CACHE_OPTION OR CACHE_OPTION STREQUAL "none")
            set(PCH_DEFAULT ON)
            message(STATUS "PCH enabled by default on Windows without build caching")
        else()
            set(PCH_DEFAULT OFF)
            message(STATUS "PCH disabled by default on Windows with build caching (${CACHE_OPTION})")
        endif()
    else()
        # On Unix platforms, build caching is typically more effective
        set(PCH_DEFAULT OFF)
        message(STATUS "PCH disabled by default on Unix platforms (build caching preferred)")
    endif()
else()
    set(PCH_DEFAULT ${ENABLE_PCH})
endif()

option(ENABLE_PCH "Enable precompiled headers (automatic on Windows without caching)" ${PCH_DEFAULT})
option(ENABLE_TIERED_PCH "Enable target-specific tiered precompiled headers (requires ENABLE_PCH)" ON)

# Function to configure tiered PCH for a target
function(configure_pch target)
    if(ENABLE_PCH AND WIN32)
        # Determine PCH file based on tiered PCH setting
        set(PCH_FILE "")
        
        if(ENABLE_TIERED_PCH)
            # Use target-specific PCH files (Tier 2)
            if(${target} MATCHES ".*map.*")
                set(PCH_FILE "${CMAKE_SOURCE_DIR}/src/map/pch_map.h")
                set(PCH_TYPE "Map-specific PCH (Tier 2)")
            elseif(${target} MATCHES ".*connect.*" OR ${target} MATCHES ".*login.*")
                set(PCH_FILE "${CMAKE_SOURCE_DIR}/src/login/pch_login.h") 
                set(PCH_TYPE "Login-specific PCH (Tier 2)")
            elseif(${target} MATCHES ".*search.*")
                set(PCH_FILE "${CMAKE_SOURCE_DIR}/src/search/pch_search.h")
                set(PCH_TYPE "Search-specific PCH (Tier 2)")
            elseif(${target} MATCHES ".*world.*")
                set(PCH_FILE "${CMAKE_SOURCE_DIR}/src/world/pch_world.h")
                set(PCH_TYPE "World-specific PCH (Tier 2)")
            else()
                # Fall back to common PCH for other targets
                set(PCH_FILE "${CMAKE_SOURCE_DIR}/src/common/pch_common.h")
                set(PCH_TYPE "Common PCH (Tier 1)")
            endif()
        else()
            # Use only common PCH for all targets (Tier 1 only)
            set(PCH_FILE "${CMAKE_SOURCE_DIR}/src/common/pch_common.h")
            set(PCH_TYPE "Common PCH (Single Tier)")
        endif()

        if(EXISTS ${PCH_FILE})
            message(STATUS "Configuring ${PCH_TYPE} for ${target}: ${PCH_FILE}")
            target_precompile_headers(${target} PRIVATE ${PCH_FILE})
        else()
            # Fallback to common PCH if target-specific doesn't exist
            set(FALLBACK_PCH "${CMAKE_SOURCE_DIR}/src/common/pch_common.h")
            if(EXISTS ${FALLBACK_PCH})
                message(STATUS "Target-specific PCH not found, using common PCH for ${target}: ${FALLBACK_PCH}")
                target_precompile_headers(${target} PRIVATE ${FALLBACK_PCH})
            else()
                message(WARNING "No PCH file found for ${target}")
            endif()
        endif()
    endif()
    
    # Configure analysis tools for this target
    analyze_header_usage(${target})
    configure_iwyu(${target})
endfunction()

# Report PCH configuration
if(ENABLE_PCH)
    if(WIN32)
        message(STATUS "PCH: Enabled for Windows builds (Tiered System)")
        message(STATUS "  - Tier 1 (Base): src/common/pch_common.h")
        message(STATUS "  - Tier 2 (Map): src/map/pch_map.h")
        message(STATUS "  - Tier 2 (Login): src/login/pch_login.h") 
        message(STATUS "  - Tier 2 (Search): src/search/pch_search.h")
        message(STATUS "  - Tier 2 (World): src/world/pch_world.h")
    else()
        message(STATUS "PCH: Enabled (explicitly set) - Tiered System")
    endif()
else()
    message(STATUS "PCH: Disabled")
endif()