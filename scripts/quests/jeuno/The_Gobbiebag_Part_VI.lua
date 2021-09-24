-----------------------------------
-- The Gobbiebag Part VI
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
    questId             = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI,
    prerequisite        = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V,
    message             = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize  = 55,
    fame                = 3,
    tradeStew           = xi.items.BOWL_OF_GOBLIN_STEW_880,
    tradeItems =
    {
        xi.items.SHAKUDO_INGOT,
        xi.items.SQUARE_OF_BALLON_CLOTH,
        xi.items.IOLITE,
        xi.items.HIGH_QUALITY_EFT_SKIN,
    },
    reward =
    {
        fame    = 30,
        title   = nil,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
