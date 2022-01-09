set(SOURCES
    attackutils.cpp
    attackutils.h
    battlefieldutils.cpp
    battlefieldutils.h
    battleutils.cpp
    battleutils.h
    blacklistutils.cpp
    blacklistutils.h
    blueutils.cpp
    blueutils.h
    charutils.cpp
    charutils.h
    fishingutils.cpp
    fishingutils.h
    gardenutils.cpp
    gardenutils.h
    guildutils.cpp
    guildutils.h
    instanceutils.cpp
    instanceutils.h
    itemutils.cpp
    itemutils.h
    jailutils.cpp
    jailutils.h
    mobutils.cpp
    mobutils.h
    moduleutils.cpp
    moduleutils.h
    petutils.cpp
    petutils.h
    puppetutils.cpp
    puppetutils.h
    synthutils.cpp
    synthutils.h
    trustutils.cpp
    trustutils.h
    zoneutils.cpp
    zoneutils.h)

add_library(utils STATIC ${SOURCES})

if(TRACY_ENABLE)
    target_link_libraries(utils PUBLIC tracy_client)
endif(TRACY_ENABLE)


target_link_libraries(utils
    PUBLIC
    common
    ai
    entities
    items
    lua_bindings
    packets
    PRIVATE
    project_options
    project_warnings
)
