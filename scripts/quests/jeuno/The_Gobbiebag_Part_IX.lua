-----------------------------------
-- The Gobbiebag Part IX
-----------------------------------
--  Log ID: 3, Quest ID: 27
--  NPC: Bluffnix:  !pos -43 6 -115 245
-----------------------------------
require("scripts/globals/items")
require("scripts/quests/jeuno/helpers")
-----------------------------------
local lowerJeunoID = require("scripts/zones/Lower_Jeuno/IDs")

local params =
{
    questId             = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,
    prerequisite        = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII,
    message             = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize  = 70,
    fame                = 5,
    tradeStew           = xi.items.BOWL_OF_GOBLIN_STEW_880,
    tradeItems =
    {
        xi.items.ORICHALCUM_INGOT,
        xi.items.SQUARE_OF_PEISTE_LEATHER,
        xi.items.SQUARE_OF_OIL_SOAKED_CLOTH,
        xi.items.OXBLOOD_ORB,
    },
    reward =
    {
        fame    = 30,
        title   = nil,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
