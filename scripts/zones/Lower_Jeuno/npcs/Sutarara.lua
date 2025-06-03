-----------------------------------
-- Area: Lower Jeuno
--  NPC: Sutarara
-- Involved in Quests: Tenshodo Membership
-- !pos 30 0.1 -2 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP) then
        player:startEvent(211)
    end
end

return entity
