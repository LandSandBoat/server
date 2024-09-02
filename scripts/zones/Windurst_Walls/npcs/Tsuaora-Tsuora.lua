-----------------------------------
-- Area: Windurst Walls
--  NPC: Tsuaora-Tsuora
-- !pos 71.489 -3.418 -67.809 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(50)
    else
        player:startEvent(42)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
