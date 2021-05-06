-----------------------------------
-- Area: Windurst Walls
--  NPC: Esmeralda
-- Type: Consul. Rep.
-- !pos 128.629 -12.5 139.387 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(268)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
