-----------------------------------
-- Brothers
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos 121 -171 758 6
-----------------------------------
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.BROTHERS,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = "Wind_Pillar_4",
    exitNpc          = "Wind_Pillar_Exit",
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 3500,
})

content.groups =
{
    {
        mobs = { "Eldertaur" },
        mods =
        {
            [xi.mod.DMGMAGIC] = -1000,
            [xi.mod.SLEEPRES] = 75,
        },

        mobMods =
        {
            [xi.mobMod.SIGHT_RANGE] = 30,
        },
    },
    {
        mobs = { "Mindertaur" },
        mods =
        {
            [xi.mod.DMGMAGIC] = -1000,
            [xi.mod.SILENCERES] = 75,
            [xi.mod.SLEEPRES] = 50,
        },

        mobMods =
        {
            [xi.mobMod.SIGHT_RANGE] = 30,
        }
    },
}

content:addEssentialMobs({ "Eldertaur", "Mindertaur" })

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
        { itemid = xi.items.SCOUTERS_ROPE, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.HEDGEHOG_BOMB, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.MARTIAL_ANELACE, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.MARTIAL_LANCE, droprate = xi.battlefield.dropChance.LOW },
        { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = xi.battlefield.dropChance.HIGH },
    },
}

return content:register()
