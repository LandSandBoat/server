-----------------------------------
-- Area: Kazham
--  NPC: Swift
-- Type: Standard NPC
-- !pos 2.017 -5 -1.880 250
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10018)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
