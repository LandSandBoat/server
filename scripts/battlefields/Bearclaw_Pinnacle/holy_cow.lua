-----------------------------------
-- Holy Cow
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos -520 25 -801 6
-----------------------------------
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.HOLY_COW,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 4,
    entryNpc         = "Wind_Pillar_5",
    exitNpc          = "Wind_Pillar_Exit",
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 4000,
})

content:addEssentialMobs({ "Apis" })

content.loot =
{
    {
        { item = xi.items.NONE, weight = xi.loot.weight.VERY_LOW },
        { item = xi.items.SQUARE_OF_ELTORO_LEATHER, weight = xi.loot.weight.NORMAL },
        { item = xi.items.PIECE_OF_CASSIA_LUMBER, weight = xi.loot.weight.NORMAL },
        { item = xi.items.DRAGON_BONE, weight = xi.loot.weight.NORMAL },
    },

    {
        { item = xi.items.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.items.CLOUD_EVOKER, weight = xi.loot.weight.LOW },
    },

    {
        quantity = 2,
        { item = xi.items.NONE, weight = xi.loot.weight.HIGH },
        { item = xi.items.GIGANT_MANTLE, weight = xi.loot.weight.LOW },
        { item = xi.items.PSILOS_MANTLE, weight = xi.loot.weight.LOW },
        { item = xi.items.MARTIAL_BOW, weight = xi.loot.weight.LOW },
        { item = xi.items.MARTIAL_KNUCKLES, weight = xi.loot.weight.LOW },
        { item = xi.items.SCROLL_OF_RAISE_III, weight = xi.loot.weight.HIGH },
    },
}

return content:register()
