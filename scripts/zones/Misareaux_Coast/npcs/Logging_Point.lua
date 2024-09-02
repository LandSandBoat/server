-----------------------------------
-- Area: Misareaux Coast
--  NPC: Logging Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.LOGGING, 555)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.LOGGING)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
