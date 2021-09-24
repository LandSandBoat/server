-----------------------------------
-- The Gobbiebag Part VIII
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
    questId             = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII,
    prerequisite        = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII,
    message             = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize  = 65,
    fame                = 4,
    tradeStew           = xi.items.BOWL_OF_GOBLIN_STEW_880,
    tradeItems =
    {
        xi.items.SQUARE_OF_SMILODON_LEATHER,
        xi.items.ELECTRUM_INGOT,
        xi.items.SQUARE_OF_CILICE,
        xi.items.ANGELSTONE,
    },
    reward =
    {
        fame    = 30,
        title   = nil,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
