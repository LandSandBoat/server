-----------------------------------
-- The Gobbiebag Part VIII
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
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII,
    prerequisite = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII,
    startInventorySize = 65,
    fame = 4,
    trade =
    {
        xi.items.SQUARE_OF_SMILODON_LEATHER,
        xi.items.ELECTRUM_INGOT,
        xi.items.SQUARE_OF_CILICE,
        xi.items.ANGELSTONE,
    },
    reward =
    {
        fame = 30,
        title = nil,
    }
}

local quest = GobbieQuest:new(params)

return quest
