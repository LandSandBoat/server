-----------------------------------
-- Area: Metalworks
--  NPC: Topuru-Kuperu
-- Type: Standard NPC
-- !pos 28.284 -17.39 42.269 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(251)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
