-----------------------------------
-- The Gobbiebag Part V
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
    questId            = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V,
    prerequisite       = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV,
    message            = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize = 50,
    fame               = 3,
    tradeStew          = xi.item.BOWL_OF_GOBLIN_STEW_880,

    tradeItems =
    {
        xi.item.RHODONITE,
        xi.item.PAKTONG_INGOT,
        xi.item.SQUARE_OF_MOBLINWEAVE,
        xi.item.SQUARE_OF_BUGARD_LEATHER,
    },

    reward =
    {
        fame = 30,
        fameArea = xi.quest.fame_area.JEUNO,
        title = xi.title.GREEDALOX,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
