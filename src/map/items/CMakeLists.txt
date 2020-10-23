set(SOURCES
    item_currency.cpp
    item_currency.h
    item_equipment.cpp
    item_equipment.h
    item_fish.cpp
    item_fish.h
    item_flowerpot.cpp
    item_flowerpot.h
    item_furnishing.cpp
    item_furnishing.h
    item_general.cpp
    item_general.h
    item_linkshell.cpp
    item_linkshell.h
    item_puppet.cpp
    item_puppet.h
    item_shop.cpp
    item_shop.h
    item_usable.cpp
    item_usable.h
    item_weapon.cpp
    item_weapon.h
    item.cpp
    item.h)

add_library(items OBJECT ${SOURCES})

target_link_libraries(items
    PUBLIC
    common
    project_options
    #project_warnings
)
