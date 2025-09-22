-----------------------------------
-- Shots in the Dark
-- Horlais Peak BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.SHOTS_IN_THE_DARK,
    maxPlayers       = 3,
    levelCap         = 60,
    timeLimit        = utils.minutes(15),
    index            = 14,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Orcish_Onager' })

content.loot =
{
    {
        { itemId = xi.item.GOLD_BEASTCOIN,    weight = 500 }, -- gold_beastcoin
        { itemId = xi.item.MYTHRIL_BEASTCOIN, weight = 500 }, -- mythril_beastcoin
    },

    {
        { itemId = xi.item.STEEL_INGOT, weight = 500 }, -- steel_ingot
        { itemId = xi.item.AQUAMARINE,  weight = 500 }, -- aquamarine
    },

    {
        { itemId = xi.item.NONE,         weight = 500 }, -- nothing
        { itemId = xi.item.DEMON_QUIVER, weight = 500 }, -- demon_quiver
    },

    {
        { itemId = xi.item.NONE,                weight = 600 }, -- nothing
        { itemId = xi.item.TELEPORT_RING_HOLLA, weight = 200 }, -- teleport_ring_holla
        { itemId = xi.item.TELEPORT_RING_VAHZL, weight = 200 }, -- teleport_ring_vahzl
    },

    {
        { itemId = xi.item.NONE,                weight = 600 }, -- nothing
        { itemId = xi.item.SAPIENT_CAPE,        weight = 200 }, -- sapient_cape
        { itemId = xi.item.TRAINERS_WRISTBANDS, weight = 200 }, -- trainers_wristbands
    },
}

return content:register()
