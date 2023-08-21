-----------------------------------
-- The Gobbiebag Part VIII
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
    questId            = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII,
    prerequisite       = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII,
    message            = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize = 65,
    fame               = 4,
    tradeStew          = xi.item.BOWL_OF_GOBLIN_STEW_880,

    tradeItems =
    {
        xi.item.SQUARE_OF_SMILODON_LEATHER,
        xi.item.ELECTRUM_INGOT,
        xi.item.SQUARE_OF_CILICE,
        xi.item.ANGELSTONE,
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
