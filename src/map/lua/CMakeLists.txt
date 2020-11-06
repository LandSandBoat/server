set(SOURCES
    lua_ability.cpp
    lua_ability.h
    lua_action.cpp
    lua_action.h
    lua_baseentity.cpp
    lua_baseentity.h
    lua_battlefield.cpp
    lua_battlefield.h
    lua_instance.cpp
    lua_instance.h
    lua_item.cpp
    lua_item.h
    lua_mobskill.cpp
    lua_mobskill.h
    lua_region.cpp
    lua_region.h
    lua_spell.cpp
    lua_spell.h
    lua_statuseffect.cpp
    lua_statuseffect.h
    lua_trade_container.cpp
    lua_trade_container.h
    lua_zone.cpp
    lua_zone.h
    luautils.cpp
    luautils.h)

add_library(lua STATIC ${SOURCES})

target_link_libraries(lua
    PUBLIC
    common
    project_options
    #project_warnings
)
