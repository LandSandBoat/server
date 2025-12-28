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
        { itemId = xi.item.GIL,                 weight = 10000, amount = 15000 },
    },

    {
        { itemId = xi.item.TELEPORT_RING_HOLLA, weight =  5000 },
        { itemId = xi.item.TELEPORT_RING_VAHZL, weight =  5000 },
    },

    {
        { itemId = xi.item.SAPIENT_CAPE,        weight =  6500 },
        { itemId = xi.item.TRAINERS_WRISTBANDS, weight =  3500 },
    },

    {
        quantity = 4,
        { itemId = xi.item.MYTHRIL_BEASTCOIN,   weight =  6000 },
        { itemId = xi.item.GOLD_BEASTCOIN,      weight =  3000 },
        { itemId = xi.item.PLATINUM_BEASTCOIN,  weight =  1000 },
    },

    {
        { itemId = xi.item.RED_ROCK,            weight =   400 },
        { itemId = xi.item.YELLOW_ROCK,         weight =   400 },
        { itemId = xi.item.BLUE_ROCK,           weight =   400 },
        { itemId = xi.item.GREEN_ROCK,          weight =   400 },
        { itemId = xi.item.TRANSLUCENT_ROCK,    weight =   400 },
        { itemId = xi.item.PURPLE_ROCK,         weight =   400 },
        { itemId = xi.item.WHITE_ROCK,          weight =   400 },
        { itemId = xi.item.BLACK_ROCK,          weight =   400 },
        { itemId = xi.item.AQUAMARINE,          weight =   400 },
        { itemId = xi.item.CHRYSOBERYL,         weight =   400 },
        { itemId = xi.item.FLUORITE,            weight =   400 },
        { itemId = xi.item.JADEITE,             weight =   400 },
        { itemId = xi.item.MOONSTONE,           weight =   400 },
        { itemId = xi.item.PAINITE,             weight =   400 },
        { itemId = xi.item.SUNSTONE,            weight =   400 },
        { itemId = xi.item.ZIRCON,              weight =   400 },
        { itemId = xi.item.MAHOGANY_LOG,        weight =   400 },
        { itemId = xi.item.EBONY_LOG,           weight =   400 },
        { itemId = xi.item.STEEL_INGOT,         weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,       weight =   400 },
        { itemId = xi.item.GOLD_INGOT,          weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,     weight =   400 },
        { itemId = xi.item.HI_RERAISER,         weight =   600 },
        { itemId = xi.item.VILE_ELIXIR_P1,      weight =   600 },
    },

    {
        quantity = 3,
        { itemId = xi.item.DEMON_QUIVER,        weight = 10000 },
    },
}

return content:register()
