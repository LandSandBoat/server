-----------------------------------
-- Area: Southern San dOria
--  NPC: Anxaberoute
-- !pos 108.892 0.000 -49.038 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(886)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
