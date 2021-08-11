-----------------------------------
-- The Gobbiebag Part VI
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
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI,
    prerequisite = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V,
    startInventorySize = 55,
    fame = 3,
    trade =
    {
        xi.items.SHAKUDO_INGOT,
        xi.items.SQUARE_OF_BALLON_CLOTH,
        xi.items.IOLITE,
        xi.items.HIGH_QUALITY_EFT_SKIN,
    },
    reward =
    {
        fame = 30,
        title = nil,
    }
}

local quest = GobbieQuest:new(params)

return quest
