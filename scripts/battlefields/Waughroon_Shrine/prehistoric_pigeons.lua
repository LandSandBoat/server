-----------------------------------
-- Prehistoric Pigeons
-- Waughroon Shrine KSNM30, Atropos Orb
-- !additem 1180
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.PREHISTORIC_PIGEONS,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 18,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.ATROPOS_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Titanis_Max', 'Titanis_Jax', 'Titanis_Xax', 'Titanis_Dax' })

content.loot =
{
    {
        { item = xi.item.MICHISHIBA_NO_TSUYU, weight = 217 }, -- Michishiba-no-tsuyu
        { item = xi.item.DISSECTOR,           weight = 174 }, -- Dissector
        { item = xi.item.COFFINMAKER,         weight = 333 }, -- Coffinmaker
        { item = xi.item.GRAVEDIGGER,         weight = 174 }, -- Gravedigger
    },

    {
        { item = xi.item.CLAYMORE_GRIP,    weight = 144 }, -- Claymore Grip
        { item = xi.item.DAMASCUS_INGOT,   weight = 275 }, -- Damascus Ingot
        { item = xi.item.GIANT_BIRD_PLUME, weight = 275 }, -- Giant Bird Plume
        { item = xi.item.POLE_GRIP,        weight = 203 }, -- Pole Grip
        { item = xi.item.SPEAR_STRAP,      weight = 116 }, -- Spear Strap
    },

    {
        { item = xi.item.ADAMAN_INGOT,     weight = 159 }, -- Adaman Ingot
        { item = xi.item.ORICHALCUM_INGOT, weight = 290 }, -- Orichalcum Ingot
        { item = xi.item.TITANIS_EARRING,  weight = 406 }, -- Titanis Earring
    },

    {
        { item = xi.item.EVOKERS_BOOTS,  weight = 159 }, -- Evokers Boots
        { item = xi.item.OSTREGER_MITTS, weight = 217 }, -- Ostreger Mitts
        { item = xi.item.PINEAL_HAT,     weight = 145 }, -- Pineal Hat
        { item = xi.item.TRACKERS_KECKS, weight = 159 }, -- Trackers Kecks
    },

    {
        { item = xi.item.CORAL_FRAGMENT,          weight = 101 }, -- Coral Fragment
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =  29 }, -- Chunk Of Darksteel Ore
        { item = xi.item.DEMON_HORN,              weight =  29 }, -- Demon Horn
        { item = xi.item.EBONY_LOG,               weight =  29 }, -- Ebony Log
        { item = xi.item.GOLD_INGOT,              weight = 101 }, -- Gold Ingot
        { item = xi.item.SPOOL_OF_GOLD_THREAD,    weight =  29 }, -- Spool Of Gold Thread
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight =  29 }, -- Chunk Of Mythril Ore
        { item = xi.item.PETRIFIED_LOG,           weight =  58 }, -- Petrified Log
        { item = xi.item.CHUNK_OF_PLATINUM_ORE,   weight =  14 }, -- Chunk Of Platinum Ore
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight =  58 }, -- Square Of Rainbow Cloth
        { item = xi.item.RAM_HORN,                weight =  14 }, -- Ram Horn
        { item = xi.item.SQUARE_OF_RAXA,          weight = 159 }, -- Square Of Raxa
        { item = xi.item.SPOOL_OF_MALBORO_FIBER,  weight =  72 }, -- Spool Of Malboro Fiber
    },

    {
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  87 }, -- Vial Of Black Beetle Blood
        { item = xi.item.DAMASCUS_INGOT,             weight =  14 }, -- Damascus Ingot
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  29 }, -- Square Of Damascene Cloth
        { item = xi.item.PHILOSOPHERS_STONE,         weight = 174 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER,            weight = 246 }, -- Phoenix Feather
        { item = xi.item.SQUARE_OF_RAXA,             weight = 159 }, -- Square Of Raxa
    },
}

return content:register()
