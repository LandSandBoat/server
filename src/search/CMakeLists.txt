set(SOURCES
    data_loader.cpp
    data_loader.h
    enums/search_type.h
    search_listener.h
    search_application.h
    search_application.cpp
    search_engine.h
    search_engine.cpp
    search_handler.h
    search_handler.cpp
)

xi_add_library(xi_search_lib OBJECT ${SOURCES})
add_subdirectory(packets)
target_include_directories(xi_search_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(xi_search_lib PUBLIC xi_ext_search)

xi_add_executable(xi_search searchserver.rc ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
target_link_libraries(xi_search PRIVATE xi_search_lib)
