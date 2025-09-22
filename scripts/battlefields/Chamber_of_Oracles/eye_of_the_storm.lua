-----------------------------------
-- Eye of the Storm
-- Chamber of Oracles KSNM30, Lachesis Orb
-- !additem 1178
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId    = xi.battlefield.id.EYE_OF_THE_STORM,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 6,
    entryNpc         = 'SC_Entrance',
    exitNpc          = 'Shimmering_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = chamberOfOraclesID.text.A_CRACK_HAS_FORMED, wornMessage = chamberOfOraclesID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Radiant_Wyvern', 'Blizzard_Wyvern', 'Lightning_Wyvern', 'Chaos_Wyvern' })

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = 1000, amount = 24000 }, -- Gil
    },

    {
        { itemId = xi.item.WYVERN_WING, weight = 1000 }, -- Wyvern Wing
    },

    {
        { itemId = xi.item.WYVERN_SKIN, weight = 1000 }, -- Wyvern Skin
    },

    {
        { itemId = xi.item.GIL, weight = 1000, amount = 24000 }, -- gil

    },

    {
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight = 216 }, -- Damascene Cloth
        { itemId = xi.item.DAMASCUS_INGOT,             weight = 295 }, -- Damascus Ingot
        { itemId = xi.item.WOODVILLES_AXE,             weight = 239 }, -- Woodville's Axe
        { itemId = xi.item.THANATOS_BASELARD,          weight = 231 }, -- Thanatos Baselard
        { itemId = xi.item.WYVERN_PERCH,               weight = 231 }, -- Wyvern Perch
        { itemId = xi.item.BALINS_SWORD,               weight = 231 }, -- Balin's Sword
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 231 }, -- Beetle Blood
    },

    {
        { itemId = xi.item.BOURDONASSE,    weight = 104 }, -- Bourdonasse
        { itemId = xi.item.VILE_ELIXIR_P1, weight =  86 }, -- Vile Elixir +1
        { itemId = xi.item.VILE_ELIXIR,    weight =  22 }, -- Vile Elixir
        { itemId = xi.item.POLE_GRIP,      weight = 146 }, -- Pole Grip
        { itemId = xi.item.SWORD_STRAP,    weight = 240 }, -- Sword Strap
    },

    {
        { itemId = xi.item.ZISKAS_CROSSBOW,       weight = 287 }, -- Ziska's Crossbow
        { itemId = xi.item.UNJI,                  weight = 216 }, -- Unji
        { itemId = xi.item.TAILLEFERS_DAGGER,     weight = 198 }, -- Taillifer's Dagger
        { itemId = xi.item.SCHILTRON_SPEAR,       weight = 287 }, -- Schiltron Spear
        { itemId = xi.item.SCROLL_OF_THUNDER_III, weight = 287 }, -- Thunder III
    },

    {
        { itemId = xi.item.CORAL_FRAGMENT,          weight =  52 }, -- Coral Fragment
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =  56 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.DEMON_HORN,              weight =  41 }, -- Demon Horn
        { itemId = xi.item.EBONY_LOG,               weight =  63 }, -- Ebony Log
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,       weight =  52 }, -- Chunk Of Gold Ore
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,    weight =  26 }, -- Spool Of Gold Thread
        { itemId = xi.item.SLAB_OF_GRANITE,         weight =  11 }, -- Slab Of Granite
        { itemId = xi.item.HI_RERAISER,             weight =  37 }, -- Hi-reraiser
        { itemId = xi.item.MAHOGANY_LOG,            weight = 101 }, -- Mahogany Log
        { itemId = xi.item.MYTHRIL_INGOT,           weight =  30 }, -- Mythril Ingot
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight =  52 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.PETRIFIED_LOG,           weight = 116 }, -- Petrified Log
        { itemId = xi.item.PHOENIX_FEATHER,         weight =  15 }, -- Phoenix Feather
        { itemId = xi.item.PHILOSOPHERS_STONE,      weight =  56 }, -- Philosophers Stone
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,   weight =  45 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight =  22 }, -- Square Of Rainbow Cloth
        { itemId = xi.item.RAM_HORN,                weight =  67 }, -- Ram Horn
        { itemId = xi.item.SQUARE_OF_RAXA,          weight = 119 }, -- Square Of Raxa
        { itemId = xi.item.RERAISER,                weight =  45 }, -- Reraiser
        { itemId = xi.item.NONE,                    weight = 400 }, -- Nothing
    },

    {
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH, weight =  56 }, -- Square Of Damascene Cloth
        { itemId = xi.item.DAMASCUS_INGOT,            weight =  93 }, -- Damascus Ingot
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,    weight =  56 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.PHILOSOPHERS_STONE,        weight = 157 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER,           weight = 176 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_RAXA,            weight = 109 }, -- Square Of Raxa
        { itemId = xi.item.NONE,                      weight = 500 }, -- Nothing
    }
}

return content:register()
