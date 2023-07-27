-----------------------------------
-- Game Table
-- Basic Chat Text
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10073)
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
