# Configure with -DENABLE_VALGRIND=ON, then build valgrind_memcheck_<server> or valgrind_callgrind_<server>.

option(ENABLE_VALGRIND "Add targets that run each server under Valgrind." OFF)
message(STATUS "ENABLE_VALGRIND: ${ENABLE_VALGRIND}")

function(xi_add_valgrind_targets target)
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

if(ENABLE_VALGRIND)
    find_program(VALGRIND_COMMAND NAMES valgrind)
    message(STATUS "VALGRIND_COMMAND: ${VALGRIND_COMMAND}")
    if(NOT VALGRIND_COMMAND)
        message(FATAL_ERROR "ENABLE_VALGRIND is ON but valgrind is not found!")
    endif()

    foreach(server xi_connect xi_map xi_profile xi_search xi_world)
        xi_add_valgrind_targets(${server})
    endforeach()
endif()
