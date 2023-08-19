-----------------------------------
-- Area: Halvung
--  NPC: Mining Point
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helm.type.MINING, 210)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helm.type.MINING)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
