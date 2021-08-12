-----------------------------------
-- The Gobbiebag Part I
-----------------------------------
--  Log ID: 3, Quest ID: 27
--  NPC: Bluffnix:  !pos -43 6 -115 245
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/items")
require("scripts/globals/interaction/quest")
-----------------------------------
local lowerJeunoID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

local params =
{
    questId = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I,
    prerequisite = nil,
    startInventorySize = 30,
    fame = 1,
    trade =
    {
        xi.items.SQUARE_OF_DHALMEL_LEATHER,
        xi.items.STEEL_INGOT,
        xi.items.SQUARE_OF_LINEN_CLOTH,
        xi.items.PERIDOT,
    },
    reward =
    {
        fame = 30,
        title = nil
    }
}

local quest = GobbieQuest:new(params)

return quest
