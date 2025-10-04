#
# CMake utility functions for target inspection and debugging
#

# Function to print all targets linked by a given target
# Usage: print_target_links(my_target)
function(print_target_links target_name)
    if(NOT TARGET ${target_name})
        message(WARNING "Target '${target_name}' does not exist")
        return()
    endif()

    message(STATUS "=== Target Links for '${target_name}' ===")

    # Get link libraries
    get_target_property(LINK_LIBRARIES ${target_name} LINK_LIBRARIES)

    if(LINK_LIBRARIES)
        message(STATUS "LINK_LIBRARIES:")

        foreach(lib ${LINK_LIBRARIES})
            message(STATUS "  - ${lib}")
        endforeach()
    else()
        message(STATUS "LINK_LIBRARIES: <none>")
    endif()

    # Get interface link libraries
    get_target_property(INTERFACE_LINK_LIBRARIES ${target_name} INTERFACE_LINK_LIBRARIES)

    if(INTERFACE_LINK_LIBRARIES)
        message(STATUS "INTERFACE_LINK_LIBRARIES:")

        foreach(lib ${INTERFACE_LINK_LIBRARIES})
            message(STATUS "  - ${lib}")
        endforeach()
    else()
        message(STATUS "INTERFACE_LINK_LIBRARIES: <none>")
    endif()

    # Get imported link interface libraries (for imported targets)
    get_target_property(IMPORTED_LINK_INTERFACE_LIBRARIES ${target_name} IMPORTED_LINK_INTERFACE_LIBRARIES)

    if(IMPORTED_LINK_INTERFACE_LIBRARIES)
        message(STATUS "IMPORTED_LINK_INTERFACE_LIBRARIES:")

        foreach(lib ${IMPORTED_LINK_INTERFACE_LIBRARIES})
            message(STATUS "  - ${lib}")
        endforeach()
    endif()

    # Get include directories
    get_target_property(INCLUDE_DIRECTORIES ${target_name} INCLUDE_DIRECTORIES)

    if(INCLUDE_DIRECTORIES)
        message(STATUS "INCLUDE_DIRECTORIES:")

        foreach(dir ${INCLUDE_DIRECTORIES})
            message(STATUS "  - ${dir}")
        endforeach()
    else()
        message(STATUS "INCLUDE_DIRECTORIES: <none>")
    endif()

    # Get interface include directories
    get_target_property(INTERFACE_INCLUDE_DIRECTORIES ${target_name} INTERFACE_INCLUDE_DIRECTORIES)

    if(INTERFACE_INCLUDE_DIRECTORIES)
        message(STATUS "INTERFACE_INCLUDE_DIRECTORIES:")

        foreach(dir ${INTERFACE_INCLUDE_DIRECTORIES})
            message(STATUS "  - ${dir}")
        endforeach()
    else()
        message(STATUS "INTERFACE_INCLUDE_DIRECTORIES: <none>")
    endif()

    message(STATUS "=== End Target Links for '${target_name}' ===")
endfunction()

# Function to print all available targets in the current scope
# Usage: print_all_targets()
function(print_all_targets)
    # Get all targets defined in the current directory and subdirectories
    get_property(targets DIRECTORY PROPERTY BUILDSYSTEM_TARGETS)
    get_property(imported_targets DIRECTORY PROPERTY IMPORTED_TARGETS)

    message(STATUS "=== All Available Targets ===")

    if(targets)
        message(STATUS "Local Targets:")

        foreach(target ${targets})
            get_target_property(target_type ${target} TYPE)
            message(STATUS "  - ${target} (${target_type})")
        endforeach()
    else()
        message(STATUS "Local Targets: <none>")
    endif()

    if(imported_targets)
        message(STATUS "Imported Targets:")

        foreach(target ${imported_targets})
            get_target_property(target_type ${target} TYPE)
            message(STATUS "  - ${target} (${target_type})")
        endforeach()
    else()
        message(STATUS "Imported Targets: <none>")
    endif()

    message(STATUS "=== End All Available Targets ===")
endfunction()

# Function to recursively print all dependencies of a target
# Usage: print_target_dependencies(my_target)
function(print_target_dependencies target_name)
    if(NOT TARGET ${target_name})
        message(WARNING "Target '${target_name}' does not exist")
        return()
    endif()

    message(STATUS "=== Recursive Dependencies for '${target_name}' ===")
    _print_target_dependencies_recursive(${target_name} 0 "")
    message(STATUS "=== End Recursive Dependencies ===")
endfunction()

# Internal helper function for recursive dependency printing
function(_print_target_dependencies_recursive target_name depth visited_targets)
    # Prevent infinite recursion
    list(FIND visited_targets ${target_name} found_index)

    if(NOT found_index EQUAL -1)
        return()
    endif()

    list(APPEND visited_targets ${target_name})

    # Create indentation
    string(REPEAT "  " ${depth} indent)

    # Print current target
    if(TARGET ${target_name})
        get_target_property(target_type ${target_name} TYPE)
        message(STATUS "${indent}- ${target_name} (${target_type})")
    else()
        message(STATUS "${indent}- ${target_name} (non-target)")
        return()
    endif()

    # Get and recurse through dependencies
    get_target_property(link_libraries ${target_name} LINK_LIBRARIES)

    if(link_libraries)
        math(EXPR next_depth "${depth} + 1")

        foreach(lib ${link_libraries})
            _print_target_dependencies_recursive(${lib} ${next_depth} "${visited_targets}")
        endforeach()
    endif()

    get_target_property(interface_link_libraries ${target_name} INTERFACE_LINK_LIBRARIES)

    if(interface_link_libraries)
        math(EXPR next_depth "${depth} + 1")

        foreach(lib ${interface_link_libraries})
            _print_target_dependencies_recursive(${lib} ${next_depth} "${visited_targets}")
        endforeach()
    endif()
endfunction()