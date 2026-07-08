-----------------------------------
-- Area: Windurst Walls
--  NPC: Tsuaora-Tsuora
-- !pos 71.489 -3.418 -67.809 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KOS_TWICE) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(50)
    else
        player:startEvent(42)
    end
end

return entity
