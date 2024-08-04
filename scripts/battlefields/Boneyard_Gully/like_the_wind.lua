-----------------------------------
-- Like the Wind
-- Boneyard Gully ENM, Miasma Filter
-- !addkeyitem MIASMA_FILTER
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.LIKE_THE_WIND,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(15),
    index            = 1,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    requiredKeyItems = { xi.ki.MIASMA_FILTER },

    grantXP = 2000,

    experimental = true,
})

-- TODO: Race Runner has a constant movement mechanic and different hate rules that need
-- to be implemented.  See: https://ffxiclopedia.fandom.com/wiki/Like_the_Wind

content:addEssentialMobs({ 'Race_Runner' })

content.loot =
{
    {
        { item = xi.item.NONE,                   weight = 140 }, -- nothing
        { item = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 310 }, -- Viridian Urushi
        { item = xi.item.SQUARE_OF_GALATEIA,     weight = 241 }, -- Square of Galateia
        { item = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 310 }, -- Kejusu Satin
    },

    {
        { item = xi.item.NONE,         weight = 862 }, -- nothing
        { item = xi.item.CLOUD_EVOKER, weight = 138 }, -- Cloud Evoker
    },

    {
        { item = xi.item.NONE,                    weight = 380 }, -- nothing
        { item = xi.item.MANEATER,                weight = 138 }, -- Maneater
        { item = xi.item.WAGH_BAGHNAKHS,          weight = 172 }, -- Wagh Baghnakhs
        { item = xi.item.ONIMARU,                 weight = 138 }, -- Onimaru
        { item = xi.item.SCROLL_OF_ARMYS_PAEON_V, weight = 172 }, -- Army's Paeon V
    },

    {
        { item = xi.item.NONE,                    weight = 380 }, -- nothing
        { item = xi.item.MANEATER,                weight = 138 }, -- Maneater
        { item = xi.item.WAGH_BAGHNAKHS,          weight = 172 }, -- Wagh Baghnakhs
        { item = xi.item.ONIMARU,                 weight = 138 }, -- Onimaru
        { item = xi.item.SCROLL_OF_ARMYS_PAEON_V, weight = 172 }, -- Army's Paeon V
    },
}

return content:register()
