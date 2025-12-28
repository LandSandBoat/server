-----------------------------------
-- Playing Host
-- Spire of Mea ENM30
-- !addkeyitem 672
-----------------------------------
local spireOfMeaID = zones[xi.zone.SPIRE_OF_MEA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SPIRE_OF_MEA,
    battlefieldId    = xi.battlefield.id.PLAYING_HOST,
    maxPlayers       = 18,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_0l0',
    exitNpcs         = { '_0l1', '_0l2', '_0l3' },
    requiredKeyItems = { xi.ki.CENSER_OF_ANIMUS, message = spireOfMeaID.text.FADES_INTO_NOTHINGNESS },
    grantXP          = 3000,
    armouryCrates    =
    {
        spireOfMeaID.mob.ENVIER + 4,
        spireOfMeaID.mob.ENVIER + 9,
        spireOfMeaID.mob.ENVIER + 14,
    },
})

content.groups =
{
    -- Envier
    {
        mobIds =
        {
            { spireOfMeaID.mob.ENVIER      },
            { spireOfMeaID.mob.ENVIER + 5  },
            { spireOfMeaID.mob.ENVIER + 10 },
        },

        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    -- Seether
    {
        mobIds =
        {
            {
                spireOfMeaID.mob.ENVIER + 1,
                spireOfMeaID.mob.ENVIER + 2,
                spireOfMeaID.mob.ENVIER + 3,
            },

            {
                spireOfMeaID.mob.ENVIER + 6,
                spireOfMeaID.mob.ENVIER + 7,
                spireOfMeaID.mob.ENVIER + 8,
            },

            {
                spireOfMeaID.mob.ENVIER + 11,
                spireOfMeaID.mob.ENVIER + 12,
                spireOfMeaID.mob.ENVIER + 13,
            },
        },

        spawned = false,
    },
}

content.loot =
{
    {
        quantity = 3,
        { itemId = xi.item.NONE,                           weight = 200 },
        { itemId = xi.item.CLUSTER_OF_BURNING_MEMORIES,    weight = 100 },
        { itemId = xi.item.CLUSTER_OF_BITTER_MEMORIES,     weight = 100 },
        { itemId = xi.item.CLUSTER_OF_FLEETING_MEMORIES,   weight = 100 },
        { itemId = xi.item.CLUSTER_OF_PROFANE_MEMORIES,    weight = 100 },
        { itemId = xi.item.CLUSTER_OF_STARTLING_MEMORIES,  weight = 100 },
        { itemId = xi.item.CLUSTER_OF_SOMBER_MEMORIES,     weight = 100 },
        { itemId = xi.item.CLUSTER_OF_RADIANT_MEMORIES,    weight = 100 },
        { itemId = xi.item.CLUSTER_OF_MALEVOLENT_MEMORIES, weight = 100 },
    },

    {
        { itemId = xi.item.NONE,                           weight = 500 },
        { itemId = xi.item.SOLEMN_VISION,                  weight = 100 },
        { itemId = xi.item.VALIANT_VISION,                 weight = 100 },
        { itemId = xi.item.PRETENTIOUS_VISION,             weight = 100 },
        { itemId = xi.item.MALICIOUS_VISION,               weight = 100 },
        { itemId = xi.item.PRISTINE_VISION,                 weight = 100 },
    },
}

return content:register()
