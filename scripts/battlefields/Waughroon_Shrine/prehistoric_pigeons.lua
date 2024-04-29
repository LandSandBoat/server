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
        { itemid = xi.item.MICHISHIBA_NO_TSUYU, droprate = 217 }, -- Michishiba-no-tsuyu
        { itemid = xi.item.DISSECTOR,           droprate = 174 }, -- Dissector
        { itemid = xi.item.COFFINMAKER,         droprate = 333 }, -- Coffinmaker
        { itemid = xi.item.GRAVEDIGGER,         droprate = 174 }, -- Gravedigger
    },

    {
        { itemid = xi.item.CLAYMORE_GRIP,    droprate = 144 }, -- Claymore Grip
        { itemid = xi.item.DAMASCUS_INGOT,   droprate = 275 }, -- Damascus Ingot
        { itemid = xi.item.GIANT_BIRD_PLUME, droprate = 275 }, -- Giant Bird Plume
        { itemid = xi.item.POLE_GRIP,        droprate = 203 }, -- Pole Grip
        { itemid = xi.item.SPEAR_STRAP,      droprate = 116 }, -- Spear Strap
    },

    {
        { itemid = xi.item.ADAMAN_INGOT,     droprate = 159 }, -- Adaman Ingot
        { itemid = xi.item.ORICHALCUM_INGOT, droprate = 290 }, -- Orichalcum Ingot
        { itemid = xi.item.TITANIS_EARRING,  droprate = 406 }, -- Titanis Earring
    },

    {
        { itemid = xi.item.EVOKERS_BOOTS,  droprate = 159 }, -- Evokers Boots
        { itemid = xi.item.OSTREGER_MITTS, droprate = 217 }, -- Ostreger Mitts
        { itemid = xi.item.PINEAL_HAT,     droprate = 145 }, -- Pineal Hat
        { itemid = xi.item.TRACKERS_KECKS, droprate = 159 }, -- Trackers Kecks
    },

    {
        { itemid = xi.item.CORAL_FRAGMENT,          droprate = 101 }, -- Coral Fragment
        { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,  droprate =  29 }, -- Chunk Of Darksteel Ore
        { itemid = xi.item.DEMON_HORN,              droprate =  29 }, -- Demon Horn
        { itemid = xi.item.EBONY_LOG,               droprate =  29 }, -- Ebony Log
        { itemid = xi.item.GOLD_INGOT,              droprate = 101 }, -- Gold Ingot
        { itemid = xi.item.SPOOL_OF_GOLD_THREAD,    droprate =  29 }, -- Spool Of Gold Thread
        { itemid = xi.item.CHUNK_OF_MYTHRIL_ORE,    droprate =  29 }, -- Chunk Of Mythril Ore
        { itemid = xi.item.PETRIFIED_LOG,           droprate =  58 }, -- Petrified Log
        { itemid = xi.item.CHUNK_OF_PLATINUM_ORE,   droprate =  14 }, -- Chunk Of Platinum Ore
        { itemid = xi.item.SQUARE_OF_RAINBOW_CLOTH, droprate =  58 }, -- Square Of Rainbow Cloth
        { itemid = xi.item.RAM_HORN,                droprate =  14 }, -- Ram Horn
        { itemid = xi.item.SQUARE_OF_RAXA,          droprate = 159 }, -- Square Of Raxa
        { itemid = xi.item.SPOOL_OF_MALBORO_FIBER,  droprate =  72 }, -- Spool Of Malboro Fiber
    },

    {
        { itemid = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, droprate =  87 }, -- Vial Of Black Beetle Blood
        { itemid = xi.item.DAMASCUS_INGOT,             droprate =  14 }, -- Damascus Ingot
        { itemid = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  droprate =  29 }, -- Square Of Damascene Cloth
        { itemid = xi.item.PHILOSOPHERS_STONE,         droprate = 174 }, -- Philosophers Stone
        { itemid = xi.item.PHOENIX_FEATHER,            droprate = 246 }, -- Phoenix Feather
        { itemid = xi.item.SQUARE_OF_RAXA,             droprate = 159 }, -- Square Of Raxa
    },
}

return content:register()
