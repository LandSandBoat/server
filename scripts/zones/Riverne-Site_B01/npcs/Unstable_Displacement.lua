-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-- Note: entrance for 'Storms of Fate' and 'The Wyrmking Descends'
-- !pos -612.800 1.750 693.190 29
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('StormsOfFate') == 1
    then
        player:startEvent(1)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        player:setCharVar('StormsOfFate', 2)
    end
end

return entity
