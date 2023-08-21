-----------------------------------
-- The Gobbiebag Part III
-----------------------------------
--  Log ID: 3, Quest ID: 27
--  NPC: Bluffnix:  !pos -43 6 -115 245
-----------------------------------
require('scripts/quests/jeuno/helpers')
-----------------------------------
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local params =
{
    questId            = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III,
    prerequisite       = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II,
    message            = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize = 40,
    fame               = 1,
    tradeStew          = xi.item.BOWL_OF_GOBLIN_STEW_880,

    tradeItems =
    {
        xi.item.SQUARE_OF_BLACK_TIGER_LEATHER,
        xi.item.GOLD_INGOT,
        xi.item.SQUARE_OF_VELVET_CLOTH,
        xi.item.PAINITE,
    },

    reward =
    {
        fame = 30,
        fameArea = xi.quest.fame_area.JEUNO,
        title = nil,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
