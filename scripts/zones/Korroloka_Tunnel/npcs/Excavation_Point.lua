-----------------------------------
-- Area: Korroloka Tunnel
--  NPC: Excavation Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helm.type.EXCAVATION, 0)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helm.type.EXCAVATION)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
