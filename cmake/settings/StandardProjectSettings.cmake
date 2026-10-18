# Multi-config generators pick the configuration at build time; single-config ones need a default.
get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(isMultiConfig)
    set(CMAKE_CONFIGURATION_TYPES "RelWithDebInfo;Debug;Release;MinSizeRel" CACHE STRING "Available build configurations" FORCE)
    set(CMAKE_DEFAULT_BUILD_TYPE RelWithDebInfo) # what a bare `cmake --build build` builds under Ninja Multi-Config
elseif(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'RelWithDebInfo' as none was specified.")
    set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS RelWithDebInfo Debug Release MinSizeRel)
endif()

# Ninja only. Each executable link peaks at several GB, so cap how many run beside the compiles.
set_property(GLOBAL APPEND PROPERTY JOB_POOLS link=2)
set(CMAKE_JOB_POOL_LINK link)

# Off for MSVC: /LTCG fed link.exe gigabytes of IL and ran the machine out of memory.
if(MSVC)
    set(ENABLE_IPO_DEFAULT OFF)
else()
    set(ENABLE_IPO_DEFAULT ON)
endif()
option(ENABLE_IPO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)" ${ENABLE_IPO_DEFAULT})
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION OFF)
set(no_ipo_build_types Debug ASAN UBSAN TSAN MSAN LSAN)
if(ENABLE_IPO AND NOT CMAKE_BUILD_TYPE IN_LIST no_ipo_build_types)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT ipo_supported OUTPUT ipo_output)
    if(ipo_supported)
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
        # The guard above only sees the configure-time build type, so exclude Debug here too.
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_DEBUG OFF)
    else()
        message(STATUS "IPO is not supported: ${ipo_output}")
    endif()
endif()
message(STATUS "CMAKE_INTERPROCEDURAL_OPTIMIZATION: ${CMAKE_INTERPROCEDURAL_OPTIMIZATION} (this implies /GL or -flto)")

# strict IEEE floating point, even if the environment adds a fast-math flag
if(MSVC)
    add_compile_options(/fp:precise)
else()
    add_compile_options(-fno-fast-math)
endif()

if(MSVC)
    add_compile_definitions(
        _CRT_NONSTDC_NO_DEPRECATE # no C4996 for POSIX names such as strdup and fileno
    )
    add_compile_options(
        /MP     # the Visual Studio generator passes many files per cl.exe; Ninja ignores it
        /bigobj # sol2 template instantiations overflow the default section limit
        /utf-8  # fmt's sources contain non-ASCII literals
    )

    foreach(config RELEASE RELWITHDEBINFO MINSIZEREL)
        string(APPEND CMAKE_CXX_FLAGS_${config}
            " /Oi" # inline intrinsics such as memcpy and strlen
            " /Gy" # one COMDAT per function, so /OPT:REF and /OPT:ICF can drop and fold them
        )
        string(APPEND CMAKE_EXE_LINKER_FLAGS_${config}
            " /INCREMENTAL:NO" # a full link; incremental linking pads the exe and fights /OPT
            " /OPT:REF"        # drop unreferenced functions and data
            " /OPT:ICF"        # fold identical functions
        )
    endforeach()

    link_libraries(
        ws2_32
        dbghelp
        winmm
        shlwapi
        shell32
        user32
    )
endif()

if(UNIX)
    link_libraries(dl) # dlopen, used by LuaJIT and the crash trace libraries
endif()

# The exe records the build-tree PDB path, so this is for running without the build tree. About a second per link.
option(STAGE_PDB "Copy MSVC PDBs next to the staged binaries in the source root." ON)
message(STATUS "STAGE_PDB: ${STAGE_PDB}")

set(XI_PCH ${CMAKE_SOURCE_DIR}/src/common/pch.h)

function(xi_precompile_headers target)
    if(PCH_ENABLE)
        target_precompile_headers(${target} PRIVATE ${XI_PCH})
    endif()
endfunction()

# A first-party static library: xi_common and everything it carries, our warnings, and its own
# copy of the shared PCH.
function(xi_add_library target)
    add_library(${target} STATIC ${ARGN})
    target_link_libraries(${target} PRIVATE project_warnings)
    if(NOT target STREQUAL xi_common)
        target_link_libraries(${target} PUBLIC xi_common)
    endif()
    xi_precompile_headers(${target})
endfunction()

# On MSVC a reused /Zi PCH makes every consumer compile into a copy of the owner's PDB, and CMake
# refreshes that copy whenever the owner recompiles, orphaning the consumer's older objects (LNK1103).
function(xi_reuse_pch target owner)
    if(NOT PCH_ENABLE)
        return()
    endif()

    if(MSVC)
        target_precompile_headers(${target} PRIVATE ${XI_PCH})
    else()
        target_precompile_headers(${target} REUSE_FROM ${owner})
    endif()
endfunction()

function(xi_stage_in_repo_root target)
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

    if(MSVC AND STAGE_PDB)
        add_custom_command(TARGET ${target} POST_BUILD
            COMMAND "$<$<CONFIG:Debug,RelWithDebInfo>:${CMAKE_COMMAND};-E;copy_if_different;$<TARGET_PDB_FILE:${target}>;${CMAKE_SOURCE_DIR}/$<TARGET_PDB_FILE_NAME:${target}>>"
            COMMAND_EXPAND_LISTS
            VERBATIM)
    endif()

    if(APPLE)
        # Under LTO the linker merges codegen objects into temp files and deletes after linking.
        # We need to preserve those for the next step!
        # -object_path_lto persists those codegen objects to a real, per-target directory so
        # dsymutil can gather their DWARF into the .dSYM.
        if(CMAKE_INTERPROCEDURAL_OPTIMIZATION)
            set(lto_object_dir "${CMAKE_BINARY_DIR}/lto-objects/${target}")
            file(MAKE_DIRECTORY "${lto_object_dir}")
            target_link_options(${target} PRIVATE "-Wl,-object_path_lto,${lto_object_dir}")
        endif()

        # dsymutil consolidates the DWARF into a self-contained .dSYM that travels with the
        # binary, and atos picks it up automatically.
        add_custom_command(TARGET ${target} POST_BUILD
            COMMAND "$<$<CONFIG:Debug,RelWithDebInfo>:dsymutil;$<TARGET_FILE:${target}>;-o;${CMAKE_SOURCE_DIR}/$<TARGET_FILE_NAME:${target}>.dSYM>"
            COMMAND_EXPAND_LISTS
            VERBATIM)
    endif()
endfunction()

function(xi_disable_lto target)
    target_compile_options(${target} PRIVATE -fno-lto)
    target_link_options(${target} PRIVATE -fno-lto)
endfunction()

# A server executable: Windows resource, our warnings, no LTO on Apple, staged in the repo root.
function(xi_add_executable target rc)
    if(WIN32)
        set(resource ${CMAKE_SOURCE_DIR}/res/${rc})
    endif()
    add_executable(${target} ${ARGN} ${resource})
    target_link_libraries(${target} PRIVATE project_warnings)
    if(APPLE)
        xi_disable_lto(${target})
    endif()
    xi_stage_in_repo_root(${target})
endfunction()
