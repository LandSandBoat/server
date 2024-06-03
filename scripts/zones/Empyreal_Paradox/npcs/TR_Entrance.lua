-----------------------------------
-- Area: Empyreal_Paradox
--  NPC: Transcendental Radiance
-- !pos 540 0 -594 36
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar('PromathiaStatus') == 1
    then
        player:startEvent(2)
    elseif
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ApocalypseNigh') == 3
    then
        player:startEvent(4)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2 then
        player:setCharVar('PromathiaStatus', 2)
    elseif csid == 4 then
        player:setCharVar('ApocalypseNigh', 4)
    end
end

return entity
