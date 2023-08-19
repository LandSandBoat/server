-----------------------------------
-- Area: Jugner Forest
--  NPC: Logging Point
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helm.type.LOGGING, 20)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helm.type.LOGGING)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
