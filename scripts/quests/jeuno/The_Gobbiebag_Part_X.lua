-----------------------------------
-- The Gobbiebag Part VIII
-----------------------------------
--  Log ID: 3, Quest ID: 27
--  NPC: Bluffnix:  !pos -43 6 -115 245
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/items")
require("scripts/globals/titles")
-----------------------------------
local GobbieQuest = require("scripts/quests/jeuno/The_Gobbiebag_Part_I")
-----------------------------------

local params =
{
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X,
    prerequisite = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,
    startInventorySize = 75,
    fame = 5,
    trade =
    {
        xi.items.MOLYBDENUM_INGOT,
        xi.items.SQUARE_OF_GRIFFON_LEATHER,
        xi.items.SQUARE_OF_FOULARD,
        xi.items.ANGEL_SKIN_ORB,
    },
    reward =
    {
        fame = 30,
        title = xi.title.GRAND_GREEDALOX,
    }
}

local quest = GobbieQuest:new(params)

return quest
