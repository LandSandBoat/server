-----------------------------------
-- Zone: Crawlers' Nest (197)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

local CRAWLERS_NEST =
{
    --[[..............................................................................................
        click on any of the three Exoray Mold Crumb QMs
        ..............................................................................................]]
    moldQmOnTrigger = function(player, ki)
        if not OLDSCHOOL_G1 then
            if
                player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_ACCEPTED and
                not player:hasItem(xi.items.CLUMP_OF_EXORAY_MOLD) and not player:hasKeyItem(ki)
            then
                npcUtil.giveKeyItem(player, ki)
            end

            if
                player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB1) and
                player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB2) and
                player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB3)
            then
                npcUtil.giveItem(player, xi.items.CLUMP_OF_EXORAY_MOLD)
            end

            if player:hasItem(xi.items.CLUMP_OF_EXORAY_MOLD) then
                player:delKeyItem(xi.ki.EXORAY_MOLD_CRUMB1)
                player:delKeyItem(xi.ki.EXORAY_MOLD_CRUMB2)
                player:delKeyItem(xi.ki.EXORAY_MOLD_CRUMB3)
            end
        end
    end,
}

return CRAWLERS_NEST
