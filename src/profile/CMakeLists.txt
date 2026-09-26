xi_add_library(xi_profile_lib
    profile_application.h
    profile_application.cpp
    profile_engine.h
    profile_engine.cpp
)
target_include_directories(xi_profile_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

xi_add_executable(xi_profile profileserver.rc ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
target_link_libraries(xi_profile PRIVATE xi_profile_lib)
