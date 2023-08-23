-----------------------------------
-- The Gobbiebag Part IX
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
    questId            = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,
    prerequisite       = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII,
    message            = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize = 70,
    fame               = 5,
    tradeStew          = xi.item.BOWL_OF_GOBLIN_STEW_880,

    tradeItems =
    {
        xi.item.ORICHALCUM_INGOT,
        xi.item.SQUARE_OF_PEISTE_LEATHER,
        xi.item.SQUARE_OF_OIL_SOAKED_CLOTH,
        xi.item.OXBLOOD_ORB,
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
