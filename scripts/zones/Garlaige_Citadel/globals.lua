-----------------------------------
-- Zone: Garlaige Citadel (200)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

local GARLAIGE_CITADEL =
{
    --[[..............................................................................................
        click on any of the three Bomb Coal Fragment QMs
        ..............................................................................................]]
    coalQmOnTrigger = function(player, ki)
        if not OLDSCHOOL_G1 then
            local BOMB_COAL = 1090 -- Human readability

            if
                player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_ACCEPTED and
                not player:hasItem(BOMB_COAL) and not player:hasKeyItem(ki)
            then
                npcUtil.giveKeyItem(player, ki)
            end

            if
                player:hasKeyItem(tpz.ki.BOMB_COAL_FRAGMENT1) and
                player:hasKeyItem(tpz.ki.BOMB_COAL_FRAGMENT2) and
                player:hasKeyItem(tpz.ki.BOMB_COAL_FRAGMENT3)
            then
                npcUtil.giveItem(player, BOMB_COAL)
            end

            if player:hasItem(BOMB_COAL) then
                player:delKeyItem(tpz.ki.BOMB_COAL_FRAGMENT1)
                player:delKeyItem(tpz.ki.BOMB_COAL_FRAGMENT2)
                player:delKeyItem(tpz.ki.BOMB_COAL_FRAGMENT3)
            end
        end
    end,
}

return GARLAIGE_CITADEL
