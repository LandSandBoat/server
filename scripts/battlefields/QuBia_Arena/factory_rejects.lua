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

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
        spawned  = false,
    },
}

content.loot =
{
    {
        { item = xi.item.DOLL_SHARD, weight = 1000 }, -- doll_shard
    },

    {
        { item = xi.item.VIAL_OF_MERCURY, weight = 1000 }, -- vial_of_mercury
    },

    {
        { item = xi.item.NONE,           weight = 500 }, -- nothing
        { item = xi.item.GOLD_BEASTCOIN, weight = 500 }, -- gold_beastcoin
    },

    {
        { item = xi.item.NONE,             weight = 250 }, -- nothing
        { item = xi.item.RAIFU,            weight = 250 }, -- raifu
        { item = xi.item.BUZZARD_TUCK,     weight = 250 }, -- buzzard_tuck
        { item = xi.item.JONGLEURS_DAGGER, weight = 250 }, -- jongleurs_dagger
    },

    {
        { item = xi.item.NONE,             weight = 200 }, -- nothing
        { item = xi.item.REARGUARD_MANTLE, weight = 400 }, -- rearguard_mantle
        { item = xi.item.AGILE_MANTLE,     weight = 400 }, -- agile_mantle
    },

    {
        { item = xi.item.NONE,                  weight = 750 }, -- nothing
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 125 }, -- scroll_of_utsusemi_ni
        { item = xi.item.SCROLL_OF_PHALANX,     weight = 125 }, -- scroll_of_phalanx
    },
}

return content:register()
