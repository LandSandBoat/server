-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Laityn
-- Involved In Quest: Recollections
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.RECOLLECTIONS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('recollectionsQuest') == 0
    then
        player:startEvent(10003) -- Option CS for "Recollections"
    else
        player:startEvent(10006)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10003 then
        player:setCharVar('recollectionsQuest', 1)
    end
end

return entity
