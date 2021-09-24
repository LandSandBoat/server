-----------------------------------
-- The Gobbiebag Part IV
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
    questId             = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV,
    prerequisite        = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III,
    message             = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize  = 45,
    fame                = 1,
    tradeStew           = xi.items.BOWL_OF_GOBLIN_STEW_880,
    tradeItems =
    {
        xi.items.CERMET_CHUNK,
        xi.items.DARKSTEEL_INGOT,
        xi.items.SQUARE_OF_SILK_CLOTH,
        xi.items.GOSHENITE,
    },
    reward =
    {
        fame    = 30,
        title   = nil,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
