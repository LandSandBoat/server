-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Harvesting Point
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helm.type.HARVESTING, 206)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helm.type.HARVESTING)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
