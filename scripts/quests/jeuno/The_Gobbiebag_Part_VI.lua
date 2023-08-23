-----------------------------------
-- The Gobbiebag Part VI
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
    questId            = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI,
    prerequisite       = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V,
    message            = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize = 55,
    fame               = 3,
    tradeStew          = xi.item.BOWL_OF_GOBLIN_STEW_880,

    tradeItems =
    {
        xi.item.SHAKUDO_INGOT,
        xi.item.SQUARE_OF_BALLON_CLOTH,
        xi.item.IOLITE,
        xi.item.HIGH_QUALITY_EFT_SKIN,
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
