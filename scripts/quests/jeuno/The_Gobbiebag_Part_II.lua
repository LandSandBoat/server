-----------------------------------
-- The Gobbiebag Part II
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
    questId            = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II,
    prerequisite       = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I,
    message            = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize = 35,
    fame               = 1,
    tradeStew          = xi.item.BOWL_OF_GOBLIN_STEW_880,

    tradeItems =
    {
        xi.item.SQUARE_OF_RAM_LEATHER,
        xi.item.MYTHRIL_INGOT,
        xi.item.SQUARE_OF_WOOL_CLOTH,
        xi.item.TURQUOISE,
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
