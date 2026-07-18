add_library(spscqueue INTERFACE)
target_sources(spscqueue INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include/rigtorp/SPSCQueue.h)
target_include_directories(spscqueue SYSTEM INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include/)
