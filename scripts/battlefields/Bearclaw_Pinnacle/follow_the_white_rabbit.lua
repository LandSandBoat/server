-----------------------------------
-- Follow the White Rabbit
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos -877 -47 -43 6
-----------------------------------
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.FOLLOW_THE_WHITE_RABBIT,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = "Wind_Pillar_2",
    exitNpc          = "Wind_Pillar_Exit",
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 2500,
})
content.groups =
{
    {
        mobs = { "Bearclaw_Rabbit" },

        mobMods =
        {
            [xi.mobMod.SIGHT_RANGE] = 20,
        },
    },
    {
        mobs = { "Bearclaw_Leveret" },

        mobMods =
        {
            [xi.mobMod.SIGHT_RANGE] = 30,
        },
    },
}

content:addEssentialMobs({ "Bearclaw_Rabbit", "Bearclaw_Leveret" })
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
        { itemid = xi.items.MARTIAL_SWORD, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.SHAMO, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.VENTURERS_BELT, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.SERENE_RING, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = xi.battlefield.dropChance.NORMAL },
    },
}

return content:register()
