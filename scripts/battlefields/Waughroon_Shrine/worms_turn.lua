-----------------------------------
-- The Worm's Turn
-- Waughroon Shrine BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.WORMS_TURN,
    maxPlayers       = 6,
    levelCap         = 40,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.STAR_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        waughroonID.mob.FLAYER_FRANZ + 16,
        waughroonID.mob.FLAYER_FRANZ + 33,
        waughroonID.mob.FLAYER_FRANZ + 50,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                waughroonID.mob.FLAYER_FRANZ,      -- Flayer Franz
                waughroonID.mob.FLAYER_FRANZ + 1,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 2,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 3,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 4,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 5,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 6,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 7,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 8,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 9,  -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 10, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 11, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 12, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 13, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 14, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 15, -- Flesh Eater
            },

            {
                waughroonID.mob.FLAYER_FRANZ + 17, -- Flayer Franz
                waughroonID.mob.FLAYER_FRANZ + 18, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 19, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 20, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 21, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 22, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 23, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 24, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 25, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 26, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 27, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 28, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 29, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 30, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 31, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 32, -- Flesh Eater
            },

            {
                waughroonID.mob.FLAYER_FRANZ + 34, -- Flayer Franz
                waughroonID.mob.FLAYER_FRANZ + 35, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 36, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 37, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 38, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 39, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 40, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 41, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 42, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 43, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 44, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 45, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 46, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 47, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 48, -- Flesh Eater
                waughroonID.mob.FLAYER_FRANZ + 49, -- Flesh Eater
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                   weight = 10000, amount = 6000 },
    },

    {
        { itemId = xi.item.SPIRIT_TORQUE,         weight =  5000 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight =   250 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   250 },
        { itemId = xi.item.BLACK_ROCK,            weight =   250 },
        { itemId = xi.item.BLUE_ROCK,             weight =   250 },
        { itemId = xi.item.GREEN_ROCK,            weight =   250 },
        { itemId = xi.item.PURPLE_ROCK,           weight =   250 },
        { itemId = xi.item.RED_ROCK,              weight =   250 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   250 },
        { itemId = xi.item.WHITE_ROCK,            weight =   250 },
        { itemId = xi.item.YELLOW_ROCK,           weight =   250 },
        { itemId = xi.item.AMETRINE,              weight =   250 },
        { itemId = xi.item.BLACK_PEARL,           weight =   250 },
        { itemId = xi.item.GARNET,                weight =   250 },
        { itemId = xi.item.GOSHENITE,             weight =   250 },
        { itemId = xi.item.PEARL,                 weight =   250 },
        { itemId = xi.item.PERIDOT,               weight =   250 },
        { itemId = xi.item.SPHENE,                weight =   250 },
        { itemId = xi.item.TURQUOISE,             weight =   250 },
        { itemId = xi.item.OAK_LOG,               weight =   250 },
        { itemId = xi.item.VILE_ELIXIR,           weight =   250 },
    },

    {
        { itemId = xi.item.NEMESIS_EARRING,       weight =  5000 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight =   250 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   250 },
        { itemId = xi.item.BLACK_ROCK,            weight =   250 },
        { itemId = xi.item.BLUE_ROCK,             weight =   250 },
        { itemId = xi.item.GREEN_ROCK,            weight =   250 },
        { itemId = xi.item.PURPLE_ROCK,           weight =   250 },
        { itemId = xi.item.RED_ROCK,              weight =   250 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   250 },
        { itemId = xi.item.WHITE_ROCK,            weight =   250 },
        { itemId = xi.item.YELLOW_ROCK,           weight =   250 },
        { itemId = xi.item.AMETRINE,              weight =   250 },
        { itemId = xi.item.BLACK_PEARL,           weight =   250 },
        { itemId = xi.item.GARNET,                weight =   250 },
        { itemId = xi.item.GOSHENITE,             weight =   250 },
        { itemId = xi.item.PEARL,                 weight =   250 },
        { itemId = xi.item.PERIDOT,               weight =   250 },
        { itemId = xi.item.SPHENE,                weight =   250 },
        { itemId = xi.item.TURQUOISE,             weight =   250 },
        { itemId = xi.item.OAK_LOG,               weight =   250 },
        { itemId = xi.item.RERAISER,              weight =   250 },
    },

    {
        { itemId = xi.item.EARTH_MANTLE,          weight =  5000 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight =   250 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   250 },
        { itemId = xi.item.BLACK_ROCK,            weight =   250 },
        { itemId = xi.item.BLUE_ROCK,             weight =   250 },
        { itemId = xi.item.GREEN_ROCK,            weight =   250 },
        { itemId = xi.item.PURPLE_ROCK,           weight =   250 },
        { itemId = xi.item.RED_ROCK,              weight =   250 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   250 },
        { itemId = xi.item.WHITE_ROCK,            weight =   250 },
        { itemId = xi.item.YELLOW_ROCK,           weight =   250 },
        { itemId = xi.item.AMETRINE,              weight =   250 },
        { itemId = xi.item.BLACK_PEARL,           weight =   250 },
        { itemId = xi.item.GARNET,                weight =   250 },
        { itemId = xi.item.GOSHENITE,             weight =   250 },
        { itemId = xi.item.PEARL,                 weight =   250 },
        { itemId = xi.item.PERIDOT,               weight =   250 },
        { itemId = xi.item.SPHENE,                weight =   250 },
        { itemId = xi.item.TURQUOISE,             weight =   250 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   250 },
        { itemId = xi.item.OAK_LOG,               weight =   250 },
    },

    {
        { itemId = xi.item.STRIKE_SHIELD,         weight =  5000 },
        { itemId = xi.item.GOLD_BEASTCOIN,        weight =   250 },
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight =   250 },
        { itemId = xi.item.BLACK_ROCK,            weight =   250 },
        { itemId = xi.item.BLUE_ROCK,             weight =   250 },
        { itemId = xi.item.GREEN_ROCK,            weight =   250 },
        { itemId = xi.item.PURPLE_ROCK,           weight =   250 },
        { itemId = xi.item.RED_ROCK,              weight =   250 },
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =   250 },
        { itemId = xi.item.WHITE_ROCK,            weight =   250 },
        { itemId = xi.item.YELLOW_ROCK,           weight =   250 },
        { itemId = xi.item.AMETRINE,              weight =   250 },
        { itemId = xi.item.BLACK_PEARL,           weight =   250 },
        { itemId = xi.item.GARNET,                weight =   250 },
        { itemId = xi.item.GOSHENITE,             weight =   250 },
        { itemId = xi.item.PEARL,                 weight =   250 },
        { itemId = xi.item.PERIDOT,               weight =   250 },
        { itemId = xi.item.SPHENE,                weight =   250 },
        { itemId = xi.item.TURQUOISE,             weight =   250 },
        { itemId = xi.item.ROSEWOOD_LOG,          weight =   250 },
        { itemId = xi.item.OAK_LOG,               weight =   250 },
    },

    {
        quantity = 2,
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight =   500 },
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight =  3000 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight =  1500 },
        { itemId = xi.item.FIRE_SPIRIT_PACT,      weight =  1500 },
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,  weight =   500 },
        { itemId = xi.item.SCROLL_OF_ERASE,       weight =  1500 },
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight =  1500 },
    },
}

return content:register()
