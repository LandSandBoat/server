set(SOURCES
    ability_state.cpp
    ability_state.h
    attack_state.cpp
    attack_state.h
    death_state.cpp
    death_state.h
    despawn_state.cpp
    despawn_state.h
    inactive_state.cpp
    inactive_state.h
    item_state.cpp
    item_state.h
    magic_state.cpp
    magic_state.h
    mobskill_state.cpp
    mobskill_state.h
    raise_state.cpp
    raise_state.h
    range_state.cpp
    range_state.h
    respawn_state.cpp
    respawn_state.h
    state.cpp
    state.h
    trigger_state.cpp
    trigger_state.h
    weaponskill_state.cpp
    weaponskill_state.h)

add_library(ai_states OBJECT ${SOURCES})

target_link_libraries(ai_states
    PUBLIC
    common
    project_options
    #project_warnings
)
