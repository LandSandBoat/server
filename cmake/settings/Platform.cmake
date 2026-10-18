message(STATUS "CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")
if(${CMAKE_SOURCE_DIR} MATCHES " +")
    set(STRIPPED_PATH "")
    STRING(REGEX REPLACE  " +" "_" STRIPPED_PATH "${CMAKE_SOURCE_DIR}")

    message(STATUS
        "Current path: ${CMAKE_SOURCE_DIR}\n"
        "Suggested path: ${STRIPPED_PATH}\n"
        "Your path contains spaces, this is not recommended.")
endif()

if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(FATAL_ERROR "Only 64-bit builds are supported")
endif()

if(WIN32)
    set(CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH OFF)
endif()

if(APPLE)
    # The modern Apple linker (ld_prime, Xcode 15+) warns when the same library
    # appears more than once on the link line. CMake's dependency propagation
    # legitimately repeats static libs (historically required by classic ld64),
    # so the warning is pure noise: silence it where the linker supports the flag.
    include(CheckLinkerFlag)
    check_linker_flag(CXX "-Wl,-no_warn_duplicate_libraries" LINKER_SUPPORTS_NO_WARN_DUPLICATE_LIBRARIES)
    if(LINKER_SUPPORTS_NO_WARN_DUPLICATE_LIBRARIES)
        add_link_options("-Wl,-no_warn_duplicate_libraries")
    endif()
endif()
