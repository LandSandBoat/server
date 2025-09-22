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
        { itemId = xi.item.NONE, weight = xi.loot.weight.VERY_LOW },
        { itemId = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.PIECE_OF_CASSIA_LUMBER, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.DRAGON_BONE, weight = xi.loot.weight.NORMAL },
    },

    {
        { itemId = xi.item.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { itemId = xi.item.CLOUD_EVOKER, weight = xi.loot.weight.LOW },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE, weight = xi.loot.weight.HIGH },
        { itemId = xi.item.GIGANT_MANTLE, weight = xi.loot.weight.LOW },
        { itemId = xi.item.PSILOS_MANTLE, weight = xi.loot.weight.LOW },
        { itemId = xi.item.MARTIAL_BOW, weight = xi.loot.weight.LOW },
        { itemId = xi.item.MARTIAL_KNUCKLES, weight = xi.loot.weight.LOW },
        { itemId = xi.item.SCROLL_OF_RAISE_III, weight = xi.loot.weight.HIGH },
    },
}

return content:register()
