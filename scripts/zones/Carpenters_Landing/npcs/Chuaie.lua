-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Chuaie
-- Type: Adventurer's Assistant
-- !pos 231.384 -3 -531.830 2
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.SOUTH_LANDING, 18)
end

return entity
