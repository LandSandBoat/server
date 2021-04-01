-----------------------------------
-- Area: Western Adoulin
--  NPC: Vaulois
-- Type: Standard NPC and Quest Giver
-- Starts, Involved with, and Finishes Quest: 'Transporting'
-- !pos 20 0 85 256
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local Transporting = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.TRANSPORTING)
    if ((Transporting == QUEST_ACCEPTED) and (player:getCharVar("Transporting_Status") >= 2)) then
        -- Finishing Quest: 'Transporting'
        player:startEvent(2591)
    elseif ((Transporting == QUEST_AVAILABLE) and (player:getFameLevel(ADOULIN) >= 2)) then
        -- Starts Quest: 'Transporting'
        player:startEvent(2590)
    else
        -- Standard dialogue
        player:startEvent(520)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 2590) then
        -- Starting Quest: 'Transporting'
        player:addQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.TRANSPORTING)
    elseif (csid == 2591) then
        -- Finishing Quest: 'Transporting'
        player:completeQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.TRANSPORTING)
        player:addExp(1000 * EXP_RATE)
        player:addCurrency('bayld', 300 * BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 300 * BAYLD_RATE)
        player:addFame(ADOULIN)
    end
end

return entity
