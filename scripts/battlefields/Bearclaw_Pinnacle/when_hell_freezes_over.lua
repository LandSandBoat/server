-----------------------------------
-- When Hell Freezes Over
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos -757 -111 562 6
-----------------------------------
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.WHEN_HELL_FREEZES_OVER,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = "Wind_Pillar_3",
    exitNpc          = "Wind_Pillar_Exit",
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 3000,
})
content.groups =
{
    {
        mobs = { "Snow_Devil" },
    },
}

content:addEssentialMobs({ "Snow_Devil" })
content.loot =
{
    {
        { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.VERY_LOW },
        { itemid = xi.items.SQUARE_OF_GALATEIA, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.SQUARE_OF_KEJUSU_SATIN, droprate = xi.battlefield.dropChance.VERY_LOW },
        { itemid = xi.items.POT_OF_VIRIDIAN_URUSHI, droprate = xi.battlefield.dropChance.NORMAL },
    },

    {
        { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.EXTREMELY_HIGH },
        { itemid = xi.items.CLOUD_EVOKER, droprate = xi.battlefield.dropChance.LOW },
    },

    {
        quantity = 2,
        { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.HIGH },
        { itemid = xi.items.MARTIAL_BHUJ, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.MARTIAL_GUN, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.MARTIAL_STAFF, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.HEXEREI_CAPE, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.SETTLERS_CAPE, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = xi.battlefield.dropChance.NORMAL },
    },
}

return content:register()
