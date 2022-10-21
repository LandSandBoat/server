# Target is automatically added if you're using clang
# AppleClang doesn't ship with libFuzzer
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Apple")
    add_executable(packet_fuzzer ${CMAKE_SOURCE_DIR}/tools/fuzzer.cpp)
    target_compile_options(packet_fuzzer
        PUBLIC
            -g -O1 -fsanitize=fuzzer
    )

    target_link_libraries(packet_fuzzer
        PUBLIC
            -fsanitize=fuzzer
    )
endif()
