-----------------------------------
-- Steamed Sprouts
-- Balga's Dais BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.STEAMED_SPROUTS,
    maxPlayers       = 6,
    levelCap         = 40,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.STAR_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        balgasID.mob.DVOROVOI + 8,
        balgasID.mob.DVOROVOI + 17,
        balgasID.mob.DVOROVOI + 26,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                balgasID.mob.DVOROVOI,      -- Dvorovoi
                balgasID.mob.DVOROVOI + 1,  -- Domovoi
                balgasID.mob.DVOROVOI + 2,  -- Domovoi
                balgasID.mob.DVOROVOI + 3,  -- Domovoi
                balgasID.mob.DVOROVOI + 4,  -- Domovoi
                balgasID.mob.DVOROVOI + 5,  -- Domovoi
                balgasID.mob.DVOROVOI + 6,  -- Domovoi
                balgasID.mob.DVOROVOI + 7,  -- Domovoi
            },

            {
                balgasID.mob.DVOROVOI + 9,  -- Dvorovoi
                balgasID.mob.DVOROVOI + 10, -- Domovoi
                balgasID.mob.DVOROVOI + 11, -- Domovoi
                balgasID.mob.DVOROVOI + 12, -- Domovoi
                balgasID.mob.DVOROVOI + 13, -- Domovoi
                balgasID.mob.DVOROVOI + 14, -- Domovoi
                balgasID.mob.DVOROVOI + 15, -- Domovoi
                balgasID.mob.DVOROVOI + 16, -- Domovoi
            },

            {
                balgasID.mob.DVOROVOI + 18, -- Dvorovoi
                balgasID.mob.DVOROVOI + 19, -- Domovoi
                balgasID.mob.DVOROVOI + 20, -- Domovoi
                balgasID.mob.DVOROVOI + 21, -- Domovoi
                balgasID.mob.DVOROVOI + 22, -- Domovoi
                balgasID.mob.DVOROVOI + 23, -- Domovoi
                balgasID.mob.DVOROVOI + 24, -- Domovoi
                balgasID.mob.DVOROVOI + 25, -- Domovoi
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
        { itemId = xi.item.ENHANCING_EARRING,     weight =  5000 },
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
        { itemId = xi.item.BALANCE_BUCKLER,       weight =  5000 },
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
        { itemId = xi.item.SURVIVAL_BELT,         weight =  5000 },
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
        { itemId = xi.item.GUARDING_GORGET,       weight =  5000 },
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
