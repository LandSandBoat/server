# Configure with -DENABLE_FUZZING=ON to build packet_fuzzer.
# Clang only: AppleClang doesn't ship with libFuzzer.

option(ENABLE_FUZZING "Build the libFuzzer packet_fuzzer target (Clang, not AppleClang)." OFF)
message(STATUS "ENABLE_FUZZING: ${ENABLE_FUZZING}")

if(ENABLE_FUZZING)
    if(NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        message(FATAL_ERROR "ENABLE_FUZZING needs Clang with libFuzzer, not ${CMAKE_CXX_COMPILER_ID}.")
    endif()

    add_executable(packet_fuzzer ${CMAKE_SOURCE_DIR}/tools/fuzzer.cpp)
    target_compile_options(packet_fuzzer
        PUBLIC
            -g -O1 -fsanitize=fuzzer
    )

    target_link_libraries(packet_fuzzer
        PUBLIC
            -fsanitize=fuzzer
        PRIVATE
            project_options
            project_warnings
    )
endif()
