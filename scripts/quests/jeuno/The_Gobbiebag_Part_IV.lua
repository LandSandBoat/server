-----------------------------------
-- The Gobbiebag Part IV
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
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV,
    prerequisite = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III,
    startInventorySize = 45,
    fame = 1,
    trade =
    {
        xi.items.CERMET_CHUNK,
        xi.items.DARKSTEEL_INGOT,
        xi.items.SQUARE_OF_SILK_CLOTH,
        xi.items.GOSHENITE,
    },
    reward =
    {
        fame = 30,
        title = nil
    }
}

local quest = GobbieQuest:new(params)

return quest
