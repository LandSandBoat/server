-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Michaela
-- Trophy Engraver
-- Pos -319.3231 -0.0304 -521.0439
-- event 404 405
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(404)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
