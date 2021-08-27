-----------------------------------
-- Area: Windurst Walls
--  NPC: Nine of Diamonds
-- Type: Standard NPC
-- !pos -76.446 -10.822 107.692 239
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
