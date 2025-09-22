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
        { itemId = xi.item.MICHISHIBA_NO_TSUYU, weight = 217 }, -- Michishiba-no-tsuyu
        { itemId = xi.item.DISSECTOR,           weight = 174 }, -- Dissector
        { itemId = xi.item.COFFINMAKER,         weight = 333 }, -- Coffinmaker
        { itemId = xi.item.GRAVEDIGGER,         weight = 174 }, -- Gravedigger
    },

    {
        { itemId = xi.item.CLAYMORE_GRIP,    weight = 144 }, -- Claymore Grip
        { itemId = xi.item.DAMASCUS_INGOT,   weight = 275 }, -- Damascus Ingot
        { itemId = xi.item.GIANT_BIRD_PLUME, weight = 275 }, -- Giant Bird Plume
        { itemId = xi.item.POLE_GRIP,        weight = 203 }, -- Pole Grip
        { itemId = xi.item.SPEAR_STRAP,      weight = 116 }, -- Spear Strap
    },

    {
        { itemId = xi.item.ADAMAN_INGOT,     weight = 159 }, -- Adaman Ingot
        { itemId = xi.item.ORICHALCUM_INGOT, weight = 290 }, -- Orichalcum Ingot
        { itemId = xi.item.TITANIS_EARRING,  weight = 406 }, -- Titanis Earring
    },

    {
        { itemId = xi.item.EVOKERS_BOOTS,  weight = 159 }, -- Evokers Boots
        { itemId = xi.item.OSTREGER_MITTS, weight = 217 }, -- Ostreger Mitts
        { itemId = xi.item.PINEAL_HAT,     weight = 145 }, -- Pineal Hat
        { itemId = xi.item.TRACKERS_KECKS, weight = 159 }, -- Trackers Kecks
    },

    {
        { itemId = xi.item.CORAL_FRAGMENT,          weight = 101 }, -- Coral Fragment
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =  29 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.DEMON_HORN,              weight =  29 }, -- Demon Horn
        { itemId = xi.item.EBONY_LOG,               weight =  29 }, -- Ebony Log
        { itemId = xi.item.GOLD_INGOT,              weight = 101 }, -- Gold Ingot
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,    weight =  29 }, -- Spool Of Gold Thread
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight =  29 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.PETRIFIED_LOG,           weight =  58 }, -- Petrified Log
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,   weight =  14 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight =  58 }, -- Square Of Rainbow Cloth
        { itemId = xi.item.RAM_HORN,                weight =  14 }, -- Ram Horn
        { itemId = xi.item.SQUARE_OF_RAXA,          weight = 159 }, -- Square Of Raxa
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,  weight =  72 }, -- Spool Of Malboro Fiber
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  87 }, -- Vial Of Black Beetle Blood
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  14 }, -- Damascus Ingot
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  29 }, -- Square Of Damascene Cloth
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 174 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 246 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 159 }, -- Square Of Raxa
    },
}

return content:register()
