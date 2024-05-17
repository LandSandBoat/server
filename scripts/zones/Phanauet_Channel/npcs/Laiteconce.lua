-----------------------------------
-- Area: Phanauet Channel
--  NPC: Laiteconce
-- !pos 4.066 -4.5 -10.450 1
-----------------------------------
require('scripts/globals/barge')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, xi.barge.location.PHANAUET_CHANNEL, 2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
