-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Harvesting Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.HARVESTING, 901)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.HARVESTING)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
