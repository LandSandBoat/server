-----------------------------------
-- Area: Abyssea - Tahrongi
--  NPC: Cruor Prospector
-- Type: Cruor NPC
-- !pos 132.000 -75.856 -822.000 15
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

local itemType = xi.abyssea.itemType

local localProspectorItems =
{
    [itemType.ITEM] = xi.abyssea.visionsCruorProspectorItems,

    [itemType.TEMP] = xi.abyssea.visionsCruorProspectorTemps,

    [itemType.KEYITEM] =
    {
    --  Sel     Item                                Cost
        [1] = { xi.ki.MAP_OF_ABYSSEA_TAHRONGI,      3500 },
        [2] = { xi.ki.IVORY_ABYSSITE_OF_SOJOURN,    6000 },
        [3] = { xi.ki.IVORY_ABYSSITE_OF_CONFLUENCE, 4800 },
        [4] = { xi.ki.IVORY_ABYSSITE_OF_EXPERTISE,  4800 },
        [5] = { xi.ki.CLEAR_DEMILUNE_ABYSSITE,       300 },
    },

    [itemType.ENHANCEMENT] = xi.abyssea.visionsCruorProspectorBuffs,
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.visionsCruorProspectorOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.visionsCruorProspectorOnEventFinish(player, csid, option, localProspectorItems)
end

return entity
