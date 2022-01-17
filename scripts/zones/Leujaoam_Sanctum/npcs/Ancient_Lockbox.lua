-----------------------------------
-- Area: Leujaoam Sanctum
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/assault")
require("scripts/globals/items")
require("scripts/globals/appraisal")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assaultUtil.mission.LEUJAOAM_CLEANSING] =
        {
            {
                {itemid = xi.items.UNAPPRAISED_RING, droprate = 700},
                {itemid = xi.items.UNAPPRAISED_BOX,  droprate = 300},
            },
        },
        [xi.assaultUtil.mission.ORICHALCUM_SURVEY] =
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
        [xi.assaultUtil.mission.LEUJAOAM_CLEANSING] =
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
        [xi.assaultUtil.mission.ORICHALCUM_SURVEY] =
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
    xi.appraisalUtil.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
