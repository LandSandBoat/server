-----------------------------------
-- Area: Lebros Cavern
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/appraisal")
require("scripts/globals/assault")
require("scripts/globals/items")
-----------------------------------

onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assaultUtil.mission.EXCAVATION_DUTY] =
        {
            {
                {itemid = xi.items.APPRAISAL_BOX,     droprate = 300},
                {itemid = xi.items.APPRAISAL_EARRING, droprate = 700},
            },
        },
        [xi.assaultUtil.mission.LEBROS_SUPPLIES] =
        {
            {
                {itemid = xi.items.APPRAISAL_BOX,  droprate = 300},
                {itemid = xi.items.APPRAISAL_CAPE, droprate = 700},
            },
        },
        [xi.assaultUtil.mission.TROLL_FUGITIVES] =
        {
            {
                {itemid = xi.items.APPRAISAL_AXE, droprate = 300},
                {itemid = xi.items.APPRAISAL_POLEARM, droprate = 200},
                {itemid = xi.items.APPRAISAL_HEADPIECE, droprate = 100},
                {itemid = xi.items.APPRAISAL_BOX, droprate = 400},
            },
        },
    }
    local regItem =
    {
        [xi.assaultUtil.mission.EXCAVATION_DUTY] =
        {
            {
                {itemid = xi.items.REMEDY, droprate = 900},
                {itemid = 0, droprate = 100},
            },
            {
                {itemid = xi.items.REMEDY, droprate = 200},
                {itemid = 0, droprate = 800},
            },
            {
                {itemid = xi.items.HI_POTION_III, droprate = 400},
                {itemid = 0, droprate = 600},
            },
            {
                {itemid = xi.items.HI_POTION_III, droprate = 200},
                {itemid = 0, droprate = 800},
            },
        },
        [xi.assaultUtil.mission.LEBROS_SUPPLIES] =
        {
            {
                {itemid = xi.items.REMEDY, droprate = 800},
                {itemid = 0, droprate = 200},
            },
            {
                {itemid = xi.items.RERAISER, droprate = 200},
                {itemid = 0, droprate = 800},
            },
            {
                {itemid = xi.items.HI_POTION_TANK, droprate = 100},
                {itemid = 0, droprate = 900},
            },
        },
        [xi.assaultUtil.mission.TROLL_FUGITIVES] =
        {
            {
                {itemid = xi.items.HI_POTION_III, droprate = 800},
                {itemid = 0, droprate = 200},
            },
            {
                {itemid = xi.items.RERAISER, droprate = 200},
                {itemid = 0, droprate = 800},
            },
            {
                {itemid = xi.items.HI_POTION_TANK, droprate = 100},
                {itemid = 0, droprate = 900},
            },
            {
                {itemid = xi.items.HI_ETHER_TANK, droprate = 100},
                {itemid = 0, droprate = 900},
            },
        },
    }
    local area = player:getCurrentAssault()
    xi.appraisalUtil.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

onEventUpdate = function(player, csid, option)
end

onEventFinish = function(player, csid, option)
end
