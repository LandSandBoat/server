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
        { itemId = xi.item.NONE,                   weight = 140 }, -- nothing
        { itemId = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 310 }, -- Viridian Urushi
        { itemId = xi.item.SQUARE_OF_GALATEIA,     weight = 241 }, -- Square of Galateia
        { itemId = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 310 }, -- Kejusu Satin
    },

    {
        { itemId = xi.item.NONE,         weight = 862 }, -- nothing
        { itemId = xi.item.CLOUD_EVOKER, weight = 138 }, -- Cloud Evoker
    },

    {
        { itemId = xi.item.NONE,                    weight = 380 }, -- nothing
        { itemId = xi.item.MANEATER,                weight = 138 }, -- Maneater
        { itemId = xi.item.WAGH_BAGHNAKHS,          weight = 172 }, -- Wagh Baghnakhs
        { itemId = xi.item.ONIMARU,                 weight = 138 }, -- Onimaru
        { itemId = xi.item.SCROLL_OF_ARMYS_PAEON_V, weight = 172 }, -- Army's Paeon V
    },

    {
        { itemId = xi.item.NONE,                    weight = 380 }, -- nothing
        { itemId = xi.item.MANEATER,                weight = 138 }, -- Maneater
        { itemId = xi.item.WAGH_BAGHNAKHS,          weight = 172 }, -- Wagh Baghnakhs
        { itemId = xi.item.ONIMARU,                 weight = 138 }, -- Onimaru
        { itemId = xi.item.SCROLL_OF_ARMYS_PAEON_V, weight = 172 }, -- Army's Paeon V
    },
}

return content:register()
