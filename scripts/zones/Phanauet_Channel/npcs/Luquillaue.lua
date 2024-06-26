-----------------------------------
-- Area: Phanauet Channel
--  NPC: Luquillaue
-- Type: Adventurer's Assistant
-- !pos 4.066 -4.5 -10.450 1
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.PHANAUET_CHANNEL, 3)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
