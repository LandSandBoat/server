-----------------------------------
-- The Gobbiebag Part VII
-----------------------------------
--  Log ID: 3, Quest ID: 27
--  NPC: Bluffnix:  !pos -43 6 -115 245
-----------------------------------
require("scripts/globals/items")
require("scripts/quests/jeuno/helpers")
-----------------------------------
local lowerJeunoID = require("scripts/zones/Lower_Jeuno/IDs")

local params =
{
    questId             = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII,
    prerequisite        = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI,
    message             = lowerJeunoID.text.INVENTORY_INCREASED,
    startInventorySize  = 60,
    fame                = 4,
    tradeStew           = xi.items.BOWL_OF_GOBLIN_STEW_880,
    tradeItems =
    {
        xi.items.SQUARE_OF_LYNX_LEATHER,
        xi.items.ADAMAN_INGOT,
        xi.items.SQUARE_OF_RAINBOW_CLOTH,
        xi.items.DEATHSTONE,
    },
    reward =
    {
        fame    = 30,
        title   = nil,
    },
}

local quest = xi.jeuno.helpers.GobbiebagQuest:new(params)

return quest
