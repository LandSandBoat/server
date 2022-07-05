-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Greeter Moodgle
-- Novice San d'Oria CRA Branch
-- pos -323.9516 0.0000 -480.2049
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(500)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
