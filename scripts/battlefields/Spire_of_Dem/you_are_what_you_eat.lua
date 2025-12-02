-----------------------------------
-- You Are What You Eat
-- Spire of Dem ENM30
-- !addkeyitem 671
-----------------------------------
local spireOfDemID = zones[xi.zone.SPIRE_OF_DEM]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SPIRE_OF_DEM,
    battlefieldId    = xi.battlefield.id.YOU_ARE_WHAT_YOU_EAT,
    allowTrusts      = false,
    maxPlayers       = 18,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = '_0j0',
    exitNpcs         = { '_0j1', '_0j2', '_0j3' },
    requiredKeyItems = { xi.ki.CENSER_OF_ANTIPATHY, message = spireOfDemID.text.FADES_INTO_NOTHINGNESS },
    grantXP          = 3000,
})

content.groups =
{
    {
        mobs      = { 'Ingester' },
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobs      = { 'Neoingester', 'Neogorger', 'Neosatiator', 'Wanderer_enm' },
        spawned  = false,
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
        { itemId = xi.item.VIOLENT_VISION,                 weight = 100 },
        { itemId = xi.item.PAINFUL_VISION,                 weight = 100 },
        { itemId = xi.item.TIMOROUS_VISION,                weight = 100 },
        { itemId = xi.item.BRILLIANT_VISION,               weight = 100 },
        { itemId = xi.item.VENERABLE_VISION,               weight = 100 },
    },
}

return content:register()
