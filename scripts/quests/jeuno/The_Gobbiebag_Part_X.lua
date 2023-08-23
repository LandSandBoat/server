-----------------------------------
-- The Gobbiebag Part X
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
    questId            = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X,
    prerequisite       = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,
    message            = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize = 75,
    fame               = 5,
    tradeStew          = xi.item.BOWL_OF_GOBLIN_STEW_880,

    tradeItems =
    {
        xi.item.MOLYBDENUM_INGOT,
        xi.item.SQUARE_OF_GRIFFON_LEATHER,
        xi.item.SQUARE_OF_FOULARD,
        xi.item.ANGEL_SKIN_ORB,
    },

    reward =
    {
        fame = 30,
        fameArea = xi.quest.fame_area.JEUNO,
        title = xi.title.GRAND_GREEDALOX,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
