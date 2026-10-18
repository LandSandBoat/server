# Configure with -DENABLE_VALGRIND=ON, then build valgrind_memcheck_<server> or valgrind_callgrind_<server>.
# xi_add_executable calls xi_add_valgrind_targets, so every server gets them, forks' included.

option(ENABLE_VALGRIND "Add targets that run each server under Valgrind." OFF)
message(STATUS "ENABLE_VALGRIND: ${ENABLE_VALGRIND}")

if(ENABLE_VALGRIND)
    find_program(VALGRIND_COMMAND NAMES valgrind)
    message(STATUS "VALGRIND_COMMAND: ${VALGRIND_COMMAND}")
    if(NOT VALGRIND_COMMAND)
        message(FATAL_ERROR "ENABLE_VALGRIND is ON but valgrind is not found!")
    endif()
endif()

function(xi_add_valgrind_targets target)
    if(NOT ENABLE_VALGRIND)
        return()
    endif()

    add_custom_target(valgrind_memcheck_${target}
        COMMAND ${VALGRIND_COMMAND} --tool=memcheck --leak-check=full --show-reachable=yes
            --undef-value-errors=yes --track-origins=yes --child-silent-after-fork=no
            --trace-children=yes
            --log-file=${CMAKE_SOURCE_DIR}/${target}.memcheck.log
            ./${target}
        COMMENT "Writing memcheck log to: ${CMAKE_SOURCE_DIR}/${target}.memcheck.log"
        DEPENDS ${target}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    add_custom_target(valgrind_callgrind_${target}
        COMMAND ${VALGRIND_COMMAND} --tool=callgrind
            --log-file=${CMAKE_SOURCE_DIR}/${target}.callgrind.log
            ./${target}
        COMMENT "Writing callgrind log to: ${CMAKE_SOURCE_DIR}/${target}.callgrind.log"
        DEPENDS ${target}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
endfunction()
