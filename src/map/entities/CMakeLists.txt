set(SOURCES
    automatonentity.cpp
    automatonentity.h
    baseentity.cpp
    baseentity.h
    battleentity.cpp
    battleentity.h
    charentity.cpp
    charentity.h
    mobentity.cpp
    mobentity.h
    npcentity.cpp
    npcentity.h
    petentity.cpp
    petentity.h
    trustentity.cpp
    trustentity.h)

add_library(entities OBJECT ${SOURCES})

target_link_libraries(entities
    PUBLIC
    common
    project_options
    #project_warnings
)
