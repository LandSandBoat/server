-----------------------------------
-- The Gobbiebag Part X
-----------------------------------
--  Log ID: 3, Quest ID: 27
--  NPC: Bluffnix:  !pos -43 6 -115 245
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/titles")
require("scripts/quests/jeuno/helpers")
-----------------------------------
local lowerJeunoID = require("scripts/zones/Lower_Jeuno/IDs")

local params =
{
    questId             = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X,
    prerequisite        = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,
    message             = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize  = 75,
    fame                = 5,
    tradeStew           = xi.items.BOWL_OF_GOBLIN_STEW_880,
    tradeItems =
    {
        xi.items.MOLYBDENUM_INGOT,
        xi.items.SQUARE_OF_GRIFFON_LEATHER,
        xi.items.SQUARE_OF_FOULARD,
        xi.items.ANGEL_SKIN_ORB,
    },
    reward =
    {
        fame    = 30,
        title = xi.title.GRAND_GREEDALOX,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
