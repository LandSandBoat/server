-----------------------------------
-- Area: Western Adoulin
--  NPC: Clautaire
-- Starts, Involved with, and Finishes Quest: 'F.A.I.L.ure Is Not an Option'
-- !pos 44 4 -159 256
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local finao = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FAILURE_IS_NOT_AN_OPTION)
    if finao == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.HUNK_OF_BEDROCK) then
            -- Finishing Quest: 'F.A.I.L.ure Is Not an Option'
            player:startEvent(76)
        else
            -- Dialgoue during Quest: 'F.A.I.L.ure Is Not an Option'
            player:startEvent(77)
        end
    elseif
        finao == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.ADOULIN) >= 4 and
        player:hasKeyItem(xi.ki.FAIL_BADGE)
    then
        -- Starting Quest: 'F.A.I.L.ure Is Not an Option'
        player:startEvent(78)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 78 then
        -- Starting Quest: 'F.A.I.L.ure Is Not an Option'
        player:addQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FAILURE_IS_NOT_AN_OPTION)
    elseif csid == 76 then
        -- Finishing Quest: 'F.A.I.L.ure Is Not an Option'
        player:delKeyItem(xi.ki.HUNK_OF_BEDROCK)
        player:completeQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FAILURE_IS_NOT_AN_OPTION)
        player:addExp(1000 * xi.settings.main.EXP_RATE)
        player:addCurrency('bayld', 500 * xi.settings.main.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 500 * xi.settings.main.BAYLD_RATE)
        player:addFame(xi.quest.fame_area.ADOULIN)
    end
end

return entity
