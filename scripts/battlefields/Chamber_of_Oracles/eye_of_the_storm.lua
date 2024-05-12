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
        { item = xi.item.WYVERN_WING, weight = 1000 }, -- Wyvern Wing
    },

    {
        { item = xi.item.WYVERN_SKIN, weight = 1000 }, -- Wyvern Skin
    },

    {
        { item = xi.item.GIL, weight = 1000, amount = 24000 }, -- gil

    },

    {
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight = 216 }, -- Damascene Cloth
        { item = xi.item.DAMASCUS_INGOT,             weight = 295 }, -- Damascus Ingot
        { item = xi.item.WOODVILLES_AXE,             weight = 239 }, -- Woodville's Axe
        { item = xi.item.THANATOS_BASELARD,          weight = 231 }, -- Thanatos Baselard
        { item = xi.item.WYVERN_PERCH,               weight = 231 }, -- Wyvern Perch
        { item = xi.item.BALINS_SWORD,               weight = 231 }, -- Balin's Sword
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 231 }, -- Beetle Blood
    },

    {
        { item = xi.item.BOURDONASSE,    weight = 104 }, -- Bourdonasse
        { item = xi.item.VILE_ELIXIR_P1, weight =  86 }, -- Vile Elixir +1
        { item = xi.item.VILE_ELIXIR,    weight =  22 }, -- Vile Elixir
        { item = xi.item.POLE_GRIP,      weight = 146 }, -- Pole Grip
        { item = xi.item.SWORD_STRAP,    weight = 240 }, -- Sword Strap
    },

    {
        { item = xi.item.ZISKAS_CROSSBOW,       weight = 287 }, -- Ziska's Crossbow
        { item = xi.item.UNJI,                  weight = 216 }, -- Unji
        { item = xi.item.TAILLEFERS_DAGGER,     weight = 198 }, -- Taillifer's Dagger
        { item = xi.item.SCHILTRON_SPEAR,       weight = 287 }, -- Schiltron Spear
        { item = xi.item.SCROLL_OF_THUNDER_III, weight = 287 }, -- Thunder III
    },

    {
        { item = xi.item.CORAL_FRAGMENT,          weight =  52 }, -- Coral Fragment
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =  56 }, -- Chunk Of Darksteel Ore
        { item = xi.item.DEMON_HORN,              weight =  41 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,               weight =  63 }, -- Ebony Log
        { item = xi.item.CHUNK_OF_GOLD_ORE,       weight =  52 }, -- Chunk Of Gold Ore
        { item = xi.item.SPOOL_OF_GOLD_THREAD,    weight =  26 }, -- Spool Of Gold Thread
        { item = xi.item.SLAB_OF_GRANITE,         weight =  11 }, -- Slab Of Granite
        { item = xi.item.HI_RERAISER,             weight =  37 }, -- Hi-reraiser
        { item = xi.item.MAHOGANY_LOG,            weight = 101 }, -- Mahogany Log
        { item = xi.item.MYTHRIL_INGOT,           weight =  30 }, -- Mythril Ingot
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight =  52 }, -- Chunk Of Mythril Ore
        { item = xi.item.PETRIFIED_LOG,           weight = 116 }, -- Petrified Log
        { item = xi.item.PHOENIX_FEATHER,         weight =  15 }, -- Phoenix Feather
        { item = xi.item.PHILOSOPHERS_STONE,      weight =  56 }, -- Philosophers Stone
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,   weight =  45 }, -- Chunk Of Platinum Ore
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight =  22 }, -- Square Of Rainbow Cloth
        { item = xi.item.RAM_HORN,                weight =  67 }, -- Ram Horn
        { item = xi.item.SQUARE_OF_RAXA,          weight = 119 }, -- Square Of Raxa
        { item = xi.item.RERAISER,                weight =  45 }, -- Reraiser
        { item = xi.item.NONE,                    weight = 400 }, -- Nothing
    },

    {
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH, weight =  56 }, -- Square Of Damascene Cloth
        { item = xi.item.DAMASCUS_INGOT,            weight =  93 }, -- Damascus Ingot
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,    weight =  56 }, -- Spool Of Malboro Fiber
        { item = xi.item.PHILOSOPHERS_STONE,        weight = 157 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER,           weight = 176 }, -- Phoenix Feather
        { item = xi.item.SQUARE_OF_RAXA,            weight = 109 }, -- Square Of Raxa
        { item = xi.item.NONE,                      weight = 500 }, -- Nothing
    }
}

return content:register()
