-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Nonterene
-- Type: Adventurer's Assistant NPC
-- !pos -6.347 0.000 -11.265 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(523)
    else
        player:startEvent(503)
    end
end

return entity
