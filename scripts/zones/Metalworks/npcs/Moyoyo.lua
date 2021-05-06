-----------------------------------
-- Area: Metalworks
--  NPC: Moyoyo
-- Type: Standard NPC
-- !pos 19.508 -17 26.870 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(252)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
