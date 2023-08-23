-----------------------------------
-- Area: Windurst Walls
--  NPC: Nine of Diamonds
-- !pos -76.446 -10.822 107.692 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(263)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
