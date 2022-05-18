# Enable these jobs on command-line with 'cmake -DENABLE_VALGRIND=ON ..'

option(ENABLE_VALGRIND "Run the server with Valgrind." OFF)
message(STATUS "ENABLE_VALGRIND: ${ENABLE_VALGRIND}")

if(ENABLE_VALGRIND)
  find_program(VALGRIND_COMMAND NAMES valgrind)
  message(STATUS "VALGRIND_COMMAND: ${VALGRIND_COMMAND}")
  if(NOT VALGRIND_COMMAND)
    message(FATAL_ERROR "ENABLE_VALGRIND is ON but valgrind is not found!")
  endif()

  add_custom_target(
    valgrind_memcheck_xi_game
    COMMAND ${VALGRIND_COMMAND} --tool=memcheck --leak-check=full --show-reachable=yes
          --undef-value-errors=yes --track-origins=no --child-silent-after-fork=no
          --trace-children=no
          --log-file=${CMAKE_SOURCE_DIR}/xi_game.memcheck.log
          ./xi_game
    COMMENT "Writing memcheck log to: ${CMAKE_SOURCE_DIR}/xi_game.memcheck.log"
    DEPENDS xi_game
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  )

  add_custom_target(
          valgrind_callgrind_xi_game
          COMMAND ${VALGRIND_COMMAND} --tool=callgrind
          --log-file=${CMAKE_SOURCE_DIR}/xi_game.callgrind.log
          ./xi_game
          COMMENT "Writing callgrind log to: ${CMAKE_SOURCE_DIR}/xi_game.callgrind.log"
          DEPENDS xi_game
          WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  )
endif(ENABLE_VALGRIND)
