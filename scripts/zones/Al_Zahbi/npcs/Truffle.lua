-----------------------------------
-- Area: Al Zahbi
--  NPC: Truffle
-- Type: Standard NPC
-- !pos 18.306 -1 53.761 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(240)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
