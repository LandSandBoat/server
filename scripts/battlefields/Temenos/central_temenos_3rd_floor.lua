-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 3rrd Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_3RD_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(45),
    index            = 4,
    area             = 5,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.items.IVORY_CHIP },
    name             = "CENTRAL_TEMENOS_3RD_FLOOR",
})

content.groups =
{

}

content.loot =
{
    {
        {
            quantity = 7,
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1934, droprate =  53 },
            { itemid = 1940, droprate = 132 },
            { itemid = 1954, droprate = 105 },
            { itemid = 1932, droprate = 211 },
            { itemid = 1956, droprate = 211 },
            { itemid = 1930, droprate = 100 },
            { itemid = 2658, droprate = 211 },
            { itemid = 2716, droprate = 105 },
        },

        {
            { itemid = 1907, droprate = 1000 },
        },
    }
}

return content:register()
