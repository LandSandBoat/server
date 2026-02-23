-----------------------------------
-- Brothers
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos 121 -171 758 6
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.BROTHERS,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'Wind_Pillar_4',
    exitNpc          = 'Wind_Pillar_Exit',
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 3500,
})

content:addEssentialMobs({ 'Eldertaur', 'Mindertaur' })

content.loot =
{
    {
        { itemId = xi.item.PIECE_OF_CASSIA_LUMBER,   weight = 3750 },
        { itemId = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 2500 },
        { itemId = xi.item.DRAGON_BONE,              weight = 3750 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 9500 },
        { itemId = xi.item.CLOUD_EVOKER,             weight =  500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                     weight = 5500 },
        { itemId = xi.item.SCOUTERS_ROPE,            weight =  700 },
        { itemId = xi.item.HEDGEHOG_BOMB,            weight =  800 },
        { itemId = xi.item.MARTIAL_ANELACE,          weight =  800 },
        { itemId = xi.item.MARTIAL_LANCE,            weight =  800 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,      weight = 1400 },
    },
}

return content:register()
