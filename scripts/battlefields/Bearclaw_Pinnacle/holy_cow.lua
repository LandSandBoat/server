-----------------------------------
-- Holy Cow
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos -520 25 -801 6
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.HOLY_COW,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 4,
    entryNpc         = 'Wind_Pillar_5',
    exitNpc          = 'Wind_Pillar_Exit',
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 4000,
})

content:addEssentialMobs({ 'Apis' })

content.loot =
{
    {
        { itemId = xi.item.NONE,                     weight = 9500 },
        { itemId = xi.item.CLOUD_EVOKER,             weight =  500 },
    },

    {
        { itemId = xi.item.NONE,                     weight = 2500 },
        { itemId = xi.item.PIECE_OF_CASSIA_LUMBER,   weight = 2500 },
        { itemId = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 2500 },
        { itemId = xi.item.DRAGON_BONE,              weight = 2500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                     weight = 5500 },
        { itemId = xi.item.GIGANT_MANTLE,            weight =  700 },
        { itemId = xi.item.PSILOS_MANTLE,            weight =  800 },
        { itemId = xi.item.MARTIAL_BOW,              weight =  800 },
        { itemId = xi.item.MARTIAL_KNUCKLES,         weight =  800 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,      weight = 1400 },
    },
}

return content:register()
