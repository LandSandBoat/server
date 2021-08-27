-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Felourie
-- Type: Standard NPC
-- !pos -300.134 -2.999 505.016 2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(20)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
