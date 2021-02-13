-----------------------------------
-- Area: Altar Room
--  NPC: Hooknox
-- Type: Standard NPC
-- !pos -265.248 11.693 -102.547 152
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(46)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
