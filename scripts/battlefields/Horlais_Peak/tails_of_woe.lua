-----------------------------------
-- Tails of Woe
-- Horlais Peak BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.TAILS_OF_WOE,
    maxPlayers       = 6,
    levelCap         = 40,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.STAR_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        horlaisID.mob.HELLTAIL_HARRY + 8,
        horlaisID.mob.HELLTAIL_HARRY + 17,
        horlaisID.mob.HELLTAIL_HARRY + 26,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                horlaisID.mob.HELLTAIL_HARRY,
                horlaisID.mob.HELLTAIL_HARRY + 1,
                horlaisID.mob.HELLTAIL_HARRY + 2,
                horlaisID.mob.HELLTAIL_HARRY + 3,
                horlaisID.mob.HELLTAIL_HARRY + 4,
                horlaisID.mob.HELLTAIL_HARRY + 5,
                horlaisID.mob.HELLTAIL_HARRY + 6,
                horlaisID.mob.HELLTAIL_HARRY + 7,
            },

            {
                horlaisID.mob.HELLTAIL_HARRY + 9,
                horlaisID.mob.HELLTAIL_HARRY + 10,
                horlaisID.mob.HELLTAIL_HARRY + 11,
                horlaisID.mob.HELLTAIL_HARRY + 12,
                horlaisID.mob.HELLTAIL_HARRY + 13,
                horlaisID.mob.HELLTAIL_HARRY + 14,
                horlaisID.mob.HELLTAIL_HARRY + 15,
                horlaisID.mob.HELLTAIL_HARRY + 16,
            },

            {
                horlaisID.mob.HELLTAIL_HARRY + 18,
                horlaisID.mob.HELLTAIL_HARRY + 19,
                horlaisID.mob.HELLTAIL_HARRY + 20,
                horlaisID.mob.HELLTAIL_HARRY + 21,
                horlaisID.mob.HELLTAIL_HARRY + 22,
                horlaisID.mob.HELLTAIL_HARRY + 23,
                horlaisID.mob.HELLTAIL_HARRY + 24,
                horlaisID.mob.HELLTAIL_HARRY + 25,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.BLITZ_RING, weight = 150 }, -- blitz Ring
        { itemId = xi.item.NONE,       weight = 850 }, -- Nothing
    },

    {
        { itemId = xi.item.AEGIS_RING,    weight = 300 }, -- aegis Ring
        { itemId = xi.item.TUNDRA_MANTLE, weight = 200 }, -- tundra mantle
        { itemId = xi.item.DRUIDS_ROPE,   weight = 200 }, -- druids rope
        { itemId = xi.item.NONE,          weight = 300 }, -- Nothing
    },

    {
        { itemId = xi.item.FIRE_SPIRIT_PACT,     weight = 145 }, -- firespirit
        { itemId = xi.item.SCROLL_OF_ERASE,      weight = 165 }, -- erase
        { itemId = xi.item.SCROLL_OF_PHALANX,    weight = 140 }, -- phalanx
        { itemId = xi.item.SCROLL_OF_ABSORB_STR, weight = 123 }, -- absorb-str
        { itemId = xi.item.PERIDOT,              weight =  94 }, -- peridot
        { itemId = xi.item.PEARL,                weight =  94 }, -- pearl
        { itemId = xi.item.GREEN_ROCK,           weight =  13 }, -- green rock
        { itemId = xi.item.AMETRINE,             weight =  53 }, -- ametrine
        { itemId = xi.item.GOLD_BEASTCOIN,       weight =  70 }, -- gold beastcoin
        { itemId = xi.item.MYTHRIL_BEASTCOIN,    weight =  50 }, -- mythril beastcoin
        { itemId = xi.item.YELLOW_ROCK,          weight =  53 }, -- yellow rock
        { itemId = xi.item.NONE,                 weight =   0 }, -- nothing
    },

    {
        { itemId = xi.item.SCROLL_OF_ERASE,      weight = 125 }, -- erase
        { itemId = xi.item.SCROLL_OF_PHALANX,    weight = 110 }, -- phalanx
        { itemId = xi.item.SCROLL_OF_ABSORB_STR, weight = 104 }, -- absorb-str
        { itemId = xi.item.PERIDOT,              weight =  94 }, -- peridot
        { itemId = xi.item.PEARL,                weight =  94 }, -- pearl
        { itemId = xi.item.GREEN_ROCK,           weight =  53 }, -- green rock
        { itemId = xi.item.AMETRINE,             weight =  73 }, -- ametrine
        { itemId = xi.item.GOLD_BEASTCOIN,       weight =  70 }, -- gold beastcoin
        { itemId = xi.item.MYTHRIL_BEASTCOIN,    weight =  70 }, -- mythril beastcoin
        { itemId = xi.item.YELLOW_ROCK,          weight =  73 }, -- yellow rock
        { itemId = xi.item.NONE,                 weight =  94 }, -- nothing
    },

    {
        { itemId = xi.item.FIRE_SPIRIT_PACT,      weight = 174 }, -- firespirit
        { itemId = xi.item.SCROLL_OF_ERASE,       weight =  16 }, -- vile elixir
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight = 114 }, -- icespikes
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,  weight = 174 }, -- refresh
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 138 }, -- utsusemi ni
        { itemId = xi.item.GREEN_ROCK,            weight =  18 }, -- green rock
        { itemId = xi.item.BLACK_ROCK,            weight =  18 }, -- black rock
        { itemId = xi.item.BLUE_ROCK,             weight =  17 }, -- blue rock
        { itemId = xi.item.RED_ROCK,              weight =  16 }, -- red rock
        { itemId = xi.item.PURPLE_ROCK,           weight =  16 }, -- purple rock
        { itemId = xi.item.WHITE_ROCK,            weight =  16 }, -- white rock
        { itemId = xi.item.YELLOW_ROCK,           weight =  17 }, -- yellow rock
        { itemId = xi.item.TRANSLUCENT_ROCK,      weight =  17 }, -- translucent rock
        { itemId = xi.item.RERAISER,              weight =  21 }, -- reraiser
        { itemId = xi.item.OAK_LOG,               weight =  22 }, -- oak log
        { itemId = xi.item.ROSEWOOD_LOG,          weight =  18 }, -- rosewood log
        { itemId = xi.item.GOLD_BEASTCOIN,        weight = 120 }, -- gold beastcoin
        { itemId = xi.item.MYTHRIL_BEASTCOIN,     weight = 102 }, -- mythril beastcoin
        { itemId = xi.item.PEARL,                 weight =  21 }, -- pearl
        { itemId = xi.item.TURQUOISE,             weight =  23 }, -- Turquoise
        { itemId = xi.item.GOSHENITE,             weight =  19 }, -- Goshenite
        { itemId = xi.item.BLACK_PEARL,           weight =  18 }, -- Black pearl
        { itemId = xi.item.SPHENE,                weight =  17 }, -- sphene
        { itemId = xi.item.GARNET,                weight =  20 }, -- garnet
        { itemId = xi.item.AMETRINE,              weight =  18 }, -- ametrine
        { itemId = xi.item.NONE,                  weight =   0 }, -- nothing
    },

    {
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight = 87 }, -- icespikes
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,  weight = 75 }, -- refresh
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 75 }, -- utsusemi ni
        { itemId = xi.item.OAK_LOG,               weight = 80 }, -- oak log
        { itemId = xi.item.ROSEWOOD_LOG,          weight = 97 }, -- rosewood log
        { itemId = xi.item.PEARL,                 weight = 86 }, -- pearl
        { itemId = xi.item.TURQUOISE,             weight = 88 }, -- Turquoise
        { itemId = xi.item.GOSHENITE,             weight = 79 }, -- Goshenite
        { itemId = xi.item.BLACK_PEARL,           weight = 93 }, -- Black pearl
        { itemId = xi.item.SPHENE,                weight = 79 }, -- sphene
        { itemId = xi.item.GARNET,                weight = 71 }, -- garnet
        { itemId = xi.item.AMETRINE,              weight = 90 }, -- ametrine
        { itemId = xi.item.NONE,                  weight =  0 }, -- nothing
    },
}

return content:register()
