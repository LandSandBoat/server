message(STATUS "CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")
if(${CMAKE_SOURCE_DIR} MATCHES " +")
	set(STRIPPED_PATH "")
	STRING(REGEX REPLACE  " +" "_" STRIPPED_PATH "${CMAKE_SOURCE_DIR}")

	message(STATUS
		"Current path: ${CMAKE_SOURCE_DIR}\n"
		"Suggested path: ${STRIPPED_PATH}\n"
		"Your path contains spaces, this is not recommended.")
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "CMAKE_SIZEOF_VOID_P == 8: 64-bit build")
    set(platform_suffix "64")
    set(lib_dir lib64)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    message(STATUS "CMAKE_SIZEOF_VOID_P == 4: 32-bit build")
    if(WIN32)
        message(FATAL_ERROR "32-bit Windows builds are not supported")
    endif()
endif()

if(CMAKE_CONFIGURATION_TYPES STREQUAL Debug)
    set(lib_debug "-d")
else()
    set(lib_debug "")
endif()

set(libpath "lib${platform_suffix}")

if(WIN32)
    set(CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH OFF)
endif()
