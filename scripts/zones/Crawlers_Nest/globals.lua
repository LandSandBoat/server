-----------------------------------
-- Zone: Crawlers' Nest (197)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
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
            local EXORAY_MOLD = 1089 -- Human readability

            if
                player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_ACCEPTED and
                not player:hasItem(EXORAY_MOLD) and not player:hasKeyItem(ki)
            then
                npcUtil.giveKeyItem(player, ki)
            end

            if
                player:hasKeyItem(tpz.ki.EXORAY_MOLD_CRUMB1) and
                player:hasKeyItem(tpz.ki.EXORAY_MOLD_CRUMB2) and
                player:hasKeyItem(tpz.ki.EXORAY_MOLD_CRUMB3)
            then
                npcUtil.giveItem(player, EXORAY_MOLD)
            end

            if player:hasItem(EXORAY_MOLD) then
                player:delKeyItem(tpz.ki.EXORAY_MOLD_CRUMB1)
                player:delKeyItem(tpz.ki.EXORAY_MOLD_CRUMB2)
                player:delKeyItem(tpz.ki.EXORAY_MOLD_CRUMB3)
            end
        end
    end,
}

return CRAWLERS_NEST
