#
# Tracy profiler configuration and setup
#
# This module handles Tracy profiler integration, including
# CPM package setup and Windows executable downloads.
#

function(configure_tracy)
    # Handle alternative Tracy flag names for compatibility
    if(ENABLE_TRACY OR TRACY_ENABLED OR TRACY)
        set(ENABLE_TRACY ON)
    endif()

    message(STATUS "ENABLE_TRACY: ${ENABLE_TRACY}")

    # Tracy profiler (conditional)
    if(ENABLE_TRACY)
        set(TRACY_VERSION 0.12.2)
        CPMAddPackage(
            NAME TracyClient
            GITHUB_REPOSITORY wolfpld/tracy
            GIT_TAG v${TRACY_VERSION}
            OPTIONS
            "TRACY_ENABLE ON"
            "TRACY_ON_DEMAND ON"
            "TRACY_NO_BROADCAST ON"
            "TRACY_NO_CONTEXT_SWITCH ON"
            "TRACY_NO_EXIT ON"
            "TRACY_NO_VSYNC_CAPTURE ON"
            "TRACY_NO_FRAME_IMAGE ON"
            "TRACY_LIBBACKTRACE_ELF_DYNLOAD_SUPPORT ON"
        )

        # Download Win32 server executables (only if not present)
        if(MSVC)
            # Check if Tracy executables are already present
            set(TRACY_EXECUTABLES
                tracy-capture.exe
                tracy-csvexport.exe
                tracy-import-chrome.exe
                tracy-import-fuchsia.exe
                tracy-profiler.exe
                tracy-update.exe
            )

            set(TRACY_MISSING FALSE)

            foreach(TRACY_EXE ${TRACY_EXECUTABLES})
                if(NOT EXISTS "${CMAKE_SOURCE_DIR}/${TRACY_EXE}")
                    set(TRACY_MISSING TRUE)
                    break()
                endif()
            endforeach()

            if(TRACY_MISSING)
                message(STATUS "Tracy executables missing, downloading Tracy client")
                file(DOWNLOAD
                    https://github.com/wolfpld/tracy/releases/download/v${TRACY_VERSION}/windows-${TRACY_VERSION}.zip
                    ${CMAKE_SOURCE_DIR}/tracy.tar.gz
                    TIMEOUT 60
                )
                execute_process(COMMAND "${CMAKE_COMMAND}" -E
                    tar xvf "${CMAKE_SOURCE_DIR}/tracy.tar.gz"
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/
                )
            else()
                message(STATUS "Tracy executables already present, skipping download")
            endif()
        endif()
    endif()
endfunction()
