# fix when we can move to CMAKE ver 3.8.2+
#set_property(GLOBAL PROPERTY CXX_STANDARD 17)
#set_property(GLOBAL PROPERTY CXX_STANDARD_REQUIRED ON)
#set_property(GLOBAL PROPERTY CXX_EXTENSIONS ON)
#set_property(GLOBAL PROPERTY LINKER_LANGUAGE CXX)

add_definitions(-DFMT_HEADER_ONLY)

if(UNIX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17 -Wall -Werror -Wno-class-memaccess -Wno-restrict -Wno-format-overflow -Wno-sizeof-pointer-memaccess -Wno-maybe-uninitialized -Wno-stringop-truncation -Wno-sign-compare -fsigned-char")
else()
    # fix /std:latest once VS2017 CMAKE supports CXX_STANDARD
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++latest /W3 /WX")
    add_definitions(
        -D_CONSOLE
        -D_MBCS
        -DNOMINMAX
        -DFMT_USE_WINDOWS_H=0
        -D_CRT_SECURE_NO_WARNINGS
        -D_CRT_NONSTDC_NO_DEPRECATE
        /Ob2 # Inline Function Expansion
        /Oy- # Frame-Pointer Omission
        /MP # Build with Multiple Processes
    )

    if(CMAKE_CONFIGURATION_TYPES STREQUAL Debug)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /INCREMENTAL /SAFESEH:NO")
        add_definitions(
            /ZI # Omit Default Library Name
            /GR # Enable RTTI
        )
    else()
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /INCREMENTAL:NO /LTCG /OPT:REF /OPT:ICF")
        add_definitions(
            /Oi # Generate Intrinsic Functions
            /GL # Whole Program Optimization
            /Gy # Enable Function Level Linking
            /TP # C++ Source Files
        )
    endif()
endif()
