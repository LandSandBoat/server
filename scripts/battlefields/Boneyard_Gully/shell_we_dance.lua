-----------------------------------
-- Shell We Dance?
-- Boneyard Gully ENM, Miasma Filter
-- !addkeyitem MIASMA_FILTER
-----------------------------------
local boneyardGullyID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.SHELL_WE_DANCE,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    requiredKeyItems = { xi.ki.MIASMA_FILTER },
    armouryCrates    =
    {
        boneyardGullyID.mob.PARATA + 8,
        boneyardGullyID.mob.PARATA + 17,
        boneyardGullyID.mob.PARATA + 26,
    },

    grantXP = 3000,
})

content.groups =
{
    {
        mobIds =
        {
            {
                boneyardGullyID.mob.PARATA,
                boneyardGullyID.mob.PARATA + 1,
            },

            {
                boneyardGullyID.mob.PARATA + 9,
                boneyardGullyID.mob.PARATA + 10,
            },

            {
                boneyardGullyID.mob.PARATA + 18,
                boneyardGullyID.mob.PARATA + 19,
            },

        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            {
                boneyardGullyID.mob.PARATA + 2,
                boneyardGullyID.mob.PARATA + 3,
                boneyardGullyID.mob.PARATA + 4,
                boneyardGullyID.mob.PARATA + 5,
                boneyardGullyID.mob.PARATA + 6,
                boneyardGullyID.mob.PARATA + 7,
                },

            {
                boneyardGullyID.mob.PARATA + 11,
                boneyardGullyID.mob.PARATA + 12,
                boneyardGullyID.mob.PARATA + 13,
                boneyardGullyID.mob.PARATA + 14,
                boneyardGullyID.mob.PARATA + 15,
                boneyardGullyID.mob.PARATA + 16,
            },

            {
                boneyardGullyID.mob.PARATA + 20,
                boneyardGullyID.mob.PARATA + 21,
                boneyardGullyID.mob.PARATA + 22,
                boneyardGullyID.mob.PARATA + 23,
                boneyardGullyID.mob.PARATA + 24,
                boneyardGullyID.mob.PARATA + 25,
            },
        },

        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.PIECE_OF_CASSIA_LUMBER,   weight = 3750 },
        { itemId = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 3750 },
        { itemId = xi.item.DRAGON_BONE,              weight = 2500 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 9500 },
        { itemId = xi.item.CLOUD_EVOKER,             weight =  500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                     weight = 2750 },
        { itemId = xi.item.STONE_SPLITTER,           weight = 1500 },
        { itemId = xi.item.FRENZY_FIFE,              weight = 1500 },
        { itemId = xi.item.BLAU_DOLCH,               weight = 1500 },
        { itemId = xi.item.SCROLL_OF_ARMYS_PAEON_V,  weight = 2750 },
    },
}

return content:register()
