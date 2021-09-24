-----------------------------------
-- Area: Western Adoulin
--  NPC: Clautaire
-- Type: Standard NPC and Quest Giver
-- Starts, Involved with, and Finishes Quest: 'F.A.I.L.ure Is Not an Option'
-- !pos 44 4 -159 256
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/status")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local FINAO = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FAILURE_IS_NOT_AN_OPTION)
    if (FINAO == QUEST_ACCEPTED) then
        if (player:hasKeyItem(xi.ki.HUNK_OF_BEDROCK)) then
            -- Finishing Quest: 'F.A.I.L.ure Is Not an Option'
            player:startEvent(76)
        else
            -- Dialgoue during Quest: 'F.A.I.L.ure Is Not an Option'
            player:startEvent(77)
        end
    elseif ((FINAO == QUEST_AVAILABLE) and (player:getFameLevel(ADOULIN) >= 4) and player:hasKeyItem(xi.ki.FAIL_BADGE)) then
        -- Starting Quest: 'F.A.I.L.ure Is Not an Option'
        player:startEvent(78)
    else
        -- Standard dialogue
        player:startEvent(545)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 78) then
        -- Starting Quest: 'F.A.I.L.ure Is Not an Option'
        player:addQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FAILURE_IS_NOT_AN_OPTION)
    elseif (csid == 76) then
        -- Finishing Quest: 'F.A.I.L.ure Is Not an Option'
        player:delKeyItem(xi.ki.HUNK_OF_BEDROCK)
        player:completeQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FAILURE_IS_NOT_AN_OPTION)
        player:addExp(1000 * xi.settings.EXP_RATE)
        player:addCurrency('bayld', 500 * xi.settings.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 500 * xi.settings.BAYLD_RATE)
        player:addFame(ADOULIN)
    end
end

return entity
