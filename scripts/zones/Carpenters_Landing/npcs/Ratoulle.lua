-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Ratoulle
-- Type: Adventurer's Assistant
-- !pos -133.959 -3 60.839 2
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.CENTRAL_LANDING, 19)
end

return entity
