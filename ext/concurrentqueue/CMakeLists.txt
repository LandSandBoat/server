add_library(concurrentqueue INTERFACE)
target_sources(concurrentqueue INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/concurrentqueue/concurrentqueue.h)
target_include_directories(concurrentqueue SYSTEM INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/concurrentqueue/)
