-----------------------------------
-- The Gobbiebag Part III
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
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III,
    prerequisite = nil,
    startInventorySize = 40,
    fame = 1,
    trade =
    {
        xi.items.SQUARE_OF_BLACK_TIGER_LEATHER,
        xi.items.GOLD_INGOT,
        xi.items.SQUARE_OF_VELVET_CLOTH,
        xi.items.PAINITE,
    },
    reward =
    {
        fame = 30,
        title = nil
    }
}

local quest = GobbieQuest:new(params)

return quest
