# Helpers for declaring our first-party libraries and server executables.

set(XI_PCH ${CMAKE_SOURCE_DIR}/src/common/pch.h)

function(xi_precompile_headers target)
    if(PCH_ENABLE)
        target_precompile_headers(${target} PRIVATE ${XI_PCH})
    endif()
endfunction()

# Libraries can share one PCH even when their dependencies add compile definitions, as long as
# none of the headers in pch.h read those macros.
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

# A first-party library: xi_common and everything it carries, our warnings, and xi_common's PCH.
# STATIC by default; OBJECT for libraries that only one executable links.
function(xi_add_library target)
    cmake_parse_arguments(PARSE_ARGV 1 arg "OBJECT" "" "")
    if(arg_OBJECT)
        add_library(${target} OBJECT ${arg_UNPARSED_ARGUMENTS})
    else()
        add_library(${target} STATIC ${arg_UNPARSED_ARGUMENTS})
    endif()
    target_link_libraries(${target} PRIVATE project_warnings)
    if(target STREQUAL xi_common)
        xi_precompile_headers(${target})
    else()
        target_link_libraries(${target} PUBLIC xi_common)
        xi_reuse_pch(${target} xi_common)
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

# A server executable: Windows resource, our warnings, no LTO on Apple, staged in the repo root,
# and Valgrind targets when ENABLE_VALGRIND is on.
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
    xi_add_valgrind_targets(${target})
endfunction()
