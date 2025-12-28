-----------------------------------
-- Under Observation
-- Horlais Peak BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.UNDER_OBSERVATION,
    maxPlayers       = 3,
    levelCap         = 40,
    timeLimit        = utils.minutes(15),
    index            = 12,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.STAR_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Sobbing_Eyes', 'Compound_Eyes' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                   weight = 10000, amount = 5000 },
    },

    {
        { itemId = xi.item.NONE,                  weight =  9000 },
        { itemId = xi.item.PEACOCK_CHARM,         weight =  1000 },
    },

    {
        { itemId = xi.item.BEHOURD_LANCE,         weight =  1000 },
        { itemId = xi.item.MUTILATOR,             weight =  1000 },
        { itemId = xi.item.RAIFU,                 weight =  1000 },
        { itemId = xi.item.TOURNEY_PATAS,         weight =  1000 },
        { itemId = xi.item.TILT_BELT,             weight =  4000 },
        { itemId = xi.item.BLACK_ROCK,            weight =   100 },
        { itemId = xi.item.BLUE_ROCK,             weight =   100 },
        { itemId = xi.item.GREEN_ROCK,            weight =   100 },
        { itemId = xi.item.PURPLE_ROCK,           weight =   100 },
        { itemId = xi.item.RED_ROCK,              weight =   100 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   100 },
        { itemId = xi.item.WHITE_ROCK,            weight =   100 },
        { itemId = xi.item.YELLOW_ROCK,           weight =   100 },
        { itemId = xi.item.AMETRINE,              weight =   100 },
        { itemId = xi.item.BLACK_PEARL,           weight =   100 },
        { itemId = xi.item.GARNET,                weight =   100 },
        { itemId = xi.item.GOSHENITE,             weight =   100 },
        { itemId = xi.item.PEARL,                 weight =   100 },
        { itemId = xi.item.PERIDOT,               weight =   100 },
        { itemId = xi.item.SPHENE,                weight =   100 },
        { itemId = xi.item.TURQUOISE,             weight =   100 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   100 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   100 },
        { itemId = xi.item.OAK_LOG,               weight =   100 },
        { itemId = xi.item.VILE_ELIXIR,           weight =   100 },
    },

    {
        { itemId = xi.item.BUZZARD_TUCK,          weight =  1000 },
        { itemId = xi.item.DE_SAINTRES_AXE,       weight =  1000 },
        { itemId = xi.item.GRUDGE_SWORD,          weight =  1000 },
        { itemId = xi.item.HIMMEL_STOCK,          weight =  1000 },
        { itemId = xi.item.MANTRA_BELT,           weight =  4000 },
        { itemId = xi.item.BLACK_ROCK,            weight =   100 },
        { itemId = xi.item.BLUE_ROCK,             weight =   100 },
        { itemId = xi.item.GREEN_ROCK,            weight =   100 },
        { itemId = xi.item.PURPLE_ROCK,           weight =   100 },
        { itemId = xi.item.RED_ROCK,              weight =   100 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   100 },
        { itemId = xi.item.WHITE_ROCK,            weight =   100 },
        { itemId = xi.item.YELLOW_ROCK,           weight =   100 },
        { itemId = xi.item.AMETRINE,              weight =   100 },
        { itemId = xi.item.BLACK_PEARL,           weight =   100 },
        { itemId = xi.item.GARNET,                weight =   100 },
        { itemId = xi.item.GOSHENITE,             weight =   100 },
        { itemId = xi.item.PEARL,                 weight =   100 },
        { itemId = xi.item.PERIDOT,               weight =   100 },
        { itemId = xi.item.SPHENE,                weight =   100 },
        { itemId = xi.item.TURQUOISE,             weight =   100 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   100 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   100 },
        { itemId = xi.item.OAK_LOG,               weight =   100 },
        { itemId = xi.item.RERAISER,              weight =   100 },
    },

    {
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight =  3000 },
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight =  2000 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight =  2000 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight =  3000 },
    },

    {
        { itemId = xi.item.FIRE_SPIRIT_PACT,      weight =  2000 },
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,  weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ERASE,       weight =  2000 },
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight =  2000 },
        { itemId = xi.item.BLACK_PEARL,           weight =  3000 },
    },

    {
        { itemId = xi.item.HECTEYES_EYE,          weight = 10000 },
    },

    {
        { itemId = xi.item.VIAL_OF_MERCURY,       weight = 10000 },
    },
}

return content:register()
