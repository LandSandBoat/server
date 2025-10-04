#
# Python interpreter detection and configuration
#

# Find and configure Python interpreter
function(find_python)
    # Find Python (defines ${Python_EXECUTABLE})
    find_package(Python REQUIRED)
    message(STATUS "Python_EXECUTABLE: ${Python_EXECUTABLE}")
    message(STATUS "Python_VERSION: ${Python_VERSION}")

    # Validate Python version
    if(NOT ${Python_VERSION_MAJOR} EQUAL 3)
        message(FATAL_ERROR "Python 3 is required")
    endif()

    # Export Python executable to parent scope
    set(Python_EXECUTABLE ${Python_EXECUTABLE} PARENT_SCOPE)
endfunction()
