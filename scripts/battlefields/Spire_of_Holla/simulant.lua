-----------------------------------
-- Simulant
-- Spire of Holla ENM30
-- !addkeyitem 670
-----------------------------------
local spireOfHollaID = zones[xi.zone.SPIRE_OF_HOLLA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SPIRE_OF_HOLLA,
    battlefieldId    = xi.battlefield.id.SIMULANT,
    maxPlayers       = 18,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_0h0',
    exitNpcs         = { '_0h1', '_0h2', '_0h3' },
    requiredKeyItems = { xi.ki.CENSER_OF_ABANDONMENT, message = spireOfHollaID.text.FADES_INTO_NOTHINGNESS },
    grantXP          = 3000,
    armouryCrates    =
    {
        spireOfHollaID.mob.COGITATOR + 4,
        spireOfHollaID.mob.COGITATOR + 9,
        spireOfHollaID.mob.COGITATOR + 14
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                spireOfHollaID.mob.COGITATOR,
            },

            {
                spireOfHollaID.mob.COGITATOR + 5,
            },

            {
                spireOfHollaID.mob.COGITATOR + 10,
            },
        },
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            {
                spireOfHollaID.mob.COGITATOR + 1,
                spireOfHollaID.mob.COGITATOR + 2,
                spireOfHollaID.mob.COGITATOR + 3,
            },

            {
                spireOfHollaID.mob.COGITATOR + 6,
                spireOfHollaID.mob.COGITATOR + 7,
                spireOfHollaID.mob.COGITATOR + 8,
            },

            {
                spireOfHollaID.mob.COGITATOR + 11,
                spireOfHollaID.mob.COGITATOR + 12,
                spireOfHollaID.mob.COGITATOR + 13,
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
        { itemId = xi.item.VERNAL_VISION,                  weight = 100 },
        { itemId = xi.item.PUNCTILIOUS_VISION,             weight = 100 },
        { itemId = xi.item.AUDACIOUS_VISION,               weight = 100 },
        { itemId = xi.item.VIVID_VISION,                   weight = 100 },
        { itemId = xi.item.ENDEARING_VISION,               weight = 100 },
    },
}

return content:register()
