-----------------------------------
-- Area: Phanauet Channel
--  NPC: Ineuteniace
-- Type: Standard NPC
-- Time: Central to South via Newtpool (Different speaking text)
-- Time: South to North via main canal (Different speaking text)
-- !pos 11.701 -3 1.360 1
-- NOTES/TODO: Implement NPCs on boat and dialog
-- Main Canal
-- Message 7355 10 seconds after loading
-- Message 7356 50 seconds later
-- Message 7357 50 seconds later
-- Message 7361 after Fishing Animation 2 min later
-- Message 7370 when talking to him (on both)
-- Message 7358
-- Message 7360 Arriving message then you arrive (about 30 seconds before)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(101)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
