set(SOURCES
    automaton_controller.cpp
    automaton_controller.h
    controller.cpp
    controller.h
    mob_controller.cpp
    mob_controller.h
    pet_controller.cpp
    pet_controller.h
    player_charm_controller.cpp
    player_charm_controller.h
    player_controller.cpp
    player_controller.h
    trust_controller.cpp
    trust_controller.h)

add_library(ai_controllers OBJECT ${SOURCES})

target_link_libraries(ai_controllers
    PUBLIC
    common
    project_options
    #project_warnings
)
