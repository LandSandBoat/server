# Tracy profiler: configure with -DTRACY_ENABLE=ON. Fetches the client library, plus the
# Windows server executables or the capture tools on Linux and macOS.

option(TRACY_ENABLE "Enable Tracy profiling." OFF)
if(ENABLE_TRACY OR TRACY_ENABLED OR TRACY) # Also handle close flags
    set(TRACY_ENABLE ON)
endif()
message(STATUS "TRACY_ENABLE: ${TRACY_ENABLE}")

if(TRACY_ENABLE)
    # Tracy version tag, without the leading 'v'
    set(TRACY_VERSION 0.14.1)

    # Download client library
    CPMAddPackage(
        NAME TracyClient
        GITHUB_REPOSITORY wolfpld/tracy
        GIT_TAG v${TRACY_VERSION}
        SYSTEM ON
        OPTIONS
            "TRACY_ENABLE ON"
            "TRACY_ON_DEMAND ON"
            "TRACY_NO_BROADCAST ON"
            "TRACY_NO_CONTEXT_SWITCH ON"
            "TRACY_NO_EXIT OFF"
            "TRACY_NO_VSYNC_CAPTURE ON"
            "TRACY_NO_FRAME_IMAGE ON"
            # "TRACY_NO_SYSTEM_TRACING ON" # This is incredibly heavy, add this line back if you need to speed up profiling
            # "TRACY_TIMER_FALLBACK OFF" # Maybe useful to set ON for Linux VMs?
            "TRACY_LIBBACKTRACE_ELF_DYNLOAD_SUPPORT ON"
    )

    include(ExternalProject)

    # Download Win32 server executables at build time, into the build tree, and stage them in the
    # repo root like the Linux and macOS tools below.
    if(MSVC)
        ExternalProject_Add(tracy-windows-tools
            URL https://github.com/wolfpld/tracy/releases/download/v${TRACY_VERSION}/windows-${TRACY_VERSION}.zip
            URL_HASH SHA256=f7499d74914aa3ba94a2c1ce72f36477d7b61d9d0f7c9790e05274c258c97fb5 # update with TRACY_VERSION
            DOWNLOAD_EXTRACT_TIMESTAMP ON
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> ${CMAKE_SOURCE_DIR}
        )
    else() # UNIX (Linux / macOS)
        # target name:source subdirectory
        set(TRACY_TOOLS
            "tracy-capture:capture"
            "tracy-csvexport:csvexport"
        )

        foreach(_tracy_tool ${TRACY_TOOLS})
            string(REPLACE ":" ";" _tracy_tool "${_tracy_tool}")
            list(GET _tracy_tool 0 _tracy_tool_name)
            list(GET _tracy_tool 1 _tracy_tool_dir)

            message(STATUS "Configuring Tracy tool: ${_tracy_tool_name}")

            set(_tracy_tool_bindir ${CMAKE_BINARY_DIR}/tracy-tools/${_tracy_tool_name})

            ExternalProject_Add(${_tracy_tool_name}
                SOURCE_DIR ${TracyClient_SOURCE_DIR}/${_tracy_tool_dir}
                BINARY_DIR ${_tracy_tool_bindir}
                CMAKE_ARGS
                    -DCMAKE_BUILD_TYPE=Release
                    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
                    -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
                    -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
                    -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${_tracy_tool_bindir}
                BUILD_ALWAYS TRUE
                INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    ${_tracy_tool_bindir}/${_tracy_tool_name}
                    ${CMAKE_SOURCE_DIR}/${_tracy_tool_name}
            )
        endforeach()
    endif()
endif(TRACY_ENABLE)
