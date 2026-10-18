# Extra build types: configure with -DCMAKE_BUILD_TYPE=ASAN and so on. GCC and Clang flags only.

# C++ gets the flags plus cxx_extra: libstdc++'s assertion macros mean nothing to a C compile.
function(xi_add_sanitizer_build_type name flags cxx_extra)
    string(STRIP "${flags} ${cxx_extra}" cxx_flags)
    set(CMAKE_C_FLAGS_${name} "${flags}" CACHE STRING "Flags used by the C compiler during ${name} builds." FORCE)
    set(CMAKE_CXX_FLAGS_${name} "${cxx_flags}" CACHE STRING "Flags used by the C++ compiler during ${name} builds." FORCE)
endfunction()

xi_add_sanitizer_build_type(TSAN
    "-fsanitize=thread -fno-omit-frame-pointer -g1 -O1"
    "-D_GLIBCXX_ASSERTIONS")

# ASAN also enables UndefinedBehaviorSanitizer so one instrumented build covers both in CI.
xi_add_sanitizer_build_type(ASAN
    "-fsanitize=address,undefined,float-divide-by-zero -fsanitize-recover=all -fsanitize-address-use-after-scope -fno-optimize-sibling-calls -fno-omit-frame-pointer -g1 -O1"
    "-D_GLIBCXX_ASSERTIONS -D_GLIBCXX_SANITIZE_VECTOR")

xi_add_sanitizer_build_type(LSAN
    "-fsanitize=leak -fno-omit-frame-pointer -g -O1"
    "")

xi_add_sanitizer_build_type(MSAN
    "-fsanitize=memory -fno-optimize-sibling-calls -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer -g -O2"
    "")

xi_add_sanitizer_build_type(UBSAN
    "-fsanitize=undefined,float-divide-by-zero -fno-omit-frame-pointer -g1 -O2"
    "-D_GLIBCXX_ASSERTIONS")

# Neither LeakSanitizer nor MemorySanitizer has a Darwin runtime.
if(APPLE AND CMAKE_BUILD_TYPE MATCHES "^(LSAN|MSAN)$")
    message(FATAL_ERROR
        "CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} is not supported on macOS: Apple's toolchain "
        "ships no leak or memory sanitizer runtime for Darwin.\n"
        "ASAN (address + undefined), TSAN and UBSAN all work here; run ${CMAKE_BUILD_TYPE} on Linux.")
endif()
