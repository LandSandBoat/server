-----------------------------------
-- The Gobbiebag Part IX
-----------------------------------
--  Log ID: 3, Quest ID: 27
--  NPC: Bluffnix:  !pos -43 6 -115 245
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/items")
-----------------------------------
local GobbieQuest = require("scripts/quests/jeuno/The_Gobbiebag_Part_I")
-----------------------------------

local params =
{
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,
    prerequisite = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII,
    startInventorySize = 70,
    fame = 5,
    trade =
    {
        xi.items.ORICHALCUM_INGOT,
        xi.items.SQUARE_OF_PEISTE_LEATHER,
        xi.items.SQUARE_OF_OIL_SOAKED_CLOTH,
        xi.items.OXBLOOD_ORB,
    },
    reward =
    {
        fame = 30,
        title = nil,
    }
}

local quest = GobbieQuest:new(params)

return quest
