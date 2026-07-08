-----------------------------------
-- Area: Upper Jeuno
--  NPC: Ajithaam
-- !pos -82 0.1 160 244
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getGil() == 300 and
        trade:getItemCount() == 1 and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_COMPLETED and
        player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES
    then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(10177)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        player:startEvent(10176)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10177 then
        player:tradeComplete()
        xi.teleport.to(player, xi.teleport.id.WHITEGATE)
    end
end

return entity
