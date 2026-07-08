-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Felourie
-- !pos -300.134 -2.999 505.016 2
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.NORTH_LANDING, 20)
end

return entity
