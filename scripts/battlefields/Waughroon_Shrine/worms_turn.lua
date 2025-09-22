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
                waughroonID.mob.FLAYER_FRANZ,
                waughroonID.mob.FLAYER_FRANZ + 1,
                waughroonID.mob.FLAYER_FRANZ + 2,
                waughroonID.mob.FLAYER_FRANZ + 3,
                waughroonID.mob.FLAYER_FRANZ + 4,
                waughroonID.mob.FLAYER_FRANZ + 5,
                waughroonID.mob.FLAYER_FRANZ + 6,
                waughroonID.mob.FLAYER_FRANZ + 7,
                waughroonID.mob.FLAYER_FRANZ + 8,
                waughroonID.mob.FLAYER_FRANZ + 9,
                waughroonID.mob.FLAYER_FRANZ + 10,
                waughroonID.mob.FLAYER_FRANZ + 11,
                waughroonID.mob.FLAYER_FRANZ + 12,
                waughroonID.mob.FLAYER_FRANZ + 13,
                waughroonID.mob.FLAYER_FRANZ + 14,
                waughroonID.mob.FLAYER_FRANZ + 15,
            },

            {
                waughroonID.mob.FLAYER_FRANZ + 17,
                waughroonID.mob.FLAYER_FRANZ + 18,
                waughroonID.mob.FLAYER_FRANZ + 19,
                waughroonID.mob.FLAYER_FRANZ + 20,
                waughroonID.mob.FLAYER_FRANZ + 21,
                waughroonID.mob.FLAYER_FRANZ + 22,
                waughroonID.mob.FLAYER_FRANZ + 23,
                waughroonID.mob.FLAYER_FRANZ + 24,
                waughroonID.mob.FLAYER_FRANZ + 25,
                waughroonID.mob.FLAYER_FRANZ + 26,
                waughroonID.mob.FLAYER_FRANZ + 27,
                waughroonID.mob.FLAYER_FRANZ + 28,
                waughroonID.mob.FLAYER_FRANZ + 29,
                waughroonID.mob.FLAYER_FRANZ + 30,
                waughroonID.mob.FLAYER_FRANZ + 31,
                waughroonID.mob.FLAYER_FRANZ + 32,
            },

            {
                waughroonID.mob.FLAYER_FRANZ + 34,
                waughroonID.mob.FLAYER_FRANZ + 35,
                waughroonID.mob.FLAYER_FRANZ + 36,
                waughroonID.mob.FLAYER_FRANZ + 37,
                waughroonID.mob.FLAYER_FRANZ + 38,
                waughroonID.mob.FLAYER_FRANZ + 39,
                waughroonID.mob.FLAYER_FRANZ + 40,
                waughroonID.mob.FLAYER_FRANZ + 41,
                waughroonID.mob.FLAYER_FRANZ + 42,
                waughroonID.mob.FLAYER_FRANZ + 43,
                waughroonID.mob.FLAYER_FRANZ + 44,
                waughroonID.mob.FLAYER_FRANZ + 45,
                waughroonID.mob.FLAYER_FRANZ + 46,
                waughroonID.mob.FLAYER_FRANZ + 47,
                waughroonID.mob.FLAYER_FRANZ + 48,
                waughroonID.mob.FLAYER_FRANZ + 49,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.NONE,                  weight = 125 }, -- nothing
        { itemId = xi.item.FIRE_SPIRIT_PACT,      weight = 125 }, -- fire_spirit_pact
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight = 125 }, -- scroll_of_phalanx
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 125 }, -- scroll_of_utsusemi_ni
        { itemId = xi.item.SCROLL_OF_ERASE,       weight = 125 }, -- scroll_of_erase
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,  weight = 125 }, -- scroll_of_ice_spikes
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,  weight = 125 }, -- scroll_of_absorb-str
        { itemId = xi.item.SCROLL_OF_REFRESH,     weight = 125 }, -- scroll_of_refresh
    },

    {
        { itemId = xi.item.NONE,              weight = 125 }, -- nothing
        { itemId = xi.item.ENHANCING_EARRING, weight = 125 }, -- enhancing_earring
        { itemId = xi.item.SPIRIT_TORQUE,     weight = 125 }, -- spirit_torque
        { itemId = xi.item.GUARDING_GORGET,   weight = 125 }, -- guarding_gorget
        { itemId = xi.item.NEMESIS_EARRING,   weight = 125 }, -- nemesis_earring
        { itemId = xi.item.EARTH_MANTLE,      weight = 125 }, -- earth_mantle
        { itemId = xi.item.STRIKE_SHIELD,     weight = 125 }, -- strike_shield
        { itemId = xi.item.SHIKAR_BOW,        weight = 125 }, -- shikar_bow
    },

    {
        { itemId = xi.item.OAK_LOG,      weight = 500 }, -- oak_log
        { itemId = xi.item.ROSEWOOD_LOG, weight = 500 }, -- rosewood_log
    },

    {
        { itemId = xi.item.GOLD_BEASTCOIN,    weight = 500 }, -- gold_beastcoin
        { itemId = xi.item.MYTHRIL_BEASTCOIN, weight = 500 }, -- mythril_beastcoin
    },

    {
        { itemId = xi.item.BLACK_PEARL, weight = 200 }, -- black_pearl
        { itemId = xi.item.AMETRINE,    weight = 200 }, -- ametrine
        { itemId = xi.item.YELLOW_ROCK, weight = 200 }, -- yellow_rock
        { itemId = xi.item.PERIDOT,     weight = 200 }, -- peridot
        { itemId = xi.item.TURQUOISE,   weight = 200 }, -- turquoise
    },

    {
        { itemId = xi.item.NONE,     weight = 800 }, -- nothing
        { itemId = xi.item.RERAISER, weight = 200 }, -- reraiser
    },
}

return content:register()
