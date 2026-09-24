-----------------------------------
-- Bionic Bug
-- Level 75 ENM
-- !addkeyitem SHAFT_2716_OPERATING_LEVER
-----------------------------------
local mineShaft2716ID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MINE_SHAFT_2716,
    battlefieldId    = xi.battlefield.id.BIONIC_BUG,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = '_0d0',
    exitNpcs         = { '_0d1', '_0d2', '_0d3' },
    requiredKeyItems = { xi.keyItem.SHAFT_2716_OPERATING_LEVER, message = mineShaft2716ID.text.SNAPS_IN_TWO, },
    grantXP          = 3000,
})

content:addEssentialMobs({ 'Bugboy' })

content.loot =
{
    {
        { itemId = xi.item.DRAGON_BONE,              weight = 3334 },
        { itemId = xi.item.PIECE_OF_CASSIA_LUMBER,   weight = 3333 },
        { itemId = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 3333 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 9750 },
        { itemId = xi.item.CLOUD_EVOKER,             weight =  250 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 6250 },
        { itemId = xi.item.COMMANDERS_CAPE,          weight =  750 },
        { itemId = xi.item.FAERIE_HAIRPIN,           weight = 1000 },
        { itemId = xi.item.MARTIAL_KNIFE,            weight =  750 },
        { itemId = xi.item.MARTIAL_SCYTHE,           weight =  750 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,      weight =  500 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 6250 },
        { itemId = xi.item.COMMANDERS_CAPE,          weight =  750 },
        { itemId = xi.item.FAERIE_HAIRPIN,           weight = 1000 },
        { itemId = xi.item.MARTIAL_KNIFE,            weight =  750 },
        { itemId = xi.item.MARTIAL_SCYTHE,           weight =  750 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,      weight =  500 },
    },
}

return content:register()
