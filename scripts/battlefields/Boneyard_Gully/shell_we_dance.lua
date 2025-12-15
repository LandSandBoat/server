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

    grantXP = 2000,

    experimental = true,
})

-- TODO: Needs additional cleanup and mixin work (previous comment).  Examine
-- mob spawn handling and move hardcoded IDs to this script or the mob and read as necessary.

content:addEssentialMobs({ 'Parata', 'Bladmall' })

content.loot =
{
    {
        { itemId = xi.item.PIECE_OF_CASSIA_LUMBER,   weight = 375 },
        { itemId = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 328 },
        { itemId = xi.item.DRAGON_BONE,              weight = 263 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 850 },
        { itemId = xi.item.CLOUD_EVOKER,             weight = 150 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                     weight = 275 },
        { itemId = xi.item.STONE_SPLITTER,           weight = 150 },
        { itemId = xi.item.FRENZY_FIFE,              weight = 150 },
        { itemId = xi.item.BLAU_DOLCH,               weight = 150 },
        { itemId = xi.item.SCROLL_OF_ARMYS_PAEON_V,  weight = 275 },
    },
}

return content:register()
