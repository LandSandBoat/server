-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mataligeat
-- !pos -24 0 -60 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- THE REQUIEM
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('TheRequiemCS') == 3
    then
        player:startEvent(142) -- huh? the bard interred inside eldieme?
    end
end

return entity
