-----------------------------------
-- Area: Al Zahbi
--  NPC: Bjibar
-- Type: Standard NPC
-- !pos -105.178 0.999 60.115 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(263)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
