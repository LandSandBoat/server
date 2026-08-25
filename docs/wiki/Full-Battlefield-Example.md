```lua
-----------------------------------
-- Holy Cow
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos -520 25 -801
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
require("scripts/globals/battlefield")
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
        { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.VERY_LOW },
        { itemid = xi.items.SQUARE_OF_ELTORO_LEATHER, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.PIECE_OF_CASSIA_LUMBER, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.DRAGON_BONE, droprate = xi.battlefield.dropChance.NORMAL },
    },

    {
        { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.EXTREMELY_HIGH },
        { itemid = xi.items.CLOUD_EVOKER, droprate = xi.battlefield.dropChance.LOW },
    },

    {
        quantity = 2,
        { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.HIGH },
        { itemid = xi.items.GIGANT_MANTLE, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.PSILOS_MANTLE, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.MARTIAL_BOW, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.MARTIAL_KNUCKLES, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = xi.battlefield.dropChance.HIGH },
    },
}

return content:register()
```
