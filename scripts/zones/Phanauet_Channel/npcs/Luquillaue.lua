-----------------------------------
-- Area: Phanauet Channel
--  NPC: Luquillaue
-- Type: Adventurer's Assistant
-- !pos 4.066 -4.5 -10.450 1
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.PHANAUET_CHANNEL, 4)
end

return entity
