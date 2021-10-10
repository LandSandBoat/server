-----------------------------------
-- Area: Leujaoam Sanctum
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/items")
require("scripts/globals/missions")
require("scripts/globals/UNAPPRAISED")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [LEUJAOAM_CLEANSING] =
        {
            {
                {itemid = xi.items.UNAPPRAISED_RING, droprate = 700},
                {itemid = xi.items.UNAPPRAISED_BOX,  droprate = 300},
            },
        },
        [ORICHALCUM_SURVEY] =
        {
            {
                {itemid = xi.items.UNAPPRAISED_NECKLACE, droprate = 300},
                {itemid = xi.items.UNAPPRAISED_BOX,      droprate = 400},
                {itemid = xi.items.UNAPPRAISED_GLOVES,   droprate = 300},
            },
        },
    }
    local regItem =
    {
        [LEUJAOAM_CLEANSING] =
        {
            {
                {itemid = xi.items.HI_POTION_III, droprate = 1000},
            },
            {
                {itemid = xi.items.HI_POTION_III, droprate = 100},
                {itemid = 0, droprate = 900},
            },
            {
                {itemid = xi.items.REMEDY, droprate = 530},
                {itemid = 0, droprate = 470},
            },
        },
        [ORICHALCUM_SURVEY] =
        {
            {
                {itemid = xi.items.HI_POTION_III, droprate = 1000},
            },
            {
                {itemid = xi.items.REMEDY, droprate = 530},
                {itemid = 0, droprate = 470},
            },
        },
    }
    local area = player:getCurrentAssault()
    UNAPPRAISEDUtil.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
