#
# Dynamic module processing and configuration
#
# This module provides functions for processing modules from init.txt
# and integrating them into the build system.
#

# Function to process modules from init.txt and populate variables
# This function will populate:
# - module_include_dirs: List of directories to include
# - module_sources: List of source files from modules
# - cmakelist_include_paths: List of CMakeLists.txt files to include
function(process_modules)
    # Initialize variables in parent scope
    set(module_include_dirs "" PARENT_SCOPE)
    set(module_sources "" PARENT_SCOPE)
    set(cmakelist_include_paths "" PARENT_SCOPE)

    # Check if modules directory and init.txt exist
    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/modules")
        message(STATUS "Modules directory not found: ${CMAKE_SOURCE_DIR}/modules")
        return()
    endif()

    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/modules/init.txt")
        message(STATUS "Module init file not found: ${CMAKE_SOURCE_DIR}/modules/init.txt")
        return()
    endif()

    message(STATUS "")
    message(STATUS "=== Module Processing ===")
    message(STATUS "")

    # Track the init file to make sure a re-configure will happen on build if needed
    set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/modules/init.txt")

    # Initialize local variables
    set(local_module_include_dirs "")
    set(local_module_sources "")
    set(local_cmakelist_include_paths "")

    # Read entries from init.txt, filtering out comments and empty lines
    file(STRINGS ${CMAKE_SOURCE_DIR}/modules/init.txt INIT_FILE_ENTRIES REGEX "^[^#\n].*")

    foreach(entry ${INIT_FILE_ENTRIES})
        # Skip empty entries
        if("${entry}" STREQUAL "")
            continue()
        endif()

        # Handle directory entries
        if(IS_DIRECTORY "${CMAKE_SOURCE_DIR}/modules/${entry}")
            # Check if the module has its own CMakeLists.txt
            if(EXISTS "${CMAKE_SOURCE_DIR}/modules/${entry}/CMakeLists.txt")
                list(APPEND local_cmakelist_include_paths "${CMAKE_SOURCE_DIR}/modules/${entry}/CMakeLists.txt")
                continue()
            endif()

            # Recursively find all source files in the module directory
            file(GLOB_RECURSE module_files
                "${CMAKE_SOURCE_DIR}/modules/${entry}/*.cpp"
                "${CMAKE_SOURCE_DIR}/modules/${entry}/*.h")

            if(module_files)
                list(APPEND local_module_include_dirs "${CMAKE_SOURCE_DIR}/modules/${entry}")
                list(APPEND local_module_sources ${module_files})

                # Store files for later display
                foreach(file ${module_files})
                    list(APPEND files_to_display ${file})
                endforeach()
            endif()

        # Handle individual .cpp file entries
        elseif("${entry}" MATCHES "\\.cpp$")
            if(EXISTS "${CMAKE_SOURCE_DIR}/modules/${entry}")
                list(APPEND local_module_sources "${CMAKE_SOURCE_DIR}/modules/${entry}")
                list(APPEND files_to_display "${CMAKE_SOURCE_DIR}/modules/${entry}")
            else()
                message(WARNING "Module file not found: ${CMAKE_SOURCE_DIR}/modules/${entry}")
            endif()
        endif()
    endforeach()

    # Display files to be added in clean format
    if(DEFINED files_to_display AND files_to_display)
        message(STATUS "The following files will be added to the build:")

        foreach(file ${files_to_display})
            message(STATUS "  - ${file}")
        endforeach()
    else()
        message(STATUS "No additional files being added to the build")
    endif()

    # Set variables in parent scope
    set(module_include_dirs ${local_module_include_dirs} PARENT_SCOPE)
    set(module_sources ${local_module_sources} PARENT_SCOPE)
    set(cmakelist_include_paths ${local_cmakelist_include_paths} PARENT_SCOPE)

    # Log completion summary
    list(LENGTH local_module_include_dirs num_include_dirs)
    list(LENGTH local_module_sources num_source_files)
    list(LENGTH local_cmakelist_include_paths num_cmake_includes)

    message(STATUS "")
    message(STATUS "Module processing complete:")
    message(STATUS "  - Include directories: ${num_include_dirs}")
    message(STATUS "  - Source files:        ${num_source_files}")
    message(STATUS "  - CMake includes:      ${num_cmake_includes}")
endfunction()

# Function to include module CMakeLists.txt files
function(include_module_cmakelists cmakelist_paths)
    foreach(entry ${cmakelist_paths})
        if(NOT "${entry}" STREQUAL "" AND EXISTS "${entry}")
            message(STATUS "Including module CMakeLists.txt: ${entry}")
            include("${entry}")
        endif()
    endforeach()
endfunction()
