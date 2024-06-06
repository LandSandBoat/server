-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Gate of the Gods
-- !pos -20 0.1 -283 34
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ApocalypseNigh') == 2
    then
        player:startEvent(4)
    elseif player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.GARDEN_OF_ANTIQUITY then
        player:startEvent(52)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 52 and option == 1 then
        player:setPos(-419.995, 0, 248.483, 191, 35) -- To The Garden of RuHmet
    elseif csid == 4 then
        player:setCharVar('ApocalypseNigh', 3)
        player:setPos(-419.995, 0, 248.483, 191, 35)
    end
end

return entity
