# Enable these jobs on command-line by configuring with 'cmake -S . -B build -DENABLE_VALGRIND=ON'
# Launch with `cmake --build <your build folder> --target valgrind_memcheck_xi_search`, or whichever target you need below

option(ENABLE_VALGRIND "Run the server with Valgrind." OFF)
message(STATUS "ENABLE_VALGRIND: ${ENABLE_VALGRIND}")

if(ENABLE_VALGRIND)
    find_program(VALGRIND_COMMAND NAMES valgrind)
    message(STATUS "VALGRIND_COMMAND: ${VALGRIND_COMMAND}")

    if(NOT VALGRIND_COMMAND)
        message(FATAL_ERROR "ENABLE_VALGRIND is ON but valgrind is not found!")
    endif()

    add_custom_target(
        valgrind_memcheck_xi_connect
        COMMAND ${VALGRIND_COMMAND} --tool=memcheck --leak-check=full --show-reachable=yes
        --undef-value-errors=yes --track-origins=yes --child-silent-after-fork=no
        --trace-children=yes
        --log-file=${CMAKE_SOURCE_DIR}/xi_connect.memcheck.log
        ./xi_connect
        COMMENT "Writing memcheck log to: ${CMAKE_SOURCE_DIR}/xi_connect.memcheck.log"
        DEPENDS xi_connect
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    add_custom_target(
        valgrind_callgrind_xi_connect
        COMMAND ${VALGRIND_COMMAND} --tool=callgrind
        --log-file=${CMAKE_SOURCE_DIR}/xi_connect.callgrind.log
        ./xi_connect
        COMMENT "Writing callgrind log to: ${CMAKE_SOURCE_DIR}/xi_connect.callgrind.log"
        DEPENDS xi_connect
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    add_custom_target(
        valgrind_memcheck_xi_map
        COMMAND ${VALGRIND_COMMAND} --tool=memcheck --leak-check=full --show-reachable=yes
        --undef-value-errors=yes --track-origins=yes --child-silent-after-fork=no
        --trace-children=yes
        --log-file=${CMAKE_SOURCE_DIR}/xi_map.memcheck.log
        ./xi_map
        COMMENT "Writing memcheck log to: ${CMAKE_SOURCE_DIR}/xi_map.memcheck.log"
        DEPENDS xi_map
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    add_custom_target(
        valgrind_callgrind_xi_map
        COMMAND ${VALGRIND_COMMAND} --tool=callgrind
        --log-file=${CMAKE_SOURCE_DIR}/xi_map.callgrind.log
        ./xi_map
        COMMENT "Writing callgrind log to: ${CMAKE_SOURCE_DIR}/xi_map.callgrind.log"
        DEPENDS xi_map
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    add_custom_target(
        valgrind_memcheck_xi_search
        COMMAND ${VALGRIND_COMMAND} --tool=memcheck --leak-check=full --show-reachable=yes
        --undef-value-errors=yes --track-origins=yes --child-silent-after-fork=no
        --trace-children=yes
        --log-file=${CMAKE_SOURCE_DIR}/xi_search.memcheck.log
        ./xi_search
        COMMENT "Writing memcheck log to: ${CMAKE_SOURCE_DIR}/xi_search.memcheck.log"
        DEPENDS xi_search
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    add_custom_target(
        valgrind_callgrind_xi_search
        COMMAND ${VALGRIND_COMMAND} --tool=callgrind
        --log-file=${CMAKE_SOURCE_DIR}/xi_search.callgrind.log
        ./xi_search
        COMMENT "Writing callgrind log to: ${CMAKE_SOURCE_DIR}/xi_search.callgrind.log"
        DEPENDS xi_search
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
endif(ENABLE_VALGRIND)
