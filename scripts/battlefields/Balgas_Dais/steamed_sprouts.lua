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
                balgasID.mob.DVOROVOI,
                balgasID.mob.DVOROVOI + 1,
                balgasID.mob.DVOROVOI + 2,
                balgasID.mob.DVOROVOI + 3,
                balgasID.mob.DVOROVOI + 4,
                balgasID.mob.DVOROVOI + 5,
                balgasID.mob.DVOROVOI + 6,
                balgasID.mob.DVOROVOI + 7,
            },

            {
                balgasID.mob.DVOROVOI + 9,
                balgasID.mob.DVOROVOI + 10,
                balgasID.mob.DVOROVOI + 11,
                balgasID.mob.DVOROVOI + 12,
                balgasID.mob.DVOROVOI + 13,
                balgasID.mob.DVOROVOI + 14,
                balgasID.mob.DVOROVOI + 15,
                balgasID.mob.DVOROVOI + 16,
            },

            {
                balgasID.mob.DVOROVOI + 18,
                balgasID.mob.DVOROVOI + 19,
                balgasID.mob.DVOROVOI + 20,
                balgasID.mob.DVOROVOI + 21,
                balgasID.mob.DVOROVOI + 22,
                balgasID.mob.DVOROVOI + 23,
                balgasID.mob.DVOROVOI + 24,
                balgasID.mob.DVOROVOI + 25,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { item = xi.item.GOLD_BEASTCOIN,    weight = 500 }, -- gold_beastcoin
        { item = xi.item.MYTHRIL_BEASTCOIN, weight = 500 }, -- mythril_beastcoin
    },

    {
        { item = xi.item.NONE,        weight = 750 }, -- nothing
        { item = xi.item.VILE_ELIXIR, weight = 250 }, -- vile_elixir
    },

    {
        { item = xi.item.NONE,              weight = 600 }, -- nothing
        { item = xi.item.SURVIVAL_BELT,     weight = 100 }, -- survival_belt
        { item = xi.item.GUARDING_GORGET,   weight = 100 }, -- guarding_gorget
        { item = xi.item.ENHANCING_EARRING, weight = 100 }, -- enhancing_earring
        { item = xi.item.BALANCE_BUCKLER,   weight = 100 }, -- balance_buckler
    },

    {
        { item = xi.item.WHITE_ROCK,       weight = 125 }, -- white_rock
        { item = xi.item.TRANSLUCENT_ROCK, weight = 125 }, -- translucent_rock
        { item = xi.item.PURPLE_ROCK,      weight = 125 }, -- purple_rock
        { item = xi.item.RED_ROCK,         weight = 125 }, -- red_rock
        { item = xi.item.BLUE_ROCK,        weight = 125 }, -- blue_rock
        { item = xi.item.YELLOW_ROCK,      weight = 125 }, -- yellow_rock
        { item = xi.item.GREEN_ROCK,       weight = 125 }, -- green_rock
        { item = xi.item.BLACK_ROCK,       weight = 125 }, -- black_rock
    },

    {
        { item = xi.item.GARNET,       weight =  50 }, -- garnet
        { item = xi.item.BLACK_PEARL,  weight =  50 }, -- black_pearl
        { item = xi.item.AMETRINE,     weight =  50 }, -- ametrine
        { item = xi.item.PAINITE,      weight =  50 }, -- painite
        { item = xi.item.PEARL,        weight =  50 }, -- pearl
        { item = xi.item.OAK_LOG,      weight = 100 }, -- oak_log
        { item = xi.item.GOSHENITE,    weight = 100 }, -- goshenite
        { item = xi.item.SPHENE,       weight = 100 }, -- sphene
        { item = xi.item.ROSEWOOD_LOG, weight = 100 }, -- rosewood_log
        { item = xi.item.TURQUOISE,    weight = 100 }, -- turquoise
        { item = xi.item.SAPPHIRE,     weight = 100 }, -- sapphire
        { item = xi.item.PERIDOT,      weight = 150 }, -- peridot
    },

    {
        { item = xi.item.NONE,                  weight = 125 }, -- nothing
        { item = xi.item.SCROLL_OF_REFRESH,     weight = 125 }, -- scroll_of_refresh
        { item = xi.item.FIRE_SPIRIT_PACT,      weight = 125 }, -- fire_spirit_pact
        { item = xi.item.SCROLL_OF_ERASE,       weight = 125 }, -- scroll_of_erase
        { item = xi.item.SCROLL_OF_ABSORB_STR,  weight = 125 }, -- scroll_of_absorb-str
        { item = xi.item.SCROLL_OF_PHALANX,     weight = 125 }, -- scroll_of_phalanx
        { item = xi.item.SCROLL_OF_ICE_SPIKES,  weight = 125 }, -- scroll_of_ice_spikes
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 125 }, -- scroll_of_utsusemi_ni
    },
}

return content:register()
