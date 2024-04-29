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
        { item = xi.item.BLITZ_RING, weight = 150 }, -- blitz Ring
        { item = xi.item.NONE,       weight = 850 }, -- Nothing
    },

    {
        { item = xi.item.AEGIS_RING,    weight = 300 }, -- aegis Ring
        { item = xi.item.TUNDRA_MANTLE, weight = 200 }, -- tundra mantle
        { item = xi.item.DRUIDS_ROPE,   weight = 200 }, -- druids rope
        { item = xi.item.NONE,          weight = 300 }, -- Nothing
    },

    {
        { item = xi.item.FIRE_SPIRIT_PACT,     weight = 145 }, -- firespirit
        { item = xi.item.SCROLL_OF_ERASE,      weight = 165 }, -- erase
        { item = xi.item.SCROLL_OF_PHALANX,    weight = 140 }, -- phalanx
        { item = xi.item.SCROLL_OF_ABSORB_STR, weight = 123 }, -- absorb-str
        { item = xi.item.PERIDOT,              weight =  94 }, -- peridot
        { item = xi.item.PEARL,                weight =  94 }, -- pearl
        { item = xi.item.GREEN_ROCK,           weight =  13 }, -- green rock
        { item = xi.item.AMETRINE,             weight =  53 }, -- ametrine
        { item = xi.item.GOLD_BEASTCOIN,       weight =  70 }, -- gold beastcoin
        { item = xi.item.MYTHRIL_BEASTCOIN,    weight =  50 }, -- mythril beastcoin
        { item = xi.item.YELLOW_ROCK,          weight =  53 }, -- yellow rock
        { item = xi.item.NONE,                 weight =   0 }, -- nothing
    },

    {
        { item = xi.item.SCROLL_OF_ERASE,      weight = 125 }, -- erase
        { item = xi.item.SCROLL_OF_PHALANX,    weight = 110 }, -- phalanx
        { item = xi.item.SCROLL_OF_ABSORB_STR, weight = 104 }, -- absorb-str
        { item = xi.item.PERIDOT,              weight =  94 }, -- peridot
        { item = xi.item.PEARL,                weight =  94 }, -- pearl
        { item = xi.item.GREEN_ROCK,           weight =  53 }, -- green rock
        { item = xi.item.AMETRINE,             weight =  73 }, -- ametrine
        { item = xi.item.GOLD_BEASTCOIN,       weight =  70 }, -- gold beastcoin
        { item = xi.item.MYTHRIL_BEASTCOIN,    weight =  70 }, -- mythril beastcoin
        { item = xi.item.YELLOW_ROCK,          weight =  73 }, -- yellow rock
        { item = xi.item.NONE,                 weight =  94 }, -- nothing
    },

    {
        { item = xi.item.FIRE_SPIRIT_PACT,      weight = 174 }, -- firespirit
        { item = xi.item.SCROLL_OF_ERASE,       weight =  16 }, -- vile elixir
        { item = xi.item.SCROLL_OF_PHALANX,     weight = 114 }, -- icespikes
        { item = xi.item.SCROLL_OF_ABSORB_STR,  weight = 174 }, -- refresh
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 138 }, -- utsusemi ni
        { item = xi.item.GREEN_ROCK,            weight =  18 }, -- green rock
        { item = xi.item.BLACK_ROCK,            weight =  18 }, -- black rock
        { item = xi.item.BLUE_ROCK,             weight =  17 }, -- blue rock
        { item = xi.item.RED_ROCK,              weight =  16 }, -- red rock
        { item = xi.item.PURPLE_ROCK,           weight =  16 }, -- purple rock
        { item = xi.item.WHITE_ROCK,            weight =  16 }, -- white rock
        { item = xi.item.YELLOW_ROCK,           weight =  17 }, -- yellow rock
        { item = xi.item.TRANSLUCENT_ROCK,      weight =  17 }, -- translucent rock
        { item = xi.item.RERAISER,              weight =  21 }, -- reraiser
        { item = xi.item.OAK_LOG,               weight =  22 }, -- oak log
        { item = xi.item.ROSEWOOD_LOG,          weight =  18 }, -- rosewood log
        { item = xi.item.GOLD_BEASTCOIN,        weight = 120 }, -- gold beastcoin
        { item = xi.item.MYTHRIL_BEASTCOIN,     weight = 102 }, -- mythril beastcoin
        { item = xi.item.PEARL,                 weight =  21 }, -- pearl
        { item = xi.item.TURQUOISE,             weight =  23 }, -- Turquoise
        { item = xi.item.GOSHENITE,             weight =  19 }, -- Goshenite
        { item = xi.item.BLACK_PEARL,           weight =  18 }, -- Black pearl
        { item = xi.item.SPHENE,                weight =  17 }, -- sphene
        { item = xi.item.GARNET,                weight =  20 }, -- garnet
        { item = xi.item.AMETRINE,              weight =  18 }, -- ametrine
        { item = xi.item.NONE,                  weight =   0 }, -- nothing
    },

    {
        { item = xi.item.SCROLL_OF_PHALANX,     weight = 87 }, -- icespikes
        { item = xi.item.SCROLL_OF_ABSORB_STR,  weight = 75 }, -- refresh
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 75 }, -- utsusemi ni
        { item = xi.item.OAK_LOG,               weight = 80 }, -- oak log
        { item = xi.item.ROSEWOOD_LOG,          weight = 97 }, -- rosewood log
        { item = xi.item.PEARL,                 weight = 86 }, -- pearl
        { item = xi.item.TURQUOISE,             weight = 88 }, -- Turquoise
        { item = xi.item.GOSHENITE,             weight = 79 }, -- Goshenite
        { item = xi.item.BLACK_PEARL,           weight = 93 }, -- Black pearl
        { item = xi.item.SPHENE,                weight = 79 }, -- sphene
        { item = xi.item.GARNET,                weight = 71 }, -- garnet
        { item = xi.item.AMETRINE,              weight = 90 }, -- ametrine
        { item = xi.item.NONE,                  weight =  0 }, -- nothing
    },
}

return content:register()
