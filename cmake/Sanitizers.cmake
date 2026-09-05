# Set your build to use these sanitizers by configuring with 'cmake -DCMAKE_BUILD_TYPE=UBSAN ..' etc.

# Build Types
set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE}
        CACHE STRING "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel TSAN ASAN LSAN MSAN UBSAN"
        FORCE)

# ThreadSanitizer
# ThreadSanitizer is a tool that detects data races. It consists of a compiler instrumentation module and a run-time library.
set(CMAKE_C_FLAGS_TSAN
        "-fsanitize=thread -fno-omit-frame-pointer -g1 -O1"
        CACHE STRING "Flags used by the C compiler during ThreadSanitizer builds."
        FORCE)
set(CMAKE_CXX_FLAGS_TSAN
        "-fsanitize=thread -fno-omit-frame-pointer -D_GLIBCXX_ASSERTIONS -g1 -O1"
        CACHE STRING "Flags used by the C++ compiler during ThreadSanitizer builds."
        FORCE)

# AddressSanitizer
# AddressSanitizer is a fast memory error detector. It consists of a compiler instrumentation module and a run-time library.
# ASAN also enables UndefinedBehaviorSanitizer so one instrumented build covers both in CI.
set(CMAKE_C_FLAGS_ASAN
        "-fsanitize=address,undefined,float-divide-by-zero -fsanitize-recover=all -fsanitize-address-use-after-scope -fno-optimize-sibling-calls -fno-omit-frame-pointer -g1 -O1"
        CACHE STRING "Flags used by the C compiler during AddressSanitizer builds."
        FORCE)
set(CMAKE_CXX_FLAGS_ASAN
        "-fsanitize=address,undefined,float-divide-by-zero -fsanitize-recover=all -fsanitize-address-use-after-scope -fno-optimize-sibling-calls -fno-omit-frame-pointer -D_GLIBCXX_ASSERTIONS -D_GLIBCXX_SANITIZE_VECTOR -g1 -O1"
        CACHE STRING "Flags used by the C++ compiler during AddressSanitizer builds."
        FORCE)

# LeakSanitizer
# LeakSanitizer is a run-time memory leak detector.
set(CMAKE_C_FLAGS_LSAN
        "-fsanitize=leak -fno-omit-frame-pointer -g -O1"
        CACHE STRING "Flags used by the C compiler during LeakSanitizer builds."
        FORCE)
set(CMAKE_CXX_FLAGS_LSAN
        "-fsanitize=leak -fno-omit-frame-pointer -g -O1"
        CACHE STRING "Flags used by the C++ compiler during LeakSanitizer builds."
        FORCE)

# MemorySanitizer
# MemorySanitizer is a detector of uninitialized reads. It consists of a compiler instrumentation module and a run-time library.
set(CMAKE_C_FLAGS_MSAN
        "-fsanitize=memory -fno-optimize-sibling-calls -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer -g -O2"
        CACHE STRING "Flags used by the C compiler during MemorySanitizer builds."
        FORCE)
set(CMAKE_CXX_FLAGS_MSAN
        "-fsanitize=memory -fno-optimize-sibling-calls -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer -g -O2"
        CACHE STRING "Flags used by the C++ compiler during MemorySanitizer builds."
        FORCE)

# UndefinedBehaviorSanitizer
# UndefinedBehaviorSanitizer is a run-time undefined behavior detector.
set(CMAKE_C_FLAGS_UBSAN
        "-fsanitize=undefined,float-divide-by-zero -fno-omit-frame-pointer -g1 -O2"
        CACHE STRING "Flags used by the C compiler during UndefinedBehaviorSanitizer builds."
        FORCE)
set(CMAKE_CXX_FLAGS_UBSAN
        "-fsanitize=undefined,float-divide-by-zero -fno-omit-frame-pointer -D_GLIBCXX_ASSERTIONS -g1 -O2"
        CACHE STRING "Flags used by the C++ compiler during UndefinedBehaviorSanitizer builds."
        FORCE)
