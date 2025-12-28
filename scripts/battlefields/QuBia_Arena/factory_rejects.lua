-----------------------------------
-- Factory Rejects
-- Qu'Bia Arena BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.FACTORY_REJECTS,
    maxPlayers    = 6,
    levelCap      = 40,
    timeLimit     = utils.minutes(30),
    index         = 13,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.STAR_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
    armouryCrates =
    {
        qubiaID.mob.DOLL_FACTORY + 6,
        qubiaID.mob.DOLL_FACTORY + 13,
        qubiaID.mob.DOLL_FACTORY + 20,
    },
})

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.DOLL_FACTORY      },
            { qubiaID.mob.DOLL_FACTORY + 7  },
            { qubiaID.mob.DOLL_FACTORY + 14 },
        },
    },

    {
        mobIds =
        {
            {
                qubiaID.mob.DOLL_FACTORY + 1,
                qubiaID.mob.DOLL_FACTORY + 2,
                qubiaID.mob.DOLL_FACTORY + 3,
                qubiaID.mob.DOLL_FACTORY + 4,
                qubiaID.mob.DOLL_FACTORY + 5,
            },

            {
                qubiaID.mob.DOLL_FACTORY + 8,
                qubiaID.mob.DOLL_FACTORY + 9,
                qubiaID.mob.DOLL_FACTORY + 10,
                qubiaID.mob.DOLL_FACTORY + 11,
                qubiaID.mob.DOLL_FACTORY + 12,
            },

            {
                qubiaID.mob.DOLL_FACTORY + 15,
                qubiaID.mob.DOLL_FACTORY + 16,
                qubiaID.mob.DOLL_FACTORY + 17,
                qubiaID.mob.DOLL_FACTORY + 18,
                qubiaID.mob.DOLL_FACTORY + 19,
            },
        },

        allDeath = function(battlefield, mob)
            -- Win when all 5 dolls have been killed
            if battlefield:getLocalVar('dollsSpawned') >= 5 then
                content:handleAllMonstersDefeated(battlefield, mob)
            end
        end,

        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                   weight = 10000, amount = 6000 },
    },

    {
        { itemId = xi.item.JONGLEURS_DAGGER,      weight =  1000 },
        { itemId = xi.item.DUSKY_STAFF,           weight =  1000 },
        { itemId = xi.item.RAIFU,                 weight =  1000 },
        { itemId = xi.item.BUZZARD_TUCK,          weight =  1000 },
        { itemId = xi.item.AGILE_MANTLE,          weight =  4000 },
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
        { itemId = xi.item.BEHOURD_LANCE,         weight =  1000 },
        { itemId = xi.item.OHAGURO,               weight =  1000 },
        { itemId = xi.item.KAGEHIDE,              weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ERASE,       weight =  1000 },
        { itemId = xi.item.REARGUARD_MANTLE,      weight =  4000 },
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
        { itemId = xi.item.PETRIFIED_LOG,         weight =  3000 },
    },

    {
        { itemId = xi.item.DOLL_SHARD,            weight = 10000 },
    },

    {
        { itemId = xi.item.VIAL_OF_MERCURY,       weight = 10000 },
    },
}

return content:register()
