-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kuhn Tsahnpri
-- !pos 12.08 2 143.39 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.transport.onDockTimekeeperTrigger(player, xi.transport.routes.OPEN_SEA, 236)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
