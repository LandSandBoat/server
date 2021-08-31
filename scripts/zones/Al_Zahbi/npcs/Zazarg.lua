-----------------------------------
-- Area: Al Zahbi
--  NPC: Zazarg
-- Type: Stoneserpent General
-- !pos -41.675 -8 104.452 48
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
