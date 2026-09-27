xi_add_library(xi_profile_lib
    profile_application.h
    profile_application.cpp
    profile_engine.h
    profile_engine.cpp
    stream.h
)
target_include_directories(xi_profile_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(data)
add_subdirectory(enums)
add_subdirectory(irc)
add_subdirectory(protocol)

xi_add_executable(xi_profile profileserver.rc ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
target_link_libraries(xi_profile PRIVATE xi_profile_lib)
