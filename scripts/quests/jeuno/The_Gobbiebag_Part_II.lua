-----------------------------------
-- The Gobbiebag Part II
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
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II,
    prerequisite = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I,
    startInventorySize = 35,
    fame = 1,
    trade =
    {
        xi.items.SQUARE_OF_RAM_LEATHER,
        xi.items.MYTHRIL_INGOT,
        xi.items.SQUARE_OF_WOOL_CLOTH,
        xi.items.TURQUOISE,
    },
    reward =
    {
        fame = 30,
        title = nil
    }
}

local quest = GobbieQuest:new(params)

return quest
