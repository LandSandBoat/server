-----------------------------------
-- Contaminated Colosseum
-- Horlais Peak KSNM, Atropos Orb
-- !additem 1180
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.CONTAMINATED_COLOSSEUM,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 17,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.ATROPOS_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Evil_Oscar' })

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = 1000, amount = 24000 }, -- Gil
    },

    {
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER, weight = 1000 }, -- Spool Of Malboro Fiber
    },

    {
        { itemId = xi.item.MICHISHIBA_NO_TSUYU, weight = 217 }, -- Michishiba-no-tsuyu
        { itemId = xi.item.MORGENSTERN,         weight = 174 }, -- Morgenstern
        { itemId = xi.item.SENJUINRIKIO,        weight = 333 }, -- Senjuinrikio
        { itemId = xi.item.THYRSUSSTAB,         weight = 174 }, -- Thyrsusstab
    },

    {
        { itemId = xi.item.CASSIE_EARRING, weight = 101 }, -- Cassie Earring
        { itemId = xi.item.CLAYMORE_GRIP,  weight =  43 }, -- Claymore Grip
        { itemId = xi.item.MALBORO_VINE,   weight = 275 }, -- Malboro Vine
        { itemId = xi.item.MORBOLGER_VINE, weight = 275 }, -- Morbolger Vine
        { itemId = xi.item.POLE_GRIP,      weight = 203 }, -- Pole Grip
        { itemId = xi.item.SPEAR_STRAP,    weight = 116 }, -- Spear Strap
    },

    {
        { itemId = xi.item.ADAMAN_INGOT,     weight = 159 }, -- Adaman Ingot
        { itemId = xi.item.ORICHALCUM_INGOT, weight = 290 }, -- Orichalcum Ingot
        { itemId = xi.item.OSCAR_SCARF,      weight = 406 }, -- Oscar Scarf
    },

    {
        { itemId = xi.item.EVOKERS_BOOTS,  weight = 159 }, -- Evokers Boots
        { itemId = xi.item.OSTREGER_MITTS, weight = 217 }, -- Ostreger Mitts
        { itemId = xi.item.PINEAL_HAT,     weight = 145 }, -- Pineal Hat
        { itemId = xi.item.TRACKERS_KECKS, weight = 159 }, -- Trackers Kecks
    },

    {
        { itemId = xi.item.CORAL_FRAGMENT,           weight = 101 }, -- Coral Fragment
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  29 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.DEMON_HORN,               weight =  29 }, -- Demon Horn
        { itemId = xi.item.EBONY_LOG,                weight =  29 }, -- Ebony Log
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight = 101 }, -- Chunk Of Gold Ore
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  29 }, -- Spool Of Gold Thread
        { itemId = xi.item.SLAB_OF_GRANITE,          weight =  29 }, -- Slab Of Granite
        { itemId = xi.item.MAHOGANY_LOG,             weight =  43 }, -- Mahogany Log
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  29 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.PETRIFIED_LOG,            weight =  58 }, -- Petrified Log
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  14 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  58 }, -- Square Of Rainbow Cloth
        { itemId = xi.item.RAM_HORN,                 weight =  14 }, -- Ram Horn
        { itemId = xi.item.VILE_ELIXIR,              weight =  58 }, -- Vile Elixir
        { itemId = xi.item.VILE_ELIXIR_P1,           weight =  29 }, -- Vile Elixir +1
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  72 }, -- Handful Of Wyvern Scales
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  87 }, -- Vial Of Black Beetle Blood
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  14 }, -- Damascus Ingot
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  29 }, -- Square Of Damascene Cloth
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  43 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 174 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 246 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 159 }, -- Square Of Raxa
    },
}

return content:register()
