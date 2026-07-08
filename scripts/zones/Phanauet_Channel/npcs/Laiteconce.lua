-----------------------------------
-- Area: Phanauet Channel
--  NPC: Laiteconce
-- !pos 4.066 -4.5 -10.450 1
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.PHANAUET_CHANNEL, 2)
end

return entity
