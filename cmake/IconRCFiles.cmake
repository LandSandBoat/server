#
# Windows icon/resource (.rc) file handling
#
# This module provides functions for mapping target names to their
# corresponding Windows resource files for executable icons.
#

# Function to get resource file for a target based on its name
function(get_target_resource_file target_name output_var)
    if(UNIX)
        set(${output_var} "" PARENT_SCOPE)
    else()
        # Map target names to their corresponding resource files
        if(${target_name} STREQUAL "xi_map")
            set(${output_var} "${CMAKE_SOURCE_DIR}/res/mapserver.rc" PARENT_SCOPE)
        elseif(${target_name} STREQUAL "xi_world")
            set(${output_var} "${CMAKE_SOURCE_DIR}/res/worldserver.rc" PARENT_SCOPE)
        elseif(${target_name} STREQUAL "xi_search")
            set(${output_var} "${CMAKE_SOURCE_DIR}/res/searchserver.rc" PARENT_SCOPE)
        elseif(${target_name} STREQUAL "xi_connect")
            set(${output_var} "${CMAKE_SOURCE_DIR}/res/connectserver.rc" PARENT_SCOPE)
        elseif(${target_name} STREQUAL "xi_test")
            set(${output_var} "${CMAKE_SOURCE_DIR}/res/testserver.rc" PARENT_SCOPE)
        else()
            # Default fallback - try to find a matching resource file
            if(EXISTS "${CMAKE_SOURCE_DIR}/res/${target_name}.rc")
                set(${output_var} "${CMAKE_SOURCE_DIR}/res/${target_name}.rc" PARENT_SCOPE)
            else()
                set(${output_var} "" PARENT_SCOPE)
            endif()
        endif()
    endif()
endfunction()