-----------------------------------
-- The Gobbiebag Part V
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
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V,
    prerequisite = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV,
    startInventorySize = 50,
    fame = 3,
    trade =
    {
        xi.items.RHODONITE,
        xi.items.PAKTONG_INGOT,
        xi.items.SQUARE_OF_MOBLINWEAVE,
        xi.items.SQUARE_OF_BUGARD_LEATHER,
    },
    reward =
    {
        fame = 30,
        title = xi.title.GREEDALOX,
    }
}

local quest = GobbieQuest:new(params)

return quest
